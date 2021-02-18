//
//  ViewController.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 17/02/21.
//

import UIKit

struct Constants {
    static let stdCornerRadius: CGFloat = 8.0
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    //1
    lazy var homeViewModel: HomeViewModel = {
        HomeViewModel(with: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //2
        self.homeViewModel.collapsableDelegate = self
        registerViewsToTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func registerViewsToTableView() {
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier:CustomTableCell.ReuseID())
        tableView.register(UINib(nibName: "CustomBannerHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: CustomBannerHeaderView.ReuseID())
        tableView.register(UINib(nibName: "CustomTitleHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: CustomTitleHeaderView.ReuseID())
        tableView.register(UINib(nibName: "CustomFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: CustomFooterView.ReuseID())
    }
    
}

//3
extension HomeViewController: CollapsableSectionDataSource {
    func numberOfCollapsableSection() -> Int {
        return DataClient.client.getDataCount()+1
    }
}

//4
extension HomeViewController: CollapsableSectionDelegate {
    func reloadSectionAtIndexPath(indexPath: IndexPath) {
        self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .fade)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.homeViewModel.getNumberOfSection()
    }
    
    //5
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            if self.homeViewModel.isSectionCollapsedAt(index: section) {
                return 0
            } else {
                return self.homeViewModel.getNumberOfRows(section: section)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableCell.ReuseID())
        guard let customCell = cell as? CustomTableCell else { return UITableViewCell() }
        let data = self.homeViewModel.dataForSectionItem(section: indexPath.section-1, index: indexPath.row)
        customCell.setUpCellData(imageName: data.0, itemName: data.1, indexPath:indexPath)
        customCell.selectionStyle = .none
        return customCell
    }
    
    //MARK: Section View Handling
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomBannerHeaderView.ReuseID()) as? CustomBannerHeaderView  else { return nil }
            headerView.setUpBannerData(bannerData: self.homeViewModel.getBannerData())
            return headerView
        } else {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTitleHeaderView.ReuseID()) as? CustomTitleHeaderView  else { return nil }
            //Make sure to set delegate
            headerView.delegate = self
            headerView.setUpData(title: self.homeViewModel.titleForSectionHeader(section: section-1))
            headerView.footerSection = section
            //6
            let isCollapsed = self.homeViewModel.isSectionCollapsedAt(index: section)
            headerView.updateFooterButton(isCollapsed: isCollapsed)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.homeViewModel.onItemSelected(indexPath: indexPath, controller: self)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section > 0 {
            guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomFooterView.ReuseID()) as? CustomFooterView  else { return nil }
            //Make sure to set delegate
            footerView.footerSection = section
            //6
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.25 * UIScreen.main.bounds.height
        } else {
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 16.0
        }
    }
    
}

extension HomeViewController: TitleHeaderViewDelegate {
    func viewMoreButtonTappedInHeader(view: CustomTitleHeaderView, inSection section: Int) {
        self.homeViewModel.collapseSectionAt(index: section)
    }
}

