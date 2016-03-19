//
//  LocalizableObserver.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

internal class LocalizableObserver: NSObject {
    
    private(set) weak var localizable: Localizable?
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
    
    private dynamic func receivedLanguageWillChange(notification: NSNotification) {
     
        var newLanguage: Language?
        
        if let id = notification.userInfo?[NSBundle.LanguageKey.New.rawValue] as? String {
           
            newLanguage = Language(id: id)
        }
        
        self.localizable?.languageWillChange(newLanguage)
    }
    
    private dynamic func receivedLanguageDidChange(notification: NSNotification) {
        
        var oldLanguage: Language?
        var newLanguage: Language?
        
        if let id = notification.userInfo?[NSBundle.LanguageKey.Old.rawValue] as? String {
            
            oldLanguage = Language(id: id)
        }
        
        if let id = notification.userInfo?[NSBundle.LanguageKey.New.rawValue] as? String {
            
            newLanguage = Language(id: id)
        }
        
        self.localizable?.languageDidChange(oldLanguage, newLanguage: newLanguage)
    }
}
