//
//  BannerImageCollectionViewCell.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 18/02/21.
//

import UIKit

class BannerImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    
    func setUpData(imageName: String){
        self.bannerImageView.image = UIImage(named: imageName)
    }

}

extension BannerImageCollectionViewCell: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}
