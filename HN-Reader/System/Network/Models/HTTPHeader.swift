//
//  HTTPHeader.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/21.
//

import Foundation

final class HTTPHeader {
    
    enum AuthType: String {
        case bearer = "Bearer"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case html = "text/html"
    }
    
    var authorization: String?
    var authorizationType: AuthType = .bearer
    var contentType: ContentType = .json
}
