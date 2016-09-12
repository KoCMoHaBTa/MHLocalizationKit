//
//  NSBundle+LanguageSwiftLoad.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension Bundle {
    
    public class func _language_swift_load() {
        
        let original = class_getInstanceMethod(self, #selector(Bundle.localizedString(forKey:value:table:)))
        let modified = class_getInstanceMethod(self, #selector(Bundle._language_swift_localizedString(forKey:value:table:)))
        
        method_exchangeImplementations(original, modified)
        
        self.updateTracking()
    }
    
    //this where all the magic happens
    public func _language_swift_localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        
        guard
            let language: Language = type(of: self).language
            else {
                
                return self._language_swift_localizedString(forKey: key, value: value, table: tableName)
        }
        
        let bundle = self.bundle(for: language)
        
        return bundle._language_swift_localizedString(forKey: key, value: value, table: tableName)
    }
}
