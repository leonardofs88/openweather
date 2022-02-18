//
//  ChartView.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import UIKit
import Charts

class ChartView: BaseView, ChartViewDelegate {
    
    var data: GroupedDate? {
        didSet {
            if let data = self.data {
                self.configureView(with: data)
            }
        }
    }
    
    lazy var chart: LineChartView = {
        let chartView = LineChartView()
        return chartView
    }()
    
    class func prepare() -> ChartView {
        let view = ChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func configureView(with data: GroupedDate) {
        addSubview(self.chart)
        chart.leftAxis.enabled = false
        chart.xAxis.enabled = false
        chart.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self)
        }
        let set = LineChartDataSet(entries: self.convertGroupedDateToEntries(groupedDate: self.data), label: "Temperature in ºC")
        let chartData = LineChartData(dataSet: set)
        self.chart.data = chartData
    }
    
    private func convertGroupedDateToEntries(groupedDate: GroupedDate?) -> [ChartDataEntry] {
        var chartEntries: [ChartDataEntry] = []
        
        if let temperatures = groupedDate??.value {
            for element in temperatures {
                chartEntries.append(ChartDataEntry(x: Double(element.hour) ?? 0.0, y: element.main?.temp ?? 0.0))
            }
        }
        
        return chartEntries
    }
}
