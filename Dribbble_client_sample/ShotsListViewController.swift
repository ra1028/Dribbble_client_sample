//
//  ShotsListViewController.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 1/31/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class ShotsListViewController: ViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
   
    private func configure() {
        self.collectionView.registerNib(UINib(nibName: ShotsListCell.className(), bundle: nil), forCellWithReuseIdentifier: ShotsListCell.className())
        self.collectionView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    /* Delegate, Datasource */
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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