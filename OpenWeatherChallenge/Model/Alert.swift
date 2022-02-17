//
//  Alert.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

struct Alert: Decodable {
    let senderName: String?
    let event: String?
    let start: Date?
    let end: Date?
    let description: String?
    let tags: [String]?
}
