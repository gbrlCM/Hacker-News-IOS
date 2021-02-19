//
//  Endpoint.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/21.
//

import Foundation

struct Endpoint {
    var path: String
    var headers = [String : String]()
    var data: Data?
    var method: HTTPMethod
    
    init(to path: String, method httpMethod: HTTPMethod = .get) {
        self.path = path
        self.method = httpMethod
    }
    
    init(to path: String, method httpMethod: HTTPMethod = .get, header headerBuilder: (_: HTTPHeader) -> Void) {
        self.path = path
        self.method = httpMethod
        
        let hearder = HTTPHeader()
        headerBuilder(hearder)
        createHeader(from: hearder)
    }
    
    private mutating func createHeader(from header: HTTPHeader) {
        
        if let key = header.authorization {
            headers["Authorization"] = "\(header.authorizationType.rawValue) \(key)"
        }
        
        headers["Content-Type"] = header.contentType.rawValue
    }
}



extension Endpoint {
    
    var request: URLRequest {
        get {
            var request = URLRequest(url: url)
            print(url)
            request.httpMethod = method.rawValue
            
            if !headers.isEmpty {
                request.allHTTPHeaderFields = headers
            }
            
            if let data = self.data {
                request.httpBody = data
            }
            
            return request
        }
    }
    
    private var url: URL {
        get {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "enigmatic-stream-75085.herokuapp.com"
            components.path = "/\(path)"
                        
            guard let url = components.url else {
                preconditionFailure("invalid url components: \(components)")
            }
            print(url)
            return url
        }
    }
}
