//
//  CurrentViewController.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CurrentWeatherView: BaseView {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    
    var viewModel: CurrentWeatherViewModel? {
        didSet {
            self.configureView()
        }
    }
    
    class func prepare() -> CurrentWeatherView {
        let view = CurrentWeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func configureView() {
        self.currentTempLabel.text = viewModel?.formattedTemperature
        if let icon = viewModel?.icon, let isDay = viewModel?.isDay {
            viewModel?.loadImage(icon: icon).observe(on: MainScheduler.instance).bind(to: self.currentWeatherIcon.rx.image).disposed(by: disposeBag)
            self.setViewBackgroundImage(isDay: isDay)
        }
    }
    
    func setViewBackgroundImage(isDay: Bool) {
        var imageView : UIImageView!
        let background = isDay ? UIImage(named: "day") : UIImage(named: "night")
        
        imageView = UIImageView(frame: .zero)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
