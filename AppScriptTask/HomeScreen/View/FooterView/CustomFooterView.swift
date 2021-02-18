//
//  CustomFooterView.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 18/02/21.
//

import UIKit

class CustomFooterView: UITableViewHeaderFooterView, MaskedCorner {
    @IBOutlet weak var borderView: UIView!
    
    var footerSection: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.maskBottomOnlyRoundedCorner(for: self.borderView)
    }
    
}

extension CustomFooterView: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}
