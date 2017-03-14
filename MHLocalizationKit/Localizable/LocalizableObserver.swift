//
//  LocalizableObserver.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

class LocalizableObserver: NSObject {
    
    private weak var localizable: Localizable?
    private var _associatedKey: Character = " "
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    init(localizable: Localizable) {
        
        self.localizable = localizable
        
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LocalizableObserver.receivedLanguageWillChange(_:)), name: NSNotification.Name(rawValue: Bundle.LanguageWillChangeNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LocalizableObserver.receivedLanguageDidChange(_:)), name: NSNotification.Name(rawValue: Bundle.LanguageDidChangeNotificationName), object: nil)
    }
    
    func associate() {
        
        objc_setAssociatedObject(self.localizable, &_associatedKey, self, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private dynamic func receivedLanguageWillChange(_ notification: Notification) {
     
        var newLanguage: Language?
        
        if let id = (notification as NSNotification).userInfo?[Bundle.LanguageKey.new.rawValue] as? String {
           
            newLanguage = Language(id: id)
        }
        
        self.localizable?.languageWillChange(to: newLanguage)
    }
    
    private dynamic func receivedLanguageDidChange(_ notification: Notification) {
        
        var oldLanguage: Language?
        var newLanguage: Language?
        
        if let id = (notification as NSNotification).userInfo?[Bundle.LanguageKey.old.rawValue] as? String {
            
            oldLanguage = Language(id: id)
        }
        
        if let id = (notification as NSNotification).userInfo?[Bundle.LanguageKey.new.rawValue] as? String {
            
            newLanguage = Language(id: id)
        }
        
        self.localizable?.languageDidChange(from: oldLanguage, to: newLanguage)
    }
}
