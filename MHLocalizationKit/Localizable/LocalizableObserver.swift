//
//  LocalizableObserver.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

internal class LocalizableObserver: NSObject {
    
    let localizable: Localizable
    private var _associatedKey: Character = " "
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    init(localizable: Localizable) {
        
        self.localizable = localizable
        
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedLanguageWillChange:", name: NSBundle.LanguageWillChangeNotificationName, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedLanguageDidChange:", name: NSBundle.LanguageDidChangeNotificationName, object: nil)
    }
    
    func associate() {
        
        objc_setAssociatedObject(localizable as? AnyObject, &_associatedKey, self, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private func receivedLanguageWillChange(notification: NSNotification) {
     
        let old = notification.userInfo?[NSBundle.LanguageKey.Old.rawValue] as? Language
        let new = notification.userInfo?[NSBundle.LanguageKey.New.rawValue] as? Language
        
        self.localizable.languageWillChange(old, new: new)
    }
    
    private func receivedLanguageDidChange(notification: NSNotification) {
        
        let old = notification.userInfo?[NSBundle.LanguageKey.Old.rawValue] as? Language
        let new = notification.userInfo?[NSBundle.LanguageKey.New.rawValue] as? Language
        
        self.localizable.languageDidChange(old, new: new)
    }
}
