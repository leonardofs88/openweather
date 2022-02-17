//
//  Forecast.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation

struct Forecast: Decodable {
    let list: [Current]?
}
