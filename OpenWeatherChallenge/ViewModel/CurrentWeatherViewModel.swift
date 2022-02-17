//
//  CurrentWeatherViewModel.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import UIKit
import RxSwift

class CurrentWeatherViewModel {
    var currentWeather: Current?
    let service: ServiceProtocol
    let isDay: Bool?
    
    var formattedTemperature: String {
        return String(format: "%.1f º", currentWeather?.main?.temp ?? 0.0).replacingOccurrences(of: ".", with: ",")
    }
    
    var icon: String? {
        return currentWeather?.weather?.first?.icon
    }
    
    init(service: ServiceProtocol, currentWeather: Current?, isDay: Bool?) {
        self.service = service
        self.currentWeather = currentWeather
        self.isDay = isDay
    }
    
    func loadImage(icon: String) -> Observable<UIImage?> {
        service.loadImage(icon: icon).map { UIImage(data: $0) }
    }
}
