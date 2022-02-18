//
//  ForecastViewModel.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import RxSwift

typealias GroupedDate = (key: String, value: [Array<Current>.Element])?
typealias OnLoaded = ()->Void

class ForecastViewModel {
    let disposeBag = DisposeBag()
    let service: ServiceProtocol
    
    var onGroupedDatesLoaded: OnLoaded?
    
    var groupedDates: [GroupedDate]? {
        didSet {
            self.onGroupedDatesLoaded?()
        }
    }
    
    var numberOfSections: Int {
        return self.groupedDates?.count ?? 0
    }
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func loadForecast() {
        service.fetchForecast().subscribe { forecast in
            if let list = forecast.list {
                let dictionary = Dictionary(grouping: list, by: { $0.day })
                let sortedDictionary = dictionary.sorted { $0.0 < $1.0 }
                self.groupedDates = sortedDictionary
            }
        } onError: { error in
            
        }.disposed(by: disposeBag)
    }
    
    func loadImage(icon: String) -> Observable<UIImage?> {
        service.loadImage(icon: icon).map { UIImage(data: $0) }
    }
    
    func getGroupedDate(for indexPath: IndexPath) -> Current? {
        return self.groupedDates?[indexPath.section]?.value[indexPath.item]
    }
    
    func getNumberOfItensForSection(for section: Int) -> Int {
        return self.groupedDates?[section]?.value.count ?? 0
    }
    
    func getTitleForSetion(at indexPath: IndexPath) -> String {
        return self.groupedDates?[indexPath.section]?.value[indexPath.item].fullDate ?? ""
    }
}
