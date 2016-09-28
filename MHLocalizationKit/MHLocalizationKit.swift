//
//  MHLocalizationKit.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

//https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html

///performs a lookup for a given language among a collection of supported langauges with a default langauge as a fallback. Returns the given languages if founds, otherwise the default language.
public func LanguageLookup(_ language: Language, defaultLanguage: Language, supportedLanguages: [Language]) -> Language {
    
    if let index = supportedLanguages.indexOfLanguage(language) {
        
        return supportedLanguages[index]
    }
    
    return defaultLanguage
}

extension Collection where Iterator.Element == Language {
    
    
    public func indexOfLanguage(_ element: Self.Iterator.Element) -> Self.Index? {
        
        //lookup by id ?? code
        return self.index(of: element) ?? self.index(where: { $0.code == element.code })
    }
    
    
    public func containsLanguage(_ element: Self.Iterator.Element) -> Bool {
        
        return self.indexOfLanguage(element) != nil
    }
}

//some convenience NSLocalizaedString functions that are missing from ObjC world and will allow genstrings to work properly
public func NSLocalizedStringFromTable(_ key: String, _ tableName: String, _ comment: String) -> String {
    
    return NSLocalizedString(key, tableName: tableName, comment: comment)
}

public func NSLocalizedStringWithDefaultValue(_ key: String, _ tableName: String, _ bundle: Bundle, _ value: String, _ comment: String) -> String {
    
    return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}
