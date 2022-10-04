//
//  FDJApi.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 29/09/2022.
//

import Foundation
import Combine

enum FDJApi {
    static let network = Network()
    static let base = URL(string: "https://www.thesportsdb.com/api/v1/json/50130162")!
}

extension FDJApi {
    static func searchTeams(name:String) -> AnyPublisher<Teams, Error> {
        let request = URLRequest(url: base.appending(path: "search_all_teams.php").appending(queryItems: [URLQueryItem(name: "l", value: name) ]))
        return network.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func searchTeam(name:String) -> AnyPublisher<Teams, Error> {
        let request = URLRequest(url: base.appending(path: "searchteams.php").appending(queryItems: [URLQueryItem(name: "t", value: name) ]))
        return network.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func searchPlayers(id:String) -> AnyPublisher<Teams, Error> {
        let request = URLRequest(url: base.appending(path: "lookup_all_players.php").appending(queryItems: [URLQueryItem(name: "t", value: id) ]))
        return network.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
