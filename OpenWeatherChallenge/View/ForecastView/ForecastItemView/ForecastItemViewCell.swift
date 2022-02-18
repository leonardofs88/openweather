//
//  ForecastItemView.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import UIKit
import RxSwift

class ForecastItemViewCell: UICollectionViewCell {
    let disposeBag = DisposeBag()

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    
    var viewModel: ForecastViewModel? {
        didSet {
            if let icon =  current?.weather?.first?.icon {
                viewModel?.loadImage(icon: icon).observe(on: MainScheduler.instance).bind(to: self.icon.rx.image).disposed(by: disposeBag)
            }
        }
    }
    
    var current: Current? {
        didSet {
            self.hourLabel.text = current?.hour
            self.temperatureLabel.text = current?.main?.temperature
        }
    }
}
