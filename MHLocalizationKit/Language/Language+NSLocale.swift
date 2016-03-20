//
//  Language+NSLocale.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/8/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

//MARK: - Display Name

extension Language {
    
    public func displayNameForLanguage(language: Language) -> String? {
        
        return NSLocale(localeIdentifier: self.id).displayNameForKey(NSLocaleIdentifier, value: language.id)
    }
    
    public func displayNameOnLanguage(language: Language) -> String? {
        
        return NSLocale(localeIdentifier: language.id).displayNameForKey(NSLocaleIdentifier, value: self.id)
    }
    
    ///The name of the language translated on its own
    public var displayName: String? {
        
        return self.displayNameOnLanguage(self)
    }
}

//MARK: - System Languages

extension Language {
    
    public static var systemLanguage: Language {
        
        return Language(id: NSLocale.currentLocale().localeIdentifier)
    }
    
    public static var preferredSystemLanguages: [Language] {
        
        return NSLocale.preferredLanguages().map({ Language(id: $0) })
    }
}