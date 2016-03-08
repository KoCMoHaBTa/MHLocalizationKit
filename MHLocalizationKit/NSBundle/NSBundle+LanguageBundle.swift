//
//  NSBundle+LanguageBundle.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NSBundle {
    
    public class func bundleForLanguage(language: Language, inBundle bundle: NSBundle) -> NSBundle {
        
        guard
        let lproj = bundle.pathForResource(language.id, ofType: "lproj"),
        let languageBundle = NSBundle(path: lproj)
        else {
            
            //there is nothing else to try
            if language.code == language.id {
                
                return bundle
            }
            
            //try only with the code
            return self.bundleForLanguage(Language(id: language.code), inBundle: bundle)
        }
        
        return languageBundle
    }
    
    public func bundleForLanguage(language: Language) -> NSBundle {
        
        return self.dynamicType.bundleForLanguage(language, inBundle: self)
    }
}
