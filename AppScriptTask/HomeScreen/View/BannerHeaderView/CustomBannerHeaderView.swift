//
//  CustomHeaderView.swift
//  AppScriptTask
//
//  Created by Nitish Srivastava on 17/02/21.
//

import UIKit

//MARK: Protocol to get reuse ID
public protocol Reuseable {
    static func ReuseID() -> String
}

//MARK: Protocol to make Views to rounded corners
protocol MaskedCorner {
    func maskTopOnlyRoundedCorner(for view: UIView)
    func maskBottomOnlyRoundedCorner(for view: UIView)
    func maskAllRoundedCorner(for view: UIView)
    func maskCompleteRoundCorner(for view: UIView)
}

//MARK: default implementation for MaskedCorner protocol
extension MaskedCorner {
    func maskTopOnlyRoundedCorner(for view: UIView) {
        view.layer.cornerRadius = Constants.stdCornerRadius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func maskBottomOnlyRoundedCorner(for view: UIView) {
        view.layer.cornerRadius = Constants.stdCornerRadius
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func maskAllRoundedCorner(for view: UIView) {
        view.layer.cornerRadius = Constants.stdCornerRadius
        view.layer.masksToBounds = true
    }
    
    func maskCompleteRoundCorner(for view: UIView) {
        view.layer.cornerRadius = view.bounds.height/2
        view.layer.masksToBounds = true
    }
}


class CustomBannerHeaderView: UITableViewHeaderFooterView, MaskedCorner {
    
    
    // 1 - outlets
    @IBOutlet weak var bannerImageCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    var bannerImageData: [String]!
    var timer: Timer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerImageCollectionView.register(UINib(nibName: "BannerImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:BannerImageCollectionViewCell.ReuseID())
        pageController.hidesForSinglePage = true
    }
    
    func setUpBannerData(bannerData: [String]){
        pageController.numberOfPages = bannerData.count
        self.bannerImageData = bannerData
        self.bannerImageCollectionView.reloadData()
        self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (_) in
            self.changePage()
        }
    }
    
    func changePage(){
            let nextPage = (pageController.currentPage + 1) % self.bannerImageData.count
            let indexPath = IndexPath(item: nextPage , section: 0)
            
            self.bannerImageCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            self.pageController.currentPage = nextPage
        }
    
    override func prepareForReuse() {
        self.timer.invalidate()
    }
    
}

extension CustomBannerHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerImageCollectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCollectionViewCell.ReuseID(), for: indexPath)
        guard let customCell = cell as? BannerImageCollectionViewCell else { return UICollectionViewCell() }
        customCell.setUpData(imageName: bannerImageData[indexPath.row])
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageController.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width)
        let height: CGFloat = 0.25 * UIScreen.main.bounds.height
        return CGSize(width: width, height: height)
    }
    
    
}

//Reusable protocol for views
extension CustomBannerHeaderView: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}
