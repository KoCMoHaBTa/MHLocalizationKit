//
//  NSBundle+SystemTracking.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension Bundle {
    
    ///Determines whenever to track system language changes. If true, when the system language is changed, upon opening the application, the bundle custom language will be changed to the new system language. Default to false.
    @nonobjc public static var trackSystemLanguageChanges = false {
        
        didSet {
            
            self.updateTracking()
        }
    }
    
    ///Determines whenever to track system locale changes. If true, when the system locale is changed, upon opening the application, the bundle custom language will be changed to the new system locale. Default to false.
    @nonobjc public static var trackSystemLocaleChanges = false {
        
        didSet {
            
            self.updateTracking()
        }
    }
    
    private static let NSUserDefaultsSystemLanguageKey = "MHLocalizationKit.NSBundle.NSUserDefaultsSystemLanguageKey"
    
    private static var savedSystemLanguage: String? {
        
        get {
        
            return UserDefaults.standard.string(forKey: NSUserDefaultsSystemLanguageKey)
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: NSUserDefaultsSystemLanguageKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    private static let NSUserDefaultsSystemLocaleKey = "MHLocalizationKit.NSBundle.NSUserDefaultsSystemLocaleLanguageKey"
    
    private static var savedSystemLocale: String? {
        
        get {
        
            return UserDefaults.standard.string(forKey: NSUserDefaultsSystemLocaleKey)
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: NSUserDefaultsSystemLocaleKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    private static var currentSystemLanguage: String? {
        
        return Locale.preferredLanguages.first
    }
    
    private static var currentSystemLocale: String? {
        
        return Locale.current.identifier
    }
    
    private static var systemLanguageHasChanged: Bool {
        
        return self.currentSystemLanguage != self.savedSystemLanguage
    }
    
    private static var systemLocaleHasChanged: Bool {
        
        return self.currentSystemLocale != self.savedSystemLocale
    }
    
    private static let applicationDidBecomeActiveObserver = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil, using: { (notification) -> Void in
        
        Bundle.updateTracking()
    })
    
    internal static func updateTracking() {
        
        //since dispatch once is no longe available - we have to do it in this ungly way
        let _ = applicationDidBecomeActiveObserver
        
        if trackSystemLanguageChanges && self.systemLanguageHasChanged, let id = self.currentSystemLanguage {
            
            self.language = Language(id: id)
        }
        
        if trackSystemLocaleChanges && self.systemLocaleHasChanged, let id = self.currentSystemLocale {
            
            self.language = Language(id: id)
        }
    }
}
