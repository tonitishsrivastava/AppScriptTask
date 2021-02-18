//
//  DetailViewModel.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 18/02/21.
//

import Foundation
import UIKit

class DetailViewModel {
    
    var selectedItem: Item!
    var selectedIndexPath: IndexPath!
    
    init(withData data: Item, withIndexPath indexPath: IndexPath ) {
        self.selectedItem = data
        self.selectedIndexPath = indexPath
    }
    
    func setUpData() -> (UIImage?, String?, String?) {
        guard let selectedItem = selectedItem else {
            return (nil, nil, nil)
        }
        let imageName = selectedItem.image!
        let image = UIImage(named: imageName)
        let itemName = selectedItem.title!
        let itemDescription = selectedItem.description!
        return (image,itemName,itemDescription)
    }
    
    func setButtonName() -> String {
        if self.selectedIndexPath == SelectableItem.shared.indexPath && SelectableItem.shared.isSelected {
            return "Selected"
        } else {
            return "Select"
        }
    }
    
}
