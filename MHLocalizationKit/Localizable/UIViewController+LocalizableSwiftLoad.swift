//
//  UIViewController+LocalizableSwiftLoad.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension UIViewController {
    
    @objc public class func _localizable_swift_load() {
        
        let original = class_getInstanceMethod(self, #selector(UIViewController.viewDidLoad))
        let modified = class_getInstanceMethod(self, #selector(UIViewController._localizable_viewDidLoad))
        
        method_exchangeImplementations(original!, modified!)
    }
    
    @objc public func _localizable_viewDidLoad() {
        
        self._localizable_viewDidLoad()
        
        if let localizable = self as? Localizable {
            
            LocalizableObserver(localizable: localizable).associate()
            localizable.languageDidChange(from: nil, to: nil)
        }
    }
}

