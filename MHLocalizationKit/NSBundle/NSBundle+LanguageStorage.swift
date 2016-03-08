//
//  NSBundle+LanguageStorage.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NSBundle {
    
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
        let id = NSUserDefaults.standardUserDefaults().stringForKey(NSUserDefaultsLanguageKey)
        else {
        
        return nil
        }
        
        return Language(id: id)
        }
        
        set {
            
            let oldValue = self.language
            
            self.willSetLanguage(newValue)
            
            NSUserDefaults.standardUserDefaults().setObject(newValue?.rawValue, forKey: NSUserDefaultsLanguageKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.didSetLanguage(oldValue)
        }
    }
    
    private static func willSetLanguage(newValue: Language?) {
        
        var userInfo = [NSObject: AnyObject]()
        userInfo[LanguageKey.Old.rawValue] = nil
        userInfo[LanguageKey.New.rawValue] = newValue as? AnyObject
        
        let notification = NSNotification(name: LanguageWillChangeNotificationName, object: nil, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    
    private static func didSetLanguage(oldValue: Language?) {
        
        var userInfo = [NSObject: AnyObject]()
        userInfo[LanguageKey.Old.rawValue] = oldValue as? AnyObject
        userInfo[LanguageKey.New.rawValue] = self.language as? AnyObject
        
        let notification = NSNotification(name: LanguageWillChangeNotificationName, object: nil, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    
    
    //    public static var supportedLanguages: [Language] = []
    //    public static var defaultLanguage: Language? = nil
}
