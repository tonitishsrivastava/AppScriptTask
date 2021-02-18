//
//  CollapsableSection.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 17/02/21.
//

import Foundation

struct CollapsableSection {
    private(set) var sectionIndexPath: Int
    private(set) var isCollapsed: Bool
    
    init(withSection indexPath: Int, isCollapsed: Bool = false) {
        self.sectionIndexPath = indexPath
        self.isCollapsed = isCollapsed
    }
    
    mutating func toggleCollapseSection() {
        self.isCollapsed.toggle()
    }
}
