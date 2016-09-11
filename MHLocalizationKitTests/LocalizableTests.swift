//
//  LocalizableTests.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHLocalizationKit

class LocalizableTests: XCTestCase {
    
    private var localizableObject: TestLocalizableViewController!
    
    override func setUp() {
        
        super.setUp()
        
        NSBundle.language = nil
        self.localizableObject = TestLocalizableViewController()
        self.localizableObject.view.setNeedsLayout()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.localizableObject.languageWillChange = nil
        self.localizableObject.languageDidChange = nil
        self.localizableObject = nil
        NSBundle.language = nil
        
        super.tearDown()
    }
    
    func testLocalizableObject() {
        
        self.performExpectation { (expectation) -> Void in
            
            self.localizableObject.languageWillChange = { (obj: TestLocalizableViewController, newLanguage: Language?) -> Void in
                
                print("languageWillChange: \(obj.expectedNewLanguage) == \(newLanguage)")
                XCTAssertEqual(obj.expectedNewLanguage, newLanguage)
            }
            
            self.localizableObject.languageDidChange = { (obj: TestLocalizableViewController, oldLanguage: Language?, newLanguage: Language?) -> Void in
                
                XCTAssertEqual(obj.expectedOldLanguage, oldLanguage)
                XCTAssertEqual(obj.expectedNewLanguage, newLanguage)
                
                if let id = newLanguage?.id {
                    
                    expectation.fulfillCondition(id)
                }
            }
            
            let languages: [Language] = ["en", "bg", "en_US", "en-GB"]
            
            //add the conditions
            expectation.addConditions(languages.map({ $0.id }))
            
            //start testing
            languages.forEach({ (language) in
                
                self.localizableObject.reset(NSBundle.language, expectedNewLanguage: language)
                NSBundle.language = language
            })
        }
    }
}

private class TestLocalizableViewController: UIViewController, Localizable {

    private var expectedOldLanguage: Language?
    private var expectedNewLanguage: Language?
    private var languageWillChange: ((obj: TestLocalizableViewController, newLanguage: Language?) -> Void)?
    private var languageDidChange: ((obj: TestLocalizableViewController, oldLanguage: Language?, newLanguage: Language?) -> Void)?
    
    private func languageWillChange(newLanguage: Language?) {
        
        self.languageWillChange?(obj: self, newLanguage: newLanguage)
    }
    
    private func languageDidChange(oldLanguage: Language?, newLanguage: Language?) {
        
        self.languageDidChange?(obj: self, oldLanguage: oldLanguage, newLanguage: newLanguage)
    }
    
    func reset(expectedOldLanguage: Language? = nil, expectedNewLanguage: Language? = nil) {
        
        self.expectedOldLanguage = expectedOldLanguage
        self.expectedNewLanguage = expectedNewLanguage
    }
}
