//
//  ViewControllerProvider.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

class ViewControllerProvider {
    static var viewController: ViewController {
        let vc = ViewController()
        vc.viewModel = ViewModelProvider.viewModel
        return vc
    }
}
