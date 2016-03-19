//
//  MHLocalizationKit.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

//https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html

//public func LanguageLookup(language: Language, defaultLanguage: Language, supportedLanguages: [Language]) -> Language {
//    
//    //lookup by id
//    if let index = supportedLanguages.indexOf(language) {
//        
//        return supportedLanguages[index]
//    }
//    
//    //lookup by code
//    if let index = supportedLanguages.indexOf({ $0.code == language.code }) {
//        
//        return supportedLanguages[index]
//    }
//    
//    return defaultLanguage
//}

//Language(id: "en-Latn_US").displayNameForLanguage("bg")
//let language: Language = "en-GB"
//language.displayNameOnLanguage("en")




//some convenience NSLocalizaedString functions that are missing from ObjC world and will allow genstrings to work properly
public func NSLocalizedStringFromTable(key: String, _ tableName: String, _ comment: String) -> String {
    
    return NSLocalizedString(key, tableName: tableName, comment: comment)
}

public func NSLocalizedStringWithDefaultValue(key: String, _ tableName: String, _ bundle: NSBundle, _ value: String, _ comment: String) -> String {
    
    return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}