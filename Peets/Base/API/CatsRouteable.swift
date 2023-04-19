//
//  CatsRouteable.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import Resolver

public typealias HttpHeaders = [String: String]
public typealias HttpQueryParams = [String: String]

public protocol BaseUrl {
    var baseUrl: URL { get }
}

public enum EndpointVersion {
    case v1
    
    var definition: String {
        String(describing: self)
    }
}

struct ErrorMessageResponse: Decodable {
    let message: String
}

public struct ApiErrorResponse<T: Decodable>: Decodable {
    public let error: T
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}

public struct ApiResponse<T: Decodable>: Decodable {
    public let response: T
    
    enum CodingKeys: String, CodingKey {
        case response = "data"
    }
}

public protocol CatsRoutable: BaseUrl {
    var path: any PathDefinitionProtocol { get }
    var queryParams: HttpQueryParams { get }
    var aditionalHeaders: HttpHeaders { get }
    var method: HttpMethod { get }
    var body: Encodable? { get }
    var version: EndpointVersion { get }
}

public extension CatsRoutable {
    var queryParams: HttpQueryParams { [:] }
    var aditionalHeaders: HttpHeaders { [:] }
    var version: EndpointVersion { .v1 }
    var body: Encodable? { nil }
    
    var baseUrl: URL {
        guard let url = URL(string: "https://api.thecatapi.com") else { fatalError("Base url could not be configured.") }
        return url
    }
    
    var headers: HttpHeaders {
        return [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json; charset=utf-8",
        ]
    }
    
    func buildRequest() throws -> URLRequest {
        var urlRequest = URLRequest(
            url: buildUrl()
        )
        urlRequest.httpMethod = method.rawValue
        
        if let body = body, (method == .post || method == .put) {
            let body = try JSONEncoder().encode(body)
            try body.print()
            urlRequest.httpBody = body
        }
        
        headers.forEach { header in
            urlRequest.setValue(
                header.value,
                forHTTPHeaderField: header.key
            )
        }
        
        aditionalHeaders.forEach { aditionalHeader in
            urlRequest.setValue(
                aditionalHeader.value,
                forHTTPHeaderField: aditionalHeader.key
            )
        }
        return urlRequest
    }

}


extension CatsRoutable {
    func buildUrl() -> URL {
        guard let url = URL(
            string: baseUrl.appendingPathComponent(
                "/\(version.definition)/\(path.description)"
            ).description
        ) else {
            return URL(fileURLWithPath: .empty)
        }
        
        var urlComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        )
        
        urlComponents?.queryItems = queryParams.compactMap {
            return URLQueryItem(
                name: $0.key, value: $0.value
            )
        }
        
        return urlComponents?.url ?? URL(fileURLWithPath: .empty)
    }
}

extension Data {
    func print() throws {
        guard let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
            return
        }
        debugPrint("[HTTP RESPONSE] ", json)
    }
    
    mutating func append(_ string: String) {
       if let data = string.data(using: .utf8) {
          append(data)
           Swift.print("data======>>>",data)
       }
    }
}
