//
//  Coordinator.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import SwiftUI

class Coordinator<R: Router>: ObservableObject {
    public let navigationController: UINavigationController
    public let startingRoute: R?
    
    public init(
        navigationController: UINavigationController = .init(),
        startingRoute: R? = nil
    ) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    public func show(
        _ route: R,
        animated: Bool = true) {
            let view = route.view()
            let viewWithCoordinator = view.environmentObject(self)
            let viewController = PeetsHostingController(rootView: viewWithCoordinator)

            if case .push = route.transition {
                
                navigationController.view.layer.add(
                    Transitions.fade,
                    forKey: nil
                )
                navigationController.pushViewController(
                    viewController,
                    animated: false
                )
                
                return
            }
            
            if case .default = route.transition {
                navigationController.pushViewController(
                    viewController,
                    animated: true
                )
                return
            }
            
            viewController.modalPresentationStyle = route.transition.presentationStyle
            viewController.modalTransitionStyle = route.transition.transitionStyle
            navigationController.present(
                viewController,
                animated: true
            )
        }
    
    public func pop(animated: Bool = false) {
        if !animated {
            navigationController.view.layer.add(
                Transitions.fade,
                forKey: nil
            )
        }
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = false) {
        if !animated {
            navigationController.view.layer.add(
                Transitions.fade,
                forKey: nil
            )
        }
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
}

public enum Transitions {
    public static var fade: CATransition = {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        return transition
    }()
}
