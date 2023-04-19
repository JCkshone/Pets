//
//  CatsEnums.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation

extension String {
    static let empty = ""
}

public protocol PathDefinitionProtocol {
    associatedtype Path
    var description: String { get }
}


public enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

public enum CatsError {
    enum Api: Error {
        case invalidUrl(url: String)
        case undefined
        case noInternet
        case invalidResponse
        case timeOut
        case invalidDecodableModel
        case invalidObject
        case serverError(ErrorMessageResponse)
        
        var message: String {
            if case let .serverError(error) = self {
                return error.message
            }
            if case .noInternet = self {
                return "Revisa tu conexión a internet e intenta más tarde"
            }
            return .empty
        }
    }
    
    enum CoreData: Error {
        case objectNotFound
    }
    
    enum DataMapper: Error {
        case invalidMapper
    }
}

public enum PathsDefinition {
    
    public enum Breeds: String {
        case breeds = "breeds"
    }
    
}

public enum BreedsPath: PathDefinitionProtocol {
    public typealias Path = PathsDefinition.Breeds
    
    case path(Path)
    
    public var description: String {
        if case let .path(aditionalPath) = self {
            return aditionalPath.rawValue
        }
        return .empty
    }
}


