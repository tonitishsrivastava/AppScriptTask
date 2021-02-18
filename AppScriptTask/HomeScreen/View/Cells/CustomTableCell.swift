//
//  CustomTableCell.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 17/02/21.
//

import UIKit

class CustomTableCell: UITableViewCell, MaskedCorner {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var blurView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        blurEffect()
        self.maskAllRoundedCorner(for: self.itemImageView)
    }
    
    func setUpCellData(imageName: String, itemName: String, indexPath: IndexPath){
        self.itemImageView.image = UIImage(named: imageName)
        self.itemNameLabel.text = itemName
        if indexPath == SelectableItem.shared.indexPath && SelectableItem.shared.isSelected {
            blurView.isHidden = false
        } else {
            blurView.isHidden = true
        }
    }
    
    func blurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.addSubview(blurEffectView)
        blurView.alpha = 0.8
    }
    
}

extension CustomTableCell: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}


