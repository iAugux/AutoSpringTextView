//
//  UIResponder+Extension.swift
//
//  Created by Augus on 12/13/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


extension UIResponder {
    
    private static var _currentFirstResponder: UIResponder?
    
    class func currentFirstResponder() -> UIResponder? {
        UIResponder._currentFirstResponder = nil
        UIApplication.sharedApplication().sendAction("findFirstResponder:", to: nil, from: nil, forEvent: nil)
        return UIResponder._currentFirstResponder
    }
    
    internal func findFirstResponder(sender: AnyObject) {
        UIResponder._currentFirstResponder = self
    }
    
}