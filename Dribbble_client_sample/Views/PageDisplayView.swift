//
//  PageDisplayView.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/4/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class PageDisplayView: UIView,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource
{
    private var collectionView: UICollectionView!
    
    var titles: [String]! = []
    var page: Int! = 0 {
        didSet {
            if self.page < self.titles.count {
                self.collectionView.setContentOffset(CGPointMake(CGFloat(page) * (self.bounds.width / 2.0), 0), animated: true)
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0, 2.0)
        self.layer.shadowOpacity = 0.2
        
        self.collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .Horizontal
            let view = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
            view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            view.backgroundColor = UIColor.clearColor()
            view.scrollEnabled = false
            view.delegate = self
            view.dataSource = self
            view.registerClass(PageDisplayCell.self, forCellWithReuseIdentifier: "cell")
            return view
        }()
        self.insertSubview(self.collectionView, atIndex: 0)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let insetsSide = self.bounds.width / 4.0
        return UIEdgeInsetsMake(0, insetsSide, 0, insetsSide)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = self.bounds.width / 2.0
        let height = self.bounds.height
        return CGSizeMake(width, height)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as PageDisplayCell
        cell.title = self.titles[indexPath.row]
        return cell
    }
}

private class PageDisplayCell: UICollectionViewCell {
    private var titleLabel: UILabel!
    
    var title: String? {
        set {
            self.titleLabel.text = newValue
        }
        get {
            return self.titleLabel.text
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    private override func layoutSubviews() {
        super.layoutSubviews()
        let padW: CGFloat = 8.0 * 2.0
        let size = self.titleLabel.sizeThatFits(self.bounds.size)
        self.titleLabel.bounds.size = CGSizeMake(size.width + padW, size.height)
        self.titleLabel.layer.cornerRadius = self.titleLabel.bounds.height / 2.0
        self.titleLabel.center = self.contentView.center
    }
    
    private func configure() {
        self.titleLabel = {
            let label = UILabel()
            label.textAlignment = .Center
            label.font = UIFont.boldSystemFontOfSize(18.0)
            label.textColor = UIColor.whiteColor()
            label.backgroundColor = UIColor.darkGrayColor()
            label.layer.masksToBounds = true
            return label
        }()
        self.contentView.insertSubview(self.titleLabel, atIndex: 0)
    }
}