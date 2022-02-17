//
//  Main.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

struct Main: Decodable {
    let dt: Double?
    let sunrise: Double?
    let sunset: Double?
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let dewPoint: Double?
    let uvi: Double?
    let clouds: Int?
    let visibility: Int?
    let windSpeed: Int?
    let windDeg: Int?
    let weather: [WeatherDescription]?
    let precipitation: Double?
    let pop: Double?
    
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
