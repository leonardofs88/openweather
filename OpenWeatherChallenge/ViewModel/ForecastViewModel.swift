//
//  ForecastViewModel.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import RxSwift

typealias GroupedDate = (key: String, value: [Array<Current>.Element])?

class ForecastViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    let service: ServiceProtocol
    
    var groupedDates: [GroupedDate]? {
        didSet {
            self.onLoaded?()
        }
    }
    
    var numberOfSections: Int {
        return self.groupedDates?.count ?? 0
    }
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func loadForecast() {
        service.fetch(type: .forecast).subscribe { [weak self] forecast in
            let dictionary = Dictionary(grouping: forecast, by: { $0.day })
            let sortedDictionary = dictionary.sorted { $0.0 < $1.0 }
            self?.groupedDates = sortedDictionary
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.onError?(self.display(error: error as! APIError))
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
