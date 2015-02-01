//
//  ShotsListViewController.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 1/31/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit
import RequestKit

class ShotsListViewController: ViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var shots: [Shot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchShots()
    }
   
    private func configure() {
        self.collectionView.registerNib(UINib(nibName: ShotsListCell.className(), bundle: nil), forCellWithReuseIdentifier: ShotsListCell.className())
        self.collectionView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func fetchShots() {
        ShotsModel.sharedModel.fetchLatestShots(
            page: 1,
            success: {[weak self] (shots: [Shot]) -> Void in
                self?.shots += shots
                self?.reloadWithAnimation(true)
            }, { (error) -> Void in
                
        })
    }
    
    private func reloadWithAnimation(animation: Bool) {
        if animation {
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromTop
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            transition.duration = 0.5
            self.collectionView.layer.addAnimation(transition, forKey: "pushReload")
        }
        self.collectionView.reloadData()
    }
    
    /* Delegate, Datasource */
    
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
        let itemSpacing: CGFloat = 20.0
        let sectionSpacing: CGFloat = 20.0
        let width = floor((CGRectGetWidth(self.view.bounds) - itemSpacing - sectionSpacing) / 3.0)
        let height = width * (3.0 / 4.0)
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ShotsListCell.className(), forIndexPath: indexPath) as ShotsListCell
        return cell
    }
}