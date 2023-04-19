//
//  AppRegistry.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation

class CatsRegistry: NSObject, AppLifecycleProtocol {
    override init() {
        super.init()
        CatsDependencies.bindComponents()
    }
}

struct AppRegistry {
    var registry: [AppLifecycleProtocol]
    
    init() {
        self.registry = [
            CatsRegistry()
        ]
    }
    
    func getRegistry() -> [AppLifecycleProtocol] { registry }
}
