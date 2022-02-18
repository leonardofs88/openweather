//
//  ViewController.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {

    var viewModel: ViewModel?
    
    let disposeBag = DisposeBag()
    
    lazy var contentView: UIView = {
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var currentWeatherView: CurrentWeatherView = {
        return CurrentWeatherView.prepare()
    }()

    lazy var forecastView: ForecastView = {
        return ForecastView.prepare()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.loadWeather().subscribe(onNext: { [weak self] weather in
            self?.setupViews(with: weather)
        }, onError: { error in
            
        }).disposed(by: disposeBag)
    }
    
    private func setupViews(with weather: Current) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.view.addSubview(self.contentView)
            self.contentView.snp.makeConstraints { make in
                make.top.bottom.left.right.equalTo(self.view)
            }
            self.currentWeatherView.viewModel = CurrentWeatherViewModel(service: ServiceProvider.service, currentWeather: weather, isDay: weather.isDay)
            self.contentView.addSubview(self.currentWeatherView)
            self.currentWeatherView.snp.makeConstraints { make in
                make.top.equalTo(self.contentView.snp.top).offset(50)
                make.left.equalTo(self.contentView.snp.left)
                make.right.equalTo(self.contentView.snp.right)
                make.height.equalTo(140)
            }
            
            self.forecastView.viewModel = ForecastViewModel(service: ServiceProvider.service)
            self.contentView.addSubview(self.forecastView)
            self.forecastView.snp.makeConstraints { make in
                make.top.equalTo(self.currentWeatherView.snp.bottom).offset(16)
                make.left.equalTo(self.contentView.snp.left)
                make.right.equalTo(self.contentView.snp.right)
                make.bottom.equalTo(self.contentView.snp.bottom)
            }
        }
    }
}
	
