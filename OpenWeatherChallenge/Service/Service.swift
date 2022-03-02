//
//  Service.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation
import RxSwift

enum FetchType: String {
    case weather
    case forecast
    case icon
}

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
    case unknown
    case decode(Error)
    
    var errorDescription: String {
            return "Erro while trying to conver data."
        }
}

protocol ServiceProtocol {
    func fetch(type: FetchType) -> Observable<[Current]>
    func loadImage(icon: String) -> Observable<Data>
}

class Service: ServiceProtocol {
    func fetch(type: FetchType) -> Observable<[Current]> {
        var currentList: [Current] = []
        return Observable.create { [weak self] observer -> Disposable in
            guard let builtURL = self?.buildURL(for: type) else {
                observer.onError(APIError.url)
                return Disposables.create { }
            }
            
            let task = URLSession.shared.dataTask(with: builtURL) { data, _, error in
                guard let data = data else {
                    if let err = error {
                        observer.onError(APIError.decode(err))
                    } else {
                        observer.onError(APIError.unknown)
                    }
                    return
                }
                
                do {
                    switch type {
                    case .weather:
                        let results = try JSONDecoder().decode(Current.self, from: data)
                        currentList.append(results)
                    default:
                        let results = try JSONDecoder().decode(Forecast.self, from: data)
                        if let list = results.list {
                            currentList = list                            
                        }
                    }
                    observer.onNext(currentList)
                    observer.onCompleted()
                    
                } catch {
                    observer.onError(APIError.decode(error))
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
                observer.onError(APIError.unknown)
                return Disposables.create { }
            }
            guard let builtURL = self.buildURL(for: .icon, icon: icon) else {
                observer.onError(APIError.url)
                return Disposables.create { }
            }
            
            let task = URLSession.shared.dataTask(with: builtURL) { data, _, error in
                guard let data = data else {
                    if let err = error {
                        observer.onError(APIError.decode(err))
                    } else {
                        observer.onError(APIError.unknown)
                    }
                    return
                }
                observer.onNext(data)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    private func buildURL(for type: FetchType, icon: String? = nil) -> URL? {
        switch type {
        case .weather:
            let queryItems = [
                URLQueryItem(name: "lon", value: Configuration.lon),
                URLQueryItem(name: "lat", value: Configuration.lat),
                URLQueryItem(name: "appid", value: Configuration.apiKey),
                URLQueryItem(name: "units", value: Configuration.unit),
            ]
            let path = Endpoint(path: .weather, queryItems: queryItems)
            return path.buildUrl
        case .forecast:
            let queryItems = [
                URLQueryItem(name: "id", value: Configuration.cityID),
                URLQueryItem(name: "appid", value: Configuration.apiKey),
                URLQueryItem(name: "units", value: Configuration.unit),
            ]
            let path = Endpoint(path: .forecast, queryItems: queryItems)
            return path.buildUrl
        case .icon:
            return Endpoint(path: .image, icon: icon).buildUrl
        }
    }
    
}
