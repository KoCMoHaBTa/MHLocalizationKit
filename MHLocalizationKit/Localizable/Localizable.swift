//
//  Localizable.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public protocol Localizable: class {

    func languageWillChange(_ newLanguage: Language?)
    func languageDidChange(_ oldLanguage: Language?, newLanguage: Language?)
}

public extension Localizable {
    
    func languageWillChange(_ newLanguage: Language?) {}
    func languageDidChange(_ oldLanguage: Language?, newLanguage: Language?) {}
}

