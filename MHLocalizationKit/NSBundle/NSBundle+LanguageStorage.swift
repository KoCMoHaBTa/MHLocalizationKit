//
//  NSBundle+LanguageStorage.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension Bundle {
    
    @nonobjc public static let LanguageWillChangeNotificationName = "MHLocalizationKit.NSBundle.LanguageWillChangeNotificationName"
    @nonobjc public static let LanguageDidChangeNotificationName = "MHLocalizationKit.NSBundle.LanguageDidChangeNotificationName"
    
    ///The keys used in the langauge change notifications userInfo dictionary 
    public enum LanguageKey: String {
        
        case old = "MHLocalizationKit.NSBundle.LanguageKey.Old"
        case new = "MHLocalizationKit.NSBundle.LanguageKey.New"
    }
    
    private static let NSUserDefaultsLanguageKey = "MHLocalizationKit.NSBundle.NSUserDefaultsLanguageKey"
    
    /**
     The language used to load translations.
     
     You can set this property to a value, which will be used to override the Bundle default behaviour and force loading localizations based on the provided language at runtime.
     
     As opposite, if this property is set to nil, the bundle will load translations according to its own default behaviour.
     
     The default value of this property is nil.
     
     - note: Changes can be observed by conforming to the `Localizable` protocol
     
     */
    public static var language: Language? {
        
        get {
        
            guard
            let id = UserDefaults.standard.string(forKey: NSUserDefaultsLanguageKey)
            else { return nil }
            
            return Language(id: id)
        }
        
        set {
            
            let oldValue = self.language
            
            self.willSetLanguage(newValue)
            
            UserDefaults.standard.set(newValue?.rawValue, forKey: NSUserDefaultsLanguageKey)
            UserDefaults.standard.synchronize()
            
            self.didSetLanguage(oldValue)
        }
    }
    
    private static func willSetLanguage(_ newValue: Language?) {
        
        var userInfo = [AnyHashable: Any]()
        userInfo[LanguageKey.old.rawValue] = nil
        userInfo[LanguageKey.new.rawValue] = newValue?.rawValue
        
        let notification = Notification(name: Notification.Name(rawValue: LanguageWillChangeNotificationName), object: nil, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }
    
    
    private static func didSetLanguage(_ oldValue: Language?) {
        
        var userInfo = [AnyHashable: Any]()
        userInfo[LanguageKey.old.rawValue] = oldValue?.rawValue
        userInfo[LanguageKey.new.rawValue] = self.language?.rawValue
        
        let notification = Notification(name: Notification.Name(rawValue: LanguageDidChangeNotificationName), object: nil, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }
    
    
    
    //    public static var supportedLanguages: [Language] = []
    //    public static var defaultLanguage: Language? = nil
}
