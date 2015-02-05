//
//  ShotDetailView.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/5/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class ShotDetailView: UIView {
    @IBOutlet private weak var shotImageView: UIImageView!
    @IBOutlet private weak var playerImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!
    
    var shot: Shot? {
        didSet {
            if let shot = shot {
                self.updateViewsAppearance(shot: shot)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    private func configure() {
        self.frame = UIScreen.mainScreen().bounds
        self.alpha = 0
        
        self.contentView.layer.cornerRadius = 10.0
        
        self.playerImageView.layer.cornerRadius = CGRectGetHeight(self.playerImageView.bounds) / 2.0
        self.playerImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.playerImageView.layer.borderWidth = 5.0
        
        UIView.animateWithDuration(0.3, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.alpha = 1.0
        }, completion: nil)
    }
    
    private func updateViewsAppearance(#shot: Shot) {
        if let player = shot.player {
            ImageRequest.sharedRequest.fetchImage(imageUrl: player.imageUrl, success:{[weak self] (image: UIImage?) -> Void in
                self?.playerImageView.image = image
                let animation = CATransition()
                animation.type = kCATransitionFade
                self?.playerImageView.layer.addAnimation(animation, forKey: "fade")
                return
                }, failure: {(error: NSError?) -> Void in
            })
        }
        
        self.shotImageView.image = shot.teaserImage
        self.titleLabel.text = shot.title
        
        if let image = shot.image {
            self.shotImageView.image = image
        }else {
            ImageRequest.sharedRequest.fetchImage(imageUrl: shot.imageUrl,
                success: {[weak self] (image: UIImage?) -> Void in
                    shot.image = image
                    self?.shotImageView.image = image
                    return
                }, failure: {(error:NSError?) -> Void in
            })
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        UIView.animateWithDuration(0.3, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.alpha = 0
        }) { (flag) -> Void in
            self.removeFromSuperview()
        }
    }
}