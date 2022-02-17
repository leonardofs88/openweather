//
//  HourlyWeather.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

struct HourlyWeather: Decodable {
    let cod: Int?
    let message: Int?
    let list: [Current]?
    let surise: Date?
    let sunset: Date?
    let timezone: TimeZone?
    let country: String?
}
