//
//  NetworkProvider.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation

protocol NetworkProviderProtocol {
    var agent: NetworkAgentProtocol { get }
}

public final class NetworkProvider: NetworkProviderProtocol {
    var agent: NetworkAgentProtocol
    init() { agent = NetworkAgent() }
}

