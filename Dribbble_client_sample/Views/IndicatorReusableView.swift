//
//  IndicatorReusableView.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/2/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class IndicatorReusableView: UICollectionReusableView {
    private var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    private func configure() {
        self.indicatorView.activityIndicatorViewStyle = .White
        self.indicatorView.color = UIColor(red:0.56, green:0.56, blue:0.56, alpha:1)
        self.indicatorView.center = self.center
        self.indicatorView.center.y = 25.0
        self.addSubview(self.indicatorView)
    }
    
    func startAnimating() {
        if !self.indicatorView.isAnimating() {
            self.indicatorView.startAnimating()
        }
    }
    
    func stopAnimating() {
        if self.indicatorView.isAnimating() {
            self.indicatorView.stopAnimating()
        }
    }
}