//
//  CollapsableViewModel.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 17/02/21.
//

import Foundation
import UIKit

//1
protocol CollapsableSectionDataSource: AnyObject {
    func numberOfCollapsableSection() -> Int
}

//2
protocol CollapsableSectionDelegate: AnyObject {
    func reloadSectionAtIndexPath(indexPath: IndexPath)
}

public class HomeViewModel {
    
    //3
    private(set) var sectionMappers: [CollapsableSection] = []
    weak var collapsableDataSource: CollapsableSectionDataSource?
    weak var collapsableDelegate: CollapsableSectionDelegate?
    
    var bannerImageData = ["burgerImage1", "pizzaImage1", "burgerImage2", "pizzaImage2"]
    
    var menuData = [MenuCategory]()
    
    var selectedItem: Item!
    
    //4
    init(with collapsableViewDataSource: CollapsableSectionDataSource) {
        self.collapsableDataSource = collapsableViewDataSource
        getData()
        setupSectionMappers()
    }
    
    private func getData(){
        self.menuData = DataClient.client.data
    }
    
    private func setupSectionMappers() {
        let sectionsCount = self.collapsableDataSource?.numberOfCollapsableSection()
        guard let sections = sectionsCount, sections > 0 else { return }
        self.sectionMappers = (0..<sections).map({ (section) -> CollapsableSection in
            return CollapsableSection(withSection: section)
        })
    }
    
    //5
    public func isSectionCollapsedAt(index: Int) -> Bool {
        return self.sectionMappers[index].isCollapsed
    }
    
    //6
    public func collapseSectionAt(index: Int) {
        guard index < self.sectionMappers.count else { return }
        self.sectionMappers[index].toggleCollapseSection()
        let indexPath = IndexPath(row: 0, section: index)
        self.collapsableDelegate?.reloadSectionAtIndexPath(indexPath: indexPath)
    }
    
    public func dataForSectionItem(section: Int ,index: Int) -> (String, String) {
        let itemData = menuData[section].items
        let itemImageName = itemData?[index].image
        let itemName = itemData?[index].title
        return (itemImageName!, itemName!)
    }
    
    public func titleForSectionHeader(section: Int) -> String {
        return menuData[section].title!
    }
    
    public func getBannerData() -> [String]{
        return bannerImageData
    }
    
    func getNumberOfSection() -> Int {
        return self.menuData.count+1
    }
    
    func getNumberOfRows(section: Int) -> Int {
        return self.menuData[section-1].items.count
    }
    
    public func onItemSelected(indexPath: IndexPath, controller: UIViewController){
        let itemData = menuData[indexPath.section-1].items
        self.selectedItem = itemData?[indexPath.row]
        navigateToItemDetailScreen(controller: controller, indexPath: indexPath)
    }
    
    private func navigateToItemDetailScreen(controller: UIViewController, indexPath: IndexPath){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        viewController?.selectedItem = self.selectedItem
        viewController?.selectedIndexPath = indexPath
        viewController?.change = { (value) in
            SelectableItem.shared.update(withSection: indexPath)
        }
        controller.navigationController?.pushViewController(viewController!, animated: true)
    }
    
}
