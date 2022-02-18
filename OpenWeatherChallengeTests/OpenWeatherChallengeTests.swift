//
//  OpenWeatherChallengeTests.swift
//  OpenWeatherChallengeTests
//
//  Created by Leonardo Soares on 18/02/22.
//

import XCTest
import RxSwift
@testable import OpenWeatherChallenge

class OpenWeatherChallengeTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingCurrent() {
        let weather: [WeatherDescription] = [ WeatherDescription(id: 800, main: "Clear", description: "clear sky", icon: "01d")]
        let main = Main(dt: nil, sunrise: nil, sunset: nil, temp: 282.55, weather: nil)
        let sys = System(type: 1, id: 5122, message: 0.0139, country: "US", sunrise: 1560343627, sunset: 1560396563)
        let current = Current(dt: 1560350645, dtText: nil, weather: weather, main: main, sys: sys)
        let viewModel = ViewModel(service: ServiceProvider.mockService)
        
        viewModel.loadWeather().subscribe { fetchedCurrent in
            XCTAssertEqual(current.main, fetchedCurrent.main)
        } onError: { error in
            
        }.disposed(by: disposeBag)
    }

}
