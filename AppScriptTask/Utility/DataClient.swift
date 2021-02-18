//
//  DataClient.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 18/02/21.
//

import Foundation

class DataClient {
    
    private (set) var data = [MenuCategory]()
    
    static let client = DataClient()
    
    private init(){
        self.getAllCategoryFromJson()
    }
    
    func getAllCategoryFromJson(){
        if let path = Bundle.main.path(forResource: "MenuData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let categories = jsonResult["data"] as? [[String: AnyObject]] {
                    // do stuff
                    let newItems =  categories.map({ (dic) -> MenuCategory in
                        return MenuCategory(json: dic)
                    })
                    self.data = newItems
                }
            } catch {
                print("Error caught")
                // handle error
            }
        }
    }
    
    func getDataCount() -> Int {
        return data.count
    }
    
}
