//
//  Current.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

struct Current: Decodable, Equatable {
    
    let dt: Double?
    let dtText: String?
    let weather: [WeatherDescription]?
    let main: Main?
    let sys: System?
    
    var fullDate: String {
       let date = Date(timeIntervalSince1970: self.dt ?? 0.0)
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       dateFormatter.timeZone = .current
       return dateFormatter.string(from: date)
    }
    
    var day: String {
       let date = Date(timeIntervalSince1970: self.dt ?? 0.0)
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
       dateFormatter.timeZone = .current
       return dateFormatter.string(from: date)
    }
    
    var hour: String {
       let date = Date(timeIntervalSince1970: self.dt ?? 0.0)
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
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
    
    static func == (lhs: Current, rhs: Current) -> Bool {
        return lhs.dt == rhs.dt && lhs.dtText == rhs.dtText && lhs.weather == rhs.weather && lhs.main == rhs.main && lhs.sys == rhs.sys
    }
}
