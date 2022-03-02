//
//  ForecastView.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import UIKit

class ForecastView: BaseView {
    
    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    
    var delegate: ViewControllerDelegate?
    
    var viewModel: ForecastViewModel? {
        didSet {
            self.bindViewModel()
            self.viewModel?.loadForecast()
        }
    }
    class func prepare() -> ForecastView {
        let view = ForecastView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func bindViewModel() {
        self.viewModel?.onLoaded = { [weak self] in
            self?.configureView()
        }
        
        self.viewModel?.onError = { [weak self] alert in
            self?.delegate?.displayError(alert: alert)
        }
    }
    
    private func configureView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let newChartView = ChartView()
            newChartView.backgroundColor = UIColor(hue: 0.1333, saturation: 0.15, brightness: 1, alpha: 1.0)
            newChartView.data = self.viewModel?.groupedDates?[0]
            
            self.chartView.addSubview(newChartView)
            newChartView.snp.makeConstraints { make in
                make.top.bottom.left.right.equalTo(self.chartView)
            }
            
            let nib = UINib(nibName: "ForecastItemViewCell", bundle: nil)
            self.forecastCollectionView.delegate = self
            self.forecastCollectionView.dataSource = self
            self.forecastCollectionView.register(nib, forCellWithReuseIdentifier: "ForecastCell")
            self.forecastCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
            if let flowLayout = self.forecastCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
                flowLayout.itemSize = CGSize(width: 80, height: 180)
                flowLayout.minimumInteritemSpacing = 5
            }
            self.forecastCollectionView.reloadData()
        }
    }
}

extension ForecastView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            sectionHeader.title.text = viewModel?.getTitleForSetion(at: indexPath)
             return sectionHeader
        } else {
             return ForecastItemViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getNumberOfItensForSection(for: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ForecastItemViewCell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastItemViewCell
        cell.current = viewModel?.getGroupedDate(for: indexPath)
        cell.viewModel = viewModel
        return cell
    }
    
    
}
