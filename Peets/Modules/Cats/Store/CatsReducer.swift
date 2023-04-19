//
//  CatsReducer.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation

enum CatsReducer {
    static func reduce(state: inout CatsState, action: CatsAction) {
        switch action {
        case .loadCats:
            state = .loadingCats
            
        case let .loadCatsSuccess(response):
            state = .loadedCats(response)
            
        case let .loadCatsFailure(error):
            state = .withError(error)
        }
    }
}
