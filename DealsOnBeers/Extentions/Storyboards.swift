//
//  Storyboards.swift
//  DealsOnBeers
//
//  Created by fakhreddine chaabani on 3/3/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import Foundation

// Storyboards
enum Storyboards: CustomStringConvertible {
    case LOGIN
    case MAIN
    case ENROUTE
    case MENU
    case POPUPS
    case SETTINGS
    case HISTORY
    case FAVORITES
    case PROFILE
    case ACTIVE
    
    var description : String {
        switch self {
        case .LOGIN: return "Login";
        case .MAIN: return "Main";
        case .ENROUTE: return "Enroute";
        case .MENU: return "Menu";
        case .POPUPS: return "Popup";
        case .SETTINGS: return "Settings";
        case .HISTORY: return "History";
        case .FAVORITES: return "Favorites";
        case .PROFILE: return "Profile";
        case .ACTIVE: return "Active";
        }
    }
}

