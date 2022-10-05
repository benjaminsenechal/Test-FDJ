//
//  TeamPresenter.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 29/09/2022.
//

import Foundation
import Combine
import UIKit

protocol LeaguesViewPresenter {
    init(_ viewController:LeagueViewController)
    func getTeams(name:String)
}

class LeaguesPresenter : LeaguesViewPresenter {
    private var cancellables = [AnyCancellable]()
    private weak var viewController : LeagueViewController?
    let teamState: CurrentValueSubject<[TeamState], Never> = CurrentValueSubject([TeamState]())
    
    required init(_ viewController:LeagueViewController) {
        self.viewController = viewController
        
        self.teamState.sink(receiveValue: { [weak self] teamState in
            self?.viewController?.refreshLeagues(teamStateAction: TeamState.Action.refresh(teamState))
        }).store(in: &cancellables)
        
    }
    
    func getTeams(name:String) {
        FDJApi.searchTeams(name: name)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.teamState.send([TeamState]())
                case .finished: return
                }
            } receiveValue: { [weak self] teams in
                let teamsState = teams.teams.map { team in
                    return TeamState(logo: team.logo, name: team.name, league: team.league, banner: team.banner, country: team.country, description: team.description)
                }
                self?.teamState.send(teamsState)
            }.store(in: &cancellables)
    }
    

    
}

