//
//  CatsState.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation

enum CatsState {
    case neverLoaded
    case loadingCats
    case loadedCats([CatResponse])
    case withError(Error)
}
