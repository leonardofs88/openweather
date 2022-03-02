//
//  BaseViewModel.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 02/03/22.
//

import Foundation
import UIKit

typealias OnLoaded = ()->Void
typealias OnError = (UIAlertController)->Void

class BaseViewModel {
    var onLoaded: OnLoaded?
    var onError: OnError?
    
    internal func display(error: APIError) -> UIAlertController {
        var message: String = ""
        
        switch error {
        case .server:
            message = "Server Error"
        case .url:
            message = "Invalid URL"
        case .empty:
            message = "Empty Response"
        case .unknown:
            message = "Unknown Error"
        case .decode(let error):
            message = error.localizedDescription
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}
