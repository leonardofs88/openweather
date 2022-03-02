//
//  MockService.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation
import RxSwift

class MockService: ServiceProtocol {
    func fetch(type: FetchType) -> Observable<[Current]> {
        var currentList: [Current] = []
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: type.rawValue, ofType: "json") else {
                observer.onError(APIError.url)
                return Disposables.create { }
            }
                
            do {
                let results = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                switch type {
                case .weather:
                    let current = try JSONDecoder().decode(Current.self, from: results)
                    currentList.append(current)
                default:
                    let current = try JSONDecoder().decode([Current].self, from: results)
                    currentList = current
                }
                observer.onNext(currentList)
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
