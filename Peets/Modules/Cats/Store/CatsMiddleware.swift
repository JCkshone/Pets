//
//  CatsMiddleware.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import Resolver
import Combine

private typealias Response = CatResponse

enum CatsMiddleware {
    @Injected private static var catsUseCase: RequestCatsUseCaseProtocol
        
    static func executeLoadCats() -> Middleware<CatsState, CatsAction> {
        { _, action in
            guard case .loadCats = action else { return Empty().eraseToAnyPublisher() }
        
            return catsUseCase
                .execute()
                .map { .loadCatsSuccess($0) }
                .catch { log(error: $0, dispatch: .loadCatsFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension CatsMiddleware {
    private static func log(error: Error, dispatch: CatsAction) -> AnyPublisher<CatsAction, Never> {
        debugPrint("[\(String(describing: self))] Causal: \(error)")
        return Just(dispatch).setFailureType(to: Never.self).eraseToAnyPublisher()
    }
}
