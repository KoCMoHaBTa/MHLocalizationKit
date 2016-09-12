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
    
    public enum LanguageKey: String {
        
        case Old = "MHLocalizationKit.NSBundle.LanguageKey.Old"
        case New = "MHLocalizationKit.NSBundle.LanguageKey.New"
    }
    
    private static let NSUserDefaultsLanguageKey = "MHLocalizationKit.NSBundle.NSUserDefaultsLanguageKey"
    
    public static var language: Language? {
        
        get {
        
        guard
        let id = UserDefaults.standard.string(forKey: NSUserDefaultsLanguageKey)
        else {
        
        return nil
        }
        
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
        userInfo[LanguageKey.Old.rawValue] = nil
        userInfo[LanguageKey.New.rawValue] = newValue?.rawValue
        
        let notification = Notification(name: Notification.Name(rawValue: LanguageWillChangeNotificationName), object: nil, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }
    
    
    private static func didSetLanguage(_ oldValue: Language?) {
        
        var userInfo = [AnyHashable: Any]()
        userInfo[LanguageKey.Old.rawValue] = oldValue?.rawValue
        userInfo[LanguageKey.New.rawValue] = self.language?.rawValue
        
        let notification = Notification(name: Notification.Name(rawValue: LanguageDidChangeNotificationName), object: nil, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }
    
    
    
    //    public static var supportedLanguages: [Language] = []
    //    public static var defaultLanguage: Language? = nil
}
