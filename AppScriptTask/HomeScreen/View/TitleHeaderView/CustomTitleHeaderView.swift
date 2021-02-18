//
//  CustomFooterView.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 17/02/21.
//

import UIKit

protocol TitleHeaderViewDelegate: AnyObject {
    func viewMoreButtonTappedInHeader(view: CustomTitleHeaderView, inSection section: Int)
}

class CustomTitleHeaderView: UITableViewHeaderFooterView, MaskedCorner {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewMoreButton: UIButton!
    weak var delegate: TitleHeaderViewDelegate?
    var footerSection: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.maskTopOnlyRoundedCorner(for: self.borderView)
    }
    
    func setUpData(title: String){
        titleLabel.text = title
    }
    
    func updateFooterButton(isCollapsed: Bool) {
        let footerBottonTitle = isCollapsed ? "Show more" : "Show less"
        self.viewMoreButton.setTitle(footerBottonTitle, for: .normal)
    }
    
    
    @IBAction func viewMoreButtonAction(_ sender: Any) {
        self.delegate?.viewMoreButtonTappedInHeader(view: self, inSection: footerSection)
    }
}

extension CustomTitleHeaderView: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}
