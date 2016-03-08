//
//  NSBundle+LanguageSwiftLoad.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NSBundle {
    
    public class func _language_swift_load() {
        
        let original = class_getInstanceMethod(self, "localizedStringForKey:value:table:")
        let modified = class_getInstanceMethod(self, "_language_swift_localizedStringForKey:value:table:")
        
        method_exchangeImplementations(original, modified)
        
        self.updateTracking()
    }
    
    //this where all the magic happens
    public func _language_swift_localizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        
        guard
            let language: Language = self.dynamicType.language
            else {
                
                return self._language_swift_localizedStringForKey(key, value: value, table: tableName)
        }
        
        let bundle = self.bundleForLanguage(language)
        
        return bundle._language_swift_localizedStringForKey(key, value: value, table: tableName)
    }
}