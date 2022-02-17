//
//  ForecastView.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import UIKit

class ForecastView: BaseView {
    
    var viewModel: ForecastViewModel? {
        didSet {
            self.configureView()
        }
    }
    
    class func prepare() -> ForecastView {
        let view = ForecastView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func configureView() {
        
    }
}

extension ForecastView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.forecasts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
