//
//  ViewModel.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation
import RxSwift

class ViewModel {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func loadWeather() -> Observable<[Current]> {
        service.fetch(type: .weather).map { $0 }
    }
}
