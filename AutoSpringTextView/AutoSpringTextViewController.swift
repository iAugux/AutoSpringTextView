//
//  AutoSpringTextViewController.swift
//  AutoSpringTextView
//
//  Created by Augus on 12/13/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


class AUSAutoSpringTextViewController: UIViewController {
    
    var showingKeyboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enableEditTextScroll()
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "viewClicked"))
    }
    
    func viewClicked() {
        if showingKeyboard {
            guard let responder = UIResponder.currentFirstResponder() else { return }
            guard responder.isKindOfClass(UITextView.classForCoder()) || responder.isKindOfClass(UITextField.classForCoder()) else { return }
            if let view = responder as? UIView {
                view.resignFirstResponder()
            }
        }
    }
    
    func shouldScrollWithKeyboardHeight(keyboardHeight: CGFloat) -> CGFloat {
        guard let responder = UIResponder.currentFirstResponder() else { return 0 }
        guard responder.isKindOfClass(UITextView.classForCoder()) || responder.isKindOfClass(UITextField.classForCoder()) else { return 0 }
        guard let view = responder as? UIView else { return 0 }
        
        let y = view.convertPoint(CGPointZero, toView: UIApplication.sharedApplication().keyWindow).y
        let bottom = y + view.frame.height
        let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
        
        if bottom > SCREEN_HEIGHT - keyboardHeight {
            return bottom - (SCREEN_HEIGHT - keyboardHeight)
        }
        return 0
    }
    
    func enableEditTextScroll() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardDidShow() {
        showingKeyboard = true
    }
    
    func keyboardDidHide() {
        showingKeyboard = false
    }
    
    func keyboardWillHide(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval else { return }
        
        let weakSelf: AUSAutoSpringTextViewController = self
        UIView.animateWithDuration(duration, animations: {() -> Void in
            let bounds: CGRect = weakSelf.view.bounds
            weakSelf.view.bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        })
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval else { return }
        guard let keyboardHeight = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.height else { return }
        
        let shouldScrollHeight: CGFloat = self.shouldScrollWithKeyboardHeight(keyboardHeight)
        if shouldScrollHeight == 0 {
            return
        }
        let weakSelf: AUSAutoSpringTextViewController = self
        UIView.animateWithDuration(duration, animations: {() -> Void in
            let bounds: CGRect = weakSelf.view.bounds
            weakSelf.view.bounds = CGRectMake(0, shouldScrollHeight + 10, bounds.size.width, bounds.size.height)
        })
    }
}
