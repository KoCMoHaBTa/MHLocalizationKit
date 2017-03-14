//
//  Localizable.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

/**
 Conform to the Localizable protocol in order to automatically receive langauge changes in your UIViewController.
    
 Using method swizzling, upon viewDidLoad and when a language changes, if a view controller is conforming to this protocol - it will automatically receive notifications trought the `languageWillChange` and the `languageDidChange` methods.
 */

public protocol Localizable: class {

    ///Called in order to notify the receiver that the langauge will be changed.
    ///- parameter new: The language that will be applied.
    func languageWillChange(to new: Language?)
    
    ///Called in order to notify the receiver that the langauge has been changed.
    ///- parameter old: The previous language.
    ///- parameter new: The language that has been applied.
    func languageDidChange(from old: Language?, to new: Language?)
}

public extension Localizable {
    
    //default empty implementation makes this method optional
    func languageWillChange(to new: Language?) {}
}

