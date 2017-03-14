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
    
    /**
     Returns the display name for a given language, localized by the receiver
     
     - parameter language: The language which name is localized and returned
     - returns: The name of the `langauge`, localized by the receiver or nil if the name is unknown.
     
     - seealso: `NSLocale.displayName(forKey:value:)`
     */
    
    public func displayName(for language: Language) -> String? {
        
        return (Locale(identifier: self.id) as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: language.id)
    }
    
    /**
     Returns the display name of the receiver, localized by a given language
     
     - parameter language: The language which is used localized to localized the receiver.
     - returns: The name of the receiver, localized by the input `langauge` or nil if the name is unknown.
.
     */
    public func displayName(on language: Language) -> String? {
        
        return (Locale(identifier: language.id) as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: self.id)
    }
    
    ///The name of the language localized on its own or nil if the name is unknown.
    public var displayName: String? {
        
        return self.displayName(on: self)
    }
}

//MARK: - System Languages

extension Language {
    
    ///The current system language
    ///- seealso: `Locale.current`
    public static var current: Language {
        
        return Language(id: Locale.current.identifier)
    }
    
    ///The preffered system languages
    ///- seealso: `Locale.preferredLanguages`
    public static var preferredSystemLanguages: [Language] {
        
        return Locale.preferredLanguages.map({ Language(id: $0) })
    }
}
