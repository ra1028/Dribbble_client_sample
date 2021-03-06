//
//  UIView.Util.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 1/31/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

extension UIView {
    class func className() -> String {
        var className = NSStringFromClass(self)
        let range = className.rangeOfString(".")!
        return className.substringFromIndex(range.endIndex)
    }
    
    class func instantiateFromNib() -> Self {
        return self.instantiateFromNibFromType()
    }
    
    private class func instantiateFromNibFromType<T: UIView>() -> T {
        return UINib(nibName: self.className(), bundle: nil).instantiateWithOwner(nil, options: nil).first! as T
    }
}