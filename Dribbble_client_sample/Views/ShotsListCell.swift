//
//  ShotsListCell.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 1/31/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class ShotsListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    private func configure() {
        self.clipsToBounds = false
        self.layer.cornerRadius = 3.0
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0, 2.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.imageView.layer.removeAllAnimations()
    }
    
    func applyImage(image: UIImage?, animated: Bool = false) {
        if animated {
            let transition = CATransition()
            transition.type = kCATransitionFade
            transition.duration = 0.09
            self.imageView.layer.addAnimation(transition, forKey: "fade")
        }else {
            self.imageView.layer.removeAnimationForKey("fade")
        }
        if self.imageView.image == nil {
            self.imageView.image = image
        }
    }
}