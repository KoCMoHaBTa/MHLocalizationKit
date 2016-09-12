//
//  NSBundle+LanguageBundle.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension Bundle {
    
    public class func bundle(for language: Language, in bundle: Bundle) -> Bundle {
        
        guard
        let lproj = bundle.path(forResource: language.id, ofType: "lproj"),
        let languageBundle = Bundle(path: lproj)
        else {
            
            //there is nothing else to try
            if language.code == language.id {
                
                return bundle
            }
            
            //try only with the code
            return self.bundle(for: Language(id: language.code), in: bundle)
        }
        
        return languageBundle
    }
    
    public func bundle(for language: Language) -> Bundle {
        
        return type(of: self).bundle(for: language, in: self)
    }
}
