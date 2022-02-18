//
//  MockService.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation
import RxSwift

class MockService: ServiceProtocol {
    func fetchWeather() -> Observable<Current> {
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: "Current", ofType: "json") else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
                
            do {
                let results = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let current = try JSONDecoder().decode(Current.self, from: results)
                observer.onNext(current)
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create {  }
        }
    }
    
    func fetchForecast() -> Observable<Forecast> {
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: "Forecast", ofType: "json") else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
                
            do {
                let results = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let forecast = try JSONDecoder().decode(Forecast.self, from: results)
                observer.onNext(forecast)
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create {  }
        }
    }
    
    func loadImage(icon: String) -> Observable<Data> {
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: "02d@2x", ofType: "png") else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
                
            do {
                let results = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                observer.onNext(results)
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create {  }
        }
    }
    
}
