//
//  MainDaily.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation


struct MainDaily: Decodable {
    let dt: Date?
    let moonPhase: Double?
    let temp: Temperature?
    let feelsLike: Temperature?
    let pressure: Int?
    let humidity: Int?
    let dewPoint: Double?
    let uvi: Double?
    let clouds: Int?
    let windSpeed: Int?
    let windDeg: Int?
    let weather: [WeatherDescription]
    let precipitation: Double?
    let pop: Double?
    let rain: Double?
}
