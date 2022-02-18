//
//  SectionHeader.swift
//  OpenWeatherChallenge
//
//  Created by Leonardo Soares on 17/02/22.
//

import Foundation
import UIKit
import SnapKit

class SectionHeader: UICollectionReusableView {
     var title: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .darkGray
         label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
         label.sizeToFit()
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)
         self.backgroundColor = UIColor.systemGray5
         addSubview(title)

         title.translatesAutoresizingMaskIntoConstraints = false
         title.snp.makeConstraints { [weak self] make in
             guard let self = self else { return }
             make.top.equalTo(self.snp.top)
             make.left.equalTo(self.snp.left).offset(16)
             make.right.equalTo(self.snp.right)
             make.bottom.equalTo(self.snp.bottom)
         }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
