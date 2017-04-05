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
    
    fileprivate var localizableObject: TestLocalizableViewController!
    
    override func setUp() {
        
        super.setUp()
        
        Bundle.language = nil
        self.localizableObject = TestLocalizableViewController()
        self.localizableObject.view.setNeedsLayout()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.localizableObject.languageWillChange = nil
        self.localizableObject.languageDidChange = nil
        self.localizableObject = nil
        Bundle.language = nil
        
        super.tearDown()
    }
    
    func testLocalizableObject() {
        
        self.performExpectation { (expectation) -> Void in
            
            self.localizableObject.languageWillChange = { (obj: TestLocalizableViewController, newLanguage: Language?) -> Void in
                
                print("languageWillChange: \(String(describing: obj.expectedNewLanguage)) == \(String(describing: newLanguage))")
                XCTAssertEqual(obj.expectedNewLanguage, newLanguage)
            }
            
            self.localizableObject.languageDidChange = { (obj: TestLocalizableViewController, oldLanguage: Language?, newLanguage: Language?) -> Void in
                
                XCTAssertEqual(obj.expectedOldLanguage, oldLanguage)
                XCTAssertEqual(obj.expectedNewLanguage, newLanguage)
                
                if let id = newLanguage?.id {
                    
                    expectation.fulfill(condition: id)
                }
            }
            
            let languages: [Language] = ["en", "bg", "en_US", "en-GB"]
            
            //add the conditions
            expectation.add(conditions: languages.map({ $0.id }))
            
            //start testing
            languages.forEach({ (language) in
                
                self.localizableObject.reset(Bundle.language, expectedNewLanguage: language)
                Bundle.language = language
            })
        }
    }
}

private class TestLocalizableViewController: UIViewController, Localizable {

    fileprivate var expectedOldLanguage: Language?
    fileprivate var expectedNewLanguage: Language?
    fileprivate var languageWillChange: ((_ obj: TestLocalizableViewController, _ newLanguage: Language?) -> Void)?
    fileprivate var languageDidChange: ((_ obj: TestLocalizableViewController, _ oldLanguage: Language?, _ newLanguage: Language?) -> Void)?
    
    fileprivate func languageWillChange(to new: Language?) {
        
        self.languageWillChange?(self, new)
    }
    
    fileprivate func languageDidChange(from old: Language?, to new: Language?) {
        
        self.languageDidChange?(self, old, new)
    }
    
    func reset(_ expectedOldLanguage: Language? = nil, expectedNewLanguage: Language? = nil) {
        
        self.expectedOldLanguage = expectedOldLanguage
        self.expectedNewLanguage = expectedNewLanguage
    }
}
