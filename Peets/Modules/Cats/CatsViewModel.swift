//
//  CatsViewModel.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import Combine
import Resolver


final class CatsViewModel: ObservableObject {
    @Injected var store: Store<CatsState, CatsAction>
    @Published var cats: [CatResponse] = []
    private var cancellable = Set<AnyCancellable>()
    
    deinit {
        cancellable.removeAll()
    }
    
    func viewDidLoad() {
        suscribers()
        dispatchLoad()
    }
    
    func dispatchLoad() {
        store.dispatch(.loadCats)
    }
}

private extension CatsViewModel {
    func suscribers() {
        store.$state.sink { [weak self] state in
            if case let .loadedCats(response) = state {
                self?.cats = response
            }
        }.store(in: &cancellable)
    }
}
