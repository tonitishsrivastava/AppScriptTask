//
//  DetailViewController.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 18/02/21.
//

import UIKit

class DetailViewController: UIViewController, MaskedCorner {

    @IBOutlet weak var selectedItemImageView: UIImageView!
    @IBOutlet weak var selectedItemTitleLabel: UILabel!
    @IBOutlet weak var selectedItemDescriptionTextView: UITextView!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    var change : ((Bool) -> Void)?
    
    var selectedItem: Item!
    var selectedIndexPath: IndexPath!
    
    lazy var detailViewModel: DetailViewModel = {
        DetailViewModel(withData: self.selectedItem, withIndexPath: self.selectedIndexPath)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maskCompleteRoundCorner(for: self.backButton)
        self.maskAllRoundedCorner(for: selectButton)
        self.selectedItemImageView.image = self.detailViewModel.setUpData().0
        self.selectedItemTitleLabel.text = self.detailViewModel.setUpData().1
        self.selectedItemDescriptionTextView.text = self.detailViewModel.setUpData().2
        self.selectButton.setTitle(self.detailViewModel.setButtonName(), for: .normal)
    }

    @IBAction func onSelectButtonClick(_ sender: Any) {
        self.change?(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
