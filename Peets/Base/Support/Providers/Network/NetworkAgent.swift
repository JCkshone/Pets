//
//  NetworkAgent.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Combine
import Resolver
import Foundation

typealias Output = URLSession.DataTaskPublisher.Output

protocol NetworkAgentProtocol {
    func run<T: Decodable>(_ router: CatsRoutable) -> AnyPublisher<T, Error>
}

final class NetworkAgent: NetworkAgentProtocol {}

// MARK: - Combine implemention base

extension NetworkAgent {
    func run<T: Decodable>(
        _ router: CatsRoutable
    ) -> AnyPublisher<T, Error> {
        do {
            let request = try router.buildRequest()
            return URLSession.shared
                .dataTaskPublisher(for: request)
                .tryMap { try self.handleDataTaskOutput($0) }
                .tryMap { try self.handleDataMapper(statusCode: $0, with: $1, to: router) }
                .mapError { self.handleDataTaskError($0)}
                .eraseToAnyPublisher()
        } catch {
            return Fail<T, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: - Combine handle response

extension NetworkAgent {
    func handleDataTaskOutput(
        _ output: Output
    ) throws -> (Int, Data) {
        debugPrint("[HTTP REQUEST]", output.response.url as Any)
        debugPrint("[HTTP STATUS CODE]", (output.response as? HTTPURLResponse)?.statusCode ?? .zero)
        
        guard let httpResponse = output.response as? HTTPURLResponse else {
            throw CatsError.Api.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return (httpResponse.statusCode, output.data)
        default:
            if let resultDecode: ApiErrorResponse<ErrorMessageResponse> = decode(output.data) {
                throw CatsError.Api.serverError(resultDecode.error)
            } else {
                throw CatsError.Api.undefined
            }
        }
    }
    
    func handleDataTaskError(
        _ error: Error
    ) -> CatsError.Api {
        if let error = error as? URLError {
            if error.code == .notConnectedToInternet {
                return CatsError.Api.noInternet
            }
            return CatsError.Api.timeOut
        }
        return error as? CatsError.Api ?? .undefined
    }
    
    func handleDataMapper<T: Decodable>(
        statusCode: Int,
        with data: Data,
        to router: CatsRoutable
    ) throws -> T {
        try data.print()
        
        guard let resultDecode: T = decode(data) else {
            throw CatsError.Api.invalidDecodableModel
        }

        return resultDecode
    }
}

extension NetworkAgent {
    func decode<T: Decodable>(_ data: Data) -> T? {
        var response: T?
        do {
            response = try JSONDecoder().decode(T.self, from: data)
        } catch {
            debugPrint("[HTTP MAPPER] [ERROR]", String(describing: T.self), error)
        }
        debugPrint("[HTTP MAPPER]", String(describing: T.self))
        return response
    }
}

