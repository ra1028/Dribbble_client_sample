//
//  UIViewController+Util.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/4/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

extension UIViewController {
    class func instantiateFromNib() -> Self {
        return self.instantiateFromNibFromType()
    }
    
    private class func instantiateFromNibFromType<T: UIViewController>() -> T {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewControllerWithIdentifier(self.className()) as T
    }
    
    private class func className() -> String {
        var className = NSStringFromClass(self)
        let range = className.rangeOfString(".")!
        return className.substringFromIndex(range.endIndex)
    }
}