//
//  Configuration.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

enum Configuration {
    static let baseURL = "api.openweathermap.org"
    static let baseImageURL = "openweathermap.org"
    static let path = "/data/2.5"
    static let apiKey = info["ApiKey"] as? String
    static let lon = "-8.61"
    static let lat = "41.14"
    static let cityID = "2735943"
    static let unit = "metric"
    static let imagePath = "/wn/<icon>@2x.png"
    
    private static var info : [String: Any] {
        if let dict = Bundle.main.infoDictionary {
              return dict
          } else {
              fatalError("Info Plist file not found")
          }
    }
}
