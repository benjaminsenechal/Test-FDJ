//
//  TeamState.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 29/09/2022.
//

import Foundation
import UIKit

struct TeamState {
    let name: String
    let logo, league, banner, country, description:String?
    
    init(logo: String?, name: String, league:String?, banner:String?, country:String?, description:String?) {
        self.logo = logo
        self.name = name
        self.league = league
        self.banner = banner ?? "https://fasttechnologies.com/wp-content/uploads/2017/01/placeholder-banner.png"
        self.country = country
        self.description = description
    }

    
    enum Action {
        case refresh([TeamState])
    }
}
