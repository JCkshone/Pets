//
//  CatsDependencies.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import Resolver

public enum CatsDependencies {
    public static func bindComponents() {

        // MARK: - Use Cases
        
        Resolver.register { CatsUseCase() as RequestCatsUseCaseProtocol }

        // MARK: - Network
        
        Resolver.register { NetworkProvider() as NetworkProviderProtocol }

        // MARK: - Stores

        
        Resolver.register {
            Store<CatsState, CatsAction>(
                state: .neverLoaded,
                reducer: CatsReducer.reduce(state:action:),
                middlewares: [
                    CatsMiddleware.executeLoadCats(),
                ]
            )
        }.scope(.cached)
        
    
    }
}
