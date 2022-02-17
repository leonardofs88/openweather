//
//  Paths.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation
import UIKit

enum Path: String {
    case weather = "/weather"
    case forecast = "/forecast"
    case onecall = "/onecall"
    case image = "/img"
}

enum Scheme: String {
    case http
    case https
}

struct Endpoint {
    let path: Path
    let queryItems: [URLQueryItem]?
    let icon: String?
    
    init(path: Path, queryItems: [URLQueryItem]? = nil, icon: String? = nil) {
        self.path = path
        self.queryItems = queryItems
        self.icon = icon
    }
    
    var buildUrl: URL? {
        var components = URLComponents()
        components.scheme = Scheme.https.rawValue
        components.host = Configuration.baseURL
        switch path {
        case .image:
            components.host = Configuration.baseImageURL
            components.path = (Path.image.rawValue + Configuration.imagePath).replacingOccurrences(of: "<icon>", with: icon ?? "")
            return components.url
        default:
            components.path = Configuration.path + path.rawValue
            components.queryItems = queryItems
            return components.url
        }
    }
}
