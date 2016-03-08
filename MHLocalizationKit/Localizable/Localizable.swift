//
//  Localizable.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public protocol Localizable {

    func languageWillChange(old: Language?, new: Language?)
    func languageDidChange(old: Language?, new: Language?)
}

public extension Localizable {
    
    func languageWillChange(old: Language?, new: Language?) {}
    func languageDidChange(old: Language?, new: Language?) {}
}

