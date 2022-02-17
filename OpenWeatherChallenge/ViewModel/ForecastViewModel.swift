//
//  ForecastViewModel.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import RxSwift

class ForecastViewModel {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func loadForecast() -> Observable<Forecast> {
        service.fetchForecast().map { $0 }
    }
}
