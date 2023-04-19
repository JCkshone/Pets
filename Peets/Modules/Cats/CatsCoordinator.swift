//
//  CatsCoordinator.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import SwiftUI

public enum CatsCoordinator: Router {
    case list
    
    public var transition: NavigationType {
        switch self {
        default: return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .list:
            CatsScreenView()
        }
    }
}
