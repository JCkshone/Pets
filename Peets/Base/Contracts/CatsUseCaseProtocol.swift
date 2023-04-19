//
//  CatsUseCaseProtocol.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import Combine

protocol RequestCatsUseCaseProtocol: AnyObject {
    func execute() -> AnyPublisher<[CatResponse], Error>
}
