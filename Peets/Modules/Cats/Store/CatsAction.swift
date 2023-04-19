//
//  CatsAction.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation

enum CatsAction {
    case loadCats
    case loadCatsSuccess(_ response: [CatResponse])
    case loadCatsFailure(_ error: Error)
}
