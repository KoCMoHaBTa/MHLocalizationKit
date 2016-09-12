//
//  NSBundle+SystemTracking.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension Bundle {
    
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
    
    private static let applicationDidBecomeActiveObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil, using: { (notification) -> Void in
        
        Bundle.updateTracking()
    })
    
    internal static func updateTracking() {
        
        struct DispatchOnce {
            
            private typealias Block = () -> Void
            private static let blocks: [Block] = [
                
                {
                    
                }
            ]
            
            static func execute() {
                
                
            }
        }
        
        //since dispatch once is no longe available - we have to do it in this ungly way
        let _ = applicationDidBecomeActiveObserver
        
        if TrackSystemLanguageChanges && self.systemLanguageHasChanged, let id = self.currentSystemLanguage {
            
            self.language = Language(id: id)
        }
        
        if TrackSystemLocaleChanges && self.systemLocaleHasChanged, let id = self.currentSystemLocale {
            
            self.language = Language(id: id)
        }
    }
}
