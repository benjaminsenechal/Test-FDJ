//
//  TeamPresenter.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 30/09/2022.
//

import Foundation
import Combine
import UIKit

class TeamPresenter {
    private var cancellables = [AnyCancellable]()
    private weak var viewController : TeamDetailViewController?
    let teamState: CurrentValueSubject<TeamState?, Never> = CurrentValueSubject(nil)

    
    init(_ viewController : TeamDetailViewController) {
        self.viewController = viewController
        
        self.teamState.sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] teamState in
            guard let teamState else { return }
            self?.viewController?.updateUI(teamState: teamState)
        }).store(in: &cancellables)
    }
    
    func getTeam(name:String) {
        FDJApi.searchTeam(name: name)
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] teams in
                let team = teams.teams.filter { $0.name == name }.first
                guard let team else { return }
                self?.teamState.send(TeamState(logo: team.logo, name: team.name, league: team.league, banner: team.banner, country: team.country, description: team.description))
            }.store(in: &cancellables)
    }
}

