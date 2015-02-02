//
//  AdditionalLoadViewController.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/1/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class AdditionalLoadViewController: ViewController {
    private var loadingFlag: Bool = false
    weak var loadScrollView: UIScrollView? {
        willSet {
            if newValue != nil {
                newValue!.addObserver(self, forKeyPath: "contentOffset", options: .allZeros, context: nil)
            }else {
                self.loadScrollView?.removeObserver(self, forKeyPath: "scrollViewOffset")
            }
        }
    }
    
    deinit {
        self.loadScrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentOffset" {
            self.scrollViewDidScroll()
        }else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    func additionalLoad(#completion: (() -> Void)) {
        // Needs override.
        completion()
    }
    
    private func scrollViewDidScroll() {
        if let scrollView = self.loadScrollView {
            let contentHeight = scrollView.contentSize.height
            let height = CGRectGetHeight(scrollView.bounds)
            let offsetY = scrollView.contentOffset.y
            let insetBottom = scrollView.contentInset.bottom
            if contentHeight - height - insetBottom < offsetY &&
                height < contentHeight &&
                !self.loadingFlag
            {
                self.loadingFlag = true
                self.additionalLoad(completion: { [weak self] () -> Void in
                    self?.loadingFlag = false
                    return
                })
            }
        }
    }
}