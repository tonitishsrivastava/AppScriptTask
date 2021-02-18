//
//  Item.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 18/02/21.
//

import Foundation

struct Item {
    var title: String!
    var image: String!
    var description: String!
    
    init(json: [String: AnyObject]) {
        if let title = json["Name"] as? String{
            self.title = title
        }
        if let image = json["Image"] as? String{
            self.image = image
        }
        if let description = json["Description"] as? String{
            self.description = description
        }
    }
    
}
