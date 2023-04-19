//
//  CatsUseCase.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import Combine
import Resolver

class CatsUseCase: RequestCatsUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute() -> AnyPublisher<[CatResponse], Error> {
        network.agent.run(
            CatsRouter(route: .load)
        )
    }
}
