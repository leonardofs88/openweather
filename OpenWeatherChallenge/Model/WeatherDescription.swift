//
//  Weather.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

struct WeatherDescription: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
