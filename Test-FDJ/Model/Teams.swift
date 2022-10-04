//
//  Teams.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 29/09/2022.
//

import Foundation

struct Teams : Decodable {
    let teams : [Team]
    
    enum CodingKeys: String, CodingKey {
        case teams="teams"
    }
}

struct Team : Decodable {
    let name:String
    let logo, league, banner, country, description:String?
    
    enum CodingKeys: String, CodingKey {
        case name="strTeam", logo="strTeamBadge", league="strLeague", banner="strTeamBanner", description="strDescriptionEN", country="strCountry"
    }
}
