//
//  Service.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation
import RxSwift

enum Exclude: String {
    case current
    case minutely
    case hourly
    case daily
    case alerts
}

enum APIError: LocalizedError {
    case server
    case url
    case empty
    case decode(Error)
    
    var errorDescription: String {
            return "Erro while trying to conver data."
        }
}

protocol ServiceProtocol {
    func fetchWeather() -> Observable<Current>
    func fetchForecast() -> Observable<Forecast>
    func loadImage(icon: String) -> Observable<Data>
}

class Service: ServiceProtocol {
    func fetchWeather() -> Observable<Current> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let builtURL = self?.buildFetchCurrentWeatherURL() else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
            
            let task = URLSession.shared.dataTask(with: builtURL) { data, _, error in
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(Current.self, from: data)
                    observer.onNext(results)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchForecast() -> Observable<Forecast> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let builtURL = self?.buildForecastURL() else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
            
            let task = URLSession.shared.dataTask(with: builtURL) { data, _, error in
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(Forecast.self, from: data)
                    observer.onNext(results)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func loadImage(icon: String) -> Observable<Data> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
            guard let builtURL = self.buildIconUrl(icon: icon) else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
            
            let task = URLSession.shared.dataTask(with: builtURL) { data, _, error in
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                observer.onNext(data)
                
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    private func buildFetchCurrentWeatherURL() -> URL? {
        let queryItems = [
            URLQueryItem(name: "lon", value: Configuration.lon),
            URLQueryItem(name: "lat", value: Configuration.lat),
            URLQueryItem(name: "appid", value: Configuration.apiKey),
            URLQueryItem(name: "units", value: Configuration.unit),
        ]
        let path = Endpoint(path: .weather, queryItems: queryItems)
        return path.buildUrl
    }
    
    private func buildForecastURL() -> URL? {
        let queryItems = [
            URLQueryItem(name: "id", value: Configuration.cityID),
            URLQueryItem(name: "appid", value: Configuration.apiKey),
            URLQueryItem(name: "units", value: Configuration.unit),
        ]
        let path = Endpoint(path: .forecast, queryItems: queryItems)
        return path.buildUrl
    }
    
    private func buildIconUrl(icon: String) -> URL? {
        return Endpoint(path: .image, icon: icon).buildUrl
    }
}
