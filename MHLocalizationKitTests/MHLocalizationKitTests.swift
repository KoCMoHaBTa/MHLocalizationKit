//
//  MHLocalizationKitTests.swift
//  MHLocalizationKitTests
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHLocalizationKit

class MHLocalizationKitTests: XCTestCase {
    
    override func setUp() {
        
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Bundle.language = nil
    }
    
    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        Bundle.language = nil
        
        super.tearDown()
    }
    
    func testLocalizedString() {
        
        let languages: [Language] = ["en", "en-US", "en_US", "en-GB", "bg", "az-Cyrl-AZ", "az-Cyrl", "az-AZ", "az"]
        
        languages.forEach {
            
            Bundle.language = $0
            let bundle = Bundle(for: type(of: self))
            
            XCTAssertEqual(bundle.localizedString(forKey: "test value", value: nil, table: nil), $0.id)
        }
    }
    
    func testLocalizedStringFromTable() {
        
        let languages: [Language] = ["en", "en-US", "en_US"]
        
        languages.forEach {
            
            Bundle.language = $0
            let bundle = Bundle(for: type(of: self))
            
            XCTAssertEqual(bundle.localizedString(forKey: "test value in custom table", value: nil, table: "TestTable"), $0.id)
        }
    }
    
    func testUntranslatedStrings() {
        
        let languages: [Language] = ["de"]
        
        languages.forEach {
            
            Bundle.language = $0
            let bundle = Bundle(for: type(of: self))
            
            XCTAssertEqual(bundle.localizedString(forKey: "value that is not translated", value: nil, table: nil), "value that is not translated")
            XCTAssertEqual(bundle.localizedString(forKey: "value that is not translated", value: nil, table: "TestTable"), "value that is not translated")
            
            XCTAssertEqual(bundle.localizedString(forKey: "value that is not translated", value: "zz1", table: nil), "zz1")
            XCTAssertEqual(bundle.localizedString(forKey: "value that is not translated", value: "zz2", table: "TestTable"), "zz2")
        }
    }
    
    func testNilLanguageString() {
        
        Bundle.language = nil
        let bundle = Bundle(for: type(of: self))
        
        XCTAssertEqual(bundle.localizedString(forKey: "test value", value: nil, table: nil), "en")
        XCTAssertEqual(bundle.localizedString(forKey: "test value in custom table", value: nil, table: "TestTable"), "en")
        
        XCTAssertEqual(bundle.localizedString(forKey: "value that is not translated", value: nil, table: nil), "value that is not translated")
        XCTAssertEqual(bundle.localizedString(forKey: "value that is not translated", value: nil, table: "TestTable"), "value that is not translated")
        
        XCTAssertEqual(bundle.localizedString(forKey: "value that is not translated", value: "zz1", table: nil), "zz1")
        XCTAssertEqual(bundle.localizedString(forKey: "value that is not translated", value: "zz2", table: "TestTable"), "zz2")
    }    
}
