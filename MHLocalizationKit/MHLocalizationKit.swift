//
//  MHLocalizationKit.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

//https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html

//some convenience NSLocalizaedString functions that are missing from ObjC world and will allow genstrings to work properly
public func NSLocalizedStringFromTable(_ key: String, _ tableName: String, _ comment: String) -> String {
    
    return NSLocalizedString(key, tableName: tableName, comment: comment)
}

public func NSLocalizedStringWithDefaultValue(_ key: String, _ tableName: String, _ bundle: Bundle, _ value: String, _ comment: String) -> String {
    
    return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}
