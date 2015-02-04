//
//  ShotsDetailViewController.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/4/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class ShotsDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameView: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorNameHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    
    var shot: Shot? {
        didSet {
            if let shot = shot {
                self.update(shot: shot)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        self.authorImageView.layer.cornerRadius = self.authorImageView.bounds.height / 2.0
    }
    
    private func update(#shot: Shot) {
        if let player = shot.player {
            self.authorNameView.text = player.name
            ImageRequest.sharedRequest.fetchImage(imageUrl: player.imageUrl, success:{[weak self] (image: UIImage?) -> Void in
                self?.authorImageView.image = image
                return
                }, failure: {(error: NSError?) -> Void in
            })
        }
        
        self.titleLabel.text = shot.title
        self.descriptionLabel.text = self.deleteTag(string: shot.summary)
        self.imageView.image = shot.teaserImage
        self.adjustConstraints()
        
        if let image = shot.image {
            self.imageView.image = image
        }else {
            ImageRequest.sharedRequest.fetchImage(imageUrl: shot.imageUrl,
            success: {[weak self] (image: UIImage?) -> Void in
                shot.image = image
                self?.imageView.image = image
                return
            }, failure: {(error:NSError?) -> Void in
            })
        }
    }
    
    private func adjustConstraints() {
        self.authorNameHeight.constant = self.authorNameView.sizeThatFits(self.authorNameView.bounds.size).height
        self.descriptionHeight.constant = self.descriptionLabel.sizeThatFits(self.descriptionLabel.bounds.size).height
    }
    
    private func deleteTag(#string: String?) -> String? {
        let newStr = string?.stringByReplacingOccurrencesOfString("<.*?>", withString: "", options: .RegularExpressionSearch, range: nil)
        return newStr
    }
    
    @IBAction func handleCloseButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}