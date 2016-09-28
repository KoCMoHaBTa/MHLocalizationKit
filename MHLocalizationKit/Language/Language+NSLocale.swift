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
    
    public func displayName(for language: Language) -> String? {
        
        return (Locale(identifier: self.id) as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: language.id)
    }
    
    public func displayName(on language: Language) -> String? {
        
        return (Locale(identifier: language.id) as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: self.id)
    }
    
    ///The name of the language translated on its own
    public var displayName: String? {
        
        return self.displayName(on: self)
    }
}

//MARK: - System Languages

extension Language {
    
    public static var systemLanguage: Language {
        
        return Language(id: Locale.current.identifier)
    }
    
    public static var preferredSystemLanguages: [Language] {
        
        return Locale.preferredLanguages.map({ Language(id: $0) })
    }
}
