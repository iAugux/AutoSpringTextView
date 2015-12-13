//
//  UIResponder+Extension.swift
//  AutoSpringTextView
//
//  Created by Augus on 12/13/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit

var ausCurrentFirstResponder: AnyObject?

extension UIResponder {
    class func currentFirstResponder() -> AnyObject? {
        ausCurrentFirstResponder = nil
        UIApplication.sharedApplication().sendAction("findFirstResponder:", to: nil, from: nil, forEvent: nil)
        return ausCurrentFirstResponder
    }
    
    func findFirstResponder(sender: AnyObject) {
        ausCurrentFirstResponder = self
    }
}