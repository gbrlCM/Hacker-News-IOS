//
//  Combine+URLSession.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/21.
//

import Foundation
import Combine

extension URLSession {
    
    func dataTaskDecodedPublisher<T: Decodable>(for endpoint: Endpoint, decodeTo model: T.Type) -> AnyPublisher<T, Error> {
        
            return self.dataTaskPublisher(for: endpoint.request)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
}
