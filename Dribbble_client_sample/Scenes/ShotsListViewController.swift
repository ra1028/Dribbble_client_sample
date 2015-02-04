//
//  ShotsListViewController.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 1/31/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit
import RequestKit

class ShotsListViewController: AdditionalLoadViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    struct ShotsStatusComponent {
        var list: List?
        var timeFrame: TimeFrame?
        var sort: Sort?
    }
    
    private var collectionView: UICollectionView!
    private var indicatorView: IndicatorReusableView?
    private var startIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private var shots: [Shot] = []
    private var currentPage:Int = 1
    var controllerIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.fetchShots()
    }
   
    private func configure() {
        self.startIndicator.activityIndicatorViewStyle = .WhiteLarge
        self.startIndicator.color = UIColor(red:0.56, green:0.56, blue:0.56, alpha:1)
        self.startIndicator.center = self.view.center
        self.view.insertSubview(self.startIndicator, atIndex: 0)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.collectionView.registerNib(UINib(nibName: ShotsListCell.className(), bundle: nil), forCellWithReuseIdentifier: ShotsListCell.className())
        self.collectionView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1)
        let insetTop: CGFloat = 64.0 + 35.0
        self.collectionView.contentInset.top = insetTop
        self.collectionView.scrollIndicatorInsets.top = insetTop
        self.collectionView.delaysContentTouches = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerClass(IndicatorReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "IndicatorReusableView")
        
        self.loadScrollView = self.collectionView
        self.view.insertSubview(self.collectionView, atIndex: 0)
    }
    
    private func fetchShots() {
        self.startIndicator.startAnimating()
        let component = self.shotsStatusComponent()
        
        ShotsModel.sharedModel.fetchLatestShots(
            list: component.list,
            sort: component.sort,
            timeFrame: component.timeFrame,
            success: {[weak self] (shots: [Shot]) -> Void in
                self?.shots += shots
                self?.reloadWithPush(true)
                self?.startIndicator.stopAnimating()
                self?.startIndicator.removeFromSuperview()
            }) {[weak self] (error) -> Void in
                self?.startIndicator.stopAnimating()
                self?.startIndicator.removeFromSuperview()
                return
        }
    }
    
    override func additionalLoad(#completion: (() -> Void)) {
        self.indicatorView?.startAnimating()
        let component = self.shotsStatusComponent()
        
        ShotsModel.sharedModel.fetchAdditionalShots(
            list: component.list,
            sort: component.sort,
            timeFrame: component.timeFrame,
            page: ++self.currentPage,
            success: {[weak self](shots: [Shot]) -> Void in
                self?.indicatorView?.stopAnimating()
                self?.shots += shots
                self?.collectionView.reloadData()
                completion()
            }, {[weak self] (error) -> Void in
                self?.indicatorView?.stopAnimating()
                completion()
        })
    }
    
    func shotsStatusComponent() -> ShotsStatusComponent {
        // Needs override.
        return ShotsStatusComponent(list: nil, timeFrame: nil, sort: nil)
    }
    
    private func reloadWithPush(animation: Bool) {
        if animation {
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromTop
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            transition.duration = 0.3
            self.collectionView.layer.addAnimation(transition, forKey: "pushReload")
        }
        self.collectionView.reloadData()
    }
    
    private func configureCell(cell: ShotsListCell, shot: Shot) {
        if let image = shot.teaserImage {
            cell.applyImage(image)
        }else {
            ImageRequest.sharedRequest.fetchImage(imageUrl: shot.teaserUrl, success: { image -> Void in
            shot.teaserImage = image
                cell.applyImage(image, animated: true)
            }, failure: { error -> Void in
                println(error)
            })
        }
    }
    
    /* Delegate, Datasource */
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = ShotsDetailViewController.instantiateFromNib() as ShotsDetailViewController
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalTransitionStyle = .CrossDissolve
        self.presentViewController(nav, animated: true, nil)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.05 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            controller.shot = self.shots[indexPath.row]
        })
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shots.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10.0
        let sectionSpacing: CGFloat = 20.0
        let width = floor((CGRectGetWidth(self.view.bounds) - itemSpacing - sectionSpacing) / 2.0)
        let height = width * (3.0 / 4.0)
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var view: UICollectionReusableView!
        if kind == UICollectionElementKindSectionFooter {
            view = self.collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "IndicatorReusableView", forIndexPath: indexPath) as IndicatorReusableView
            self.indicatorView = view as? IndicatorReusableView
            return view
        }
        return view
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(CGRectGetWidth(self.view.bounds), 50.0)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ShotsListCell.className(), forIndexPath: indexPath) as ShotsListCell
        let shot = self.shots[indexPath.item]
        self.configureCell(cell, shot: shot)
        return cell
    }
}