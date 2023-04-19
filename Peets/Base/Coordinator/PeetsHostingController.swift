//
//  PeetsHostingController.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import SwiftUI

class PeetsHostingController<Content>: UIHostingController<AnyView> where Content : View {

  public init(rootView: Content) {
      super.init(rootView: AnyView(rootView.navigationBarHidden(true)))
  }

  @objc required dynamic init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
