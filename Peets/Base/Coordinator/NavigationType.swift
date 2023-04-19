//
//  NavigationType.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import UIKit

public enum NavigationType {
    case `default`
    case push
    case presentModally
    case presentFullscreen
    case modalFullScreen
}

extension NavigationType {
    var presentationStyle: UIModalPresentationStyle {
        switch self {
        case .push, .default: return .none
        case .presentModally: return .formSheet
        case .presentFullscreen: return .fullScreen
        case .modalFullScreen: return .overFullScreen
        }
    }
    
    var transitionStyle: UIModalTransitionStyle {
        switch self {
        case .push, .default: return .flipHorizontal
        case .presentModally: return .coverVertical
        case .presentFullscreen: return .coverVertical
        case .modalFullScreen: return .crossDissolve
        }
    }
}
