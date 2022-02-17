//
//  Current.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

struct Current: Decodable {
    let dt: Double?
    let dtText: String?
    let weather: [WeatherDescription]?
    let main: Main?
    let sys: System?
    
    var formattedDate: String {
       let date = Date(timeIntervalSince1970: self.dt ?? 0.0)
       let dateFormatter = DateFormatter()
       dateFormatter.timeStyle = DateFormatter.Style.medium
       dateFormatter.dateStyle = DateFormatter.Style.medium
       dateFormatter.timeZone = .current
       return dateFormatter.string(from: date)
    }
    
    var isDay: Bool {
        if let sunrise = self.sys?.sunrise, let sunset = self.sys?.sunset {
            let current = Date(timeIntervalSince1970: self.dt ?? 0.0)
            let sunrise = Date(timeIntervalSince1970: sunrise)
            let sunset = Date(timeIntervalSince1970: sunset)
    
            if current > sunrise && current < sunset {
                return true
            } else {
                return false
            }
        }
        return true
    }
}
