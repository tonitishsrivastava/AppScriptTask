//
//  Menu.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 18/02/21.
//

import Foundation


struct MenuCategory {
    var title: String!
    var items: [Item]!
    
    init(json: [String: AnyObject]) {
        if let title = json["Title"] as? String {
            self.title = title
        }
        if let items = json["Items"] as? [[String: AnyObject]] {
            let newItems =  items.map({ (dic) -> Item in
                return Item(json: dic)
            })
            if newItems.count > 0 {
                self.items = newItems
            }
        }
    }
    
}
