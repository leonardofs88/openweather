//
//  Main.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

struct Main: Decodable, Equatable {
    let dt: Double?
    let sunrise: Double?
    let sunset: Double?
    let temp: Double?
    let weather: [WeatherDescription]?
    
    var temperature: String {
        return String(format: "%.1f º", self.temp ?? 00)
    }
    
    var formattedDate: String {
        let date = Date(timeIntervalSince1970: self.dt ?? 0.0)
       let dateFormatter = DateFormatter()
       dateFormatter.timeStyle = DateFormatter.Style.medium
       dateFormatter.dateStyle = DateFormatter.Style.medium
       dateFormatter.timeZone = .current
       return dateFormatter.string(from: date)
    }
    
    var isDay: Bool {
        let current = Date(timeIntervalSince1970: self.dt ?? 0.0)
        let sunrise = Date(timeIntervalSince1970: self.sunrise ?? 0.0)
        let sunset = Date(timeIntervalSince1970: self.sunset ?? 0.0)
        
        if current > sunrise && current < sunset {
            return true
        } else {
            return false
        }
    }
}
