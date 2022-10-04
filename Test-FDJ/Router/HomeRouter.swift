//
//  HomeRouter.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 04/10/2022.
//

import Foundation
import UIKit

class HomeRouter {
    weak var leagueViewController : LeagueViewController?
    
    func routeToDetail(team:TeamState) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let teamDetailViewController = storyBoard.instantiateViewController(withIdentifier: TeamDetailViewController.identifier) as! TeamDetailViewController
        teamDetailViewController.set(teamName: team.name)
        self.leagueViewController?.navigationController?.pushViewController(teamDetailViewController, animated: true)
    }

}
