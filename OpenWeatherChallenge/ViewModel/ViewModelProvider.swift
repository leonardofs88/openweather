//
//  ViewModelProvider.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 16/02/22.
//

import Foundation

class ViewModelProvider {
    static var viewModel: ViewModel {
        return ViewModel(service: ServiceProvider.service)
    }
}
