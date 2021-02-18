//
//  SelectableItem.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 18/02/21.
//

import Foundation

class SelectableItem {
    
    var indexPath: IndexPath?
    var isSelected: Bool = false
    
    static let shared = SelectableItem()
    
    private init () {
        
    }
    
    func update(withSection indexPath: IndexPath) {
        if (self.indexPath != nil) {
            if (indexPath == self.indexPath) {
                self.isSelected = false
                self.indexPath = nil
            } else {
                self.indexPath = indexPath
                self.isSelected = true
            }
        } else {
            self.isSelected = true
            self.indexPath = indexPath
        }
    }
    
}
