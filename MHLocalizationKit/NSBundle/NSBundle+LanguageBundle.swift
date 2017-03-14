//
//  NSBundle+LanguageBundle.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension Bundle {
    
    /**
     Creates a bundle with a path for a given language subdirectory, derived from another bundle.
     
     - parameter language: The language for which to lookup.
     - parameter bundle: The bundle into which to look the language subdirectory.
     - returns: A newly created bundle pointing to the language subdirectory of the deriving bundle or the `bundle` itself if a deriving bundle cannot be found.
     
     */
    
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
    
    /**
     Creates a bundle with a path for a given language subdirectory, derived from the receiver.
     
     - parameter language: The language for which to lookup.
     - returns: A newly created bundle pointing to the language subdirectory of the receiver or the receiver itself if a deriving bundle cannot be found.
     
     */
    
    public func bundle(for language: Language) -> Bundle {
        
        return type(of: self).bundle(for: language, in: self)
    }
}
