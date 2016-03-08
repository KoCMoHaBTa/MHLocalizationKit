//
//  NSBundle+SystemTracking.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NSBundle {
    
    @nonobjc public static var TrackSystemLanguageChanges = false {
        
        didSet {
            
            self.updateTracking()
        }
    }
    
    @nonobjc public static var TrackSystemLocaleChanges = false {
        
        didSet {
            
            self.updateTracking()
        }
    }
    
    private static let NSUserDefaultsSystemLanguageKey = "MHLocalizationKit.NSBundle.NSUserDefaultsSystemLanguageKey"
    
    private static var savedSystemLanguage: String? {
        
        get {
        
            return NSUserDefaults.standardUserDefaults().stringForKey(NSUserDefaultsSystemLanguageKey)
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: NSUserDefaultsSystemLanguageKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    private static let NSUserDefaultsSystemLocaleKey = "MHLocalizationKit.NSBundle.NSUserDefaultsSystemLocaleLanguageKey"
    
    private static var savedSystemLocale: String? {
        
        get {
        
            return NSUserDefaults.standardUserDefaults().stringForKey(NSUserDefaultsSystemLocaleKey)
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: NSUserDefaultsSystemLocaleKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private static var currentSystemLanguage: String? {
        
        return NSLocale.preferredLanguages().first
    }
    
    private static var currentSystemLocale: String? {
        
        return NSLocale.currentLocale().localeIdentifier
    }
    
    private static var systemLanguageHasChanged: Bool {
        
        return self.currentSystemLanguage != self.savedSystemLanguage
    }
    
    private static var systemLocaleHasChanged: Bool {
        
        return self.currentSystemLocale != self.savedSystemLocale
    }
    
    internal static func updateTracking() {
        
        struct DispatchOnce {
            
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&DispatchOnce.token) {
            
            NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationDidBecomeActiveNotification, object: nil, queue: nil, usingBlock: { (notification) -> Void in
                
                self.updateTracking()
            })
        }
        
        if TrackSystemLanguageChanges && self.systemLanguageHasChanged, let id = self.currentSystemLanguage {
            
            self.language = Language(id: id)
        }
        
        if TrackSystemLocaleChanges && self.systemLocaleHasChanged, let id = self.currentSystemLocale {
            
            self.language = Language(id: id)
        }
    }
}