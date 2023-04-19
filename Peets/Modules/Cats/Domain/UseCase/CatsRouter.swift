//
//  CatsRouter.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation

enum CatsRoute {
    case load
}

protocol CatsRouteable: CatsRoutable {
    var route: CatsRoute { get set }
}

extension CatsRouteable {
    
    var path: any PathDefinitionProtocol {
        switch route {
        case .load: return BreedsPath.path(.breeds)
        }
    }
    
    var method: HttpMethod {
        switch route {
        case .load: return .get
        }
    }
    
    var version: EndpointVersion {
        switch route {
        case .load: return .v1
        }
    }
}

struct CatsRouter: CatsRouteable {
    var route: CatsRoute
}


