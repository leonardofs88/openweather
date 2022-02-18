//
//  ServiceProvider.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

struct ServiceProvider {
    static var service: ServiceProtocol {
        return Service()
    }
    
    static var mockService: ServiceProtocol {
        return MockService()
    }
}
