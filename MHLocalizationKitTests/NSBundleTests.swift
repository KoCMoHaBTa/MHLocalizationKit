//
//  NSBundleTests.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest

class NSBundleTests: XCTestCase {
    
    override func setUp() {
        
        super.setUp()
        
        NSBundle.language = nil
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        NSBundle.language = nil
        
        super.tearDown()
    }
    
    func testDefaultConfig() {
        
        XCTAssertNil(NSBundle.language)
        NSBundle.language = "bg"
        XCTAssertEqual(NSBundle.language, "bg")
    }
    
    //supported languages should resolve to .lproj folders - we will test only some of them
    func testSupportedLanguageBundle() {

        {
            $0.forEach {
                
                XCTAssertEqual(NSBundle(forClass: self.dynamicType).bundleForLanguage($0).bundleURL.lastPathComponent, "\($0.id).lproj")
            }
            
        }(["en", "en-US", "en_US", "en-GB", "bg", "az-Cyrl-AZ", "az-Cyrl", "az-AZ", "az"])
    }
    
    //non supported languages should resolve to the main bundle
    func testNonSupportedLanguageBundles() {
        
        {
            $0.forEach {
                
                XCTAssertEqual(NSBundle(forClass: self.dynamicType).bundleForLanguage($0), NSBundle(forClass: self.dynamicType))
            }
            
        }(["fr", "nonExistingLanguage"])
    }
}