//
//  LanguageTests.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHLocalizationKit

class LanguageTests: XCTestCase {
    
    override func setUp() {
        
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    //code
    func testCode() {
        
        [
            Language(id: "az"),
            Language(code: "az")
        ]
        .forEach {
            
            XCTAssertEqual($0.id, "az")
            XCTAssertEqual($0.code, "az")
            XCTAssertNil($0.script)
            XCTAssertNil($0.region)
            XCTAssertEqual($0.code, $0.id)
        }
    }
    
    //code-region
    func testCodeRegion() {
        
        [
            Language(id: "az-AZ"),
            Language(id: "az_AZ"),
            Language(code: "az", region: "AZ")
        ]
        .forEach {
            
            XCTAssertEqual($0.id, "az-AZ")
            XCTAssertEqual($0.code, "az")
            XCTAssertNil($0.script)
            XCTAssertEqual($0.region, "AZ")
        }
    }
    
    //code-script
    func testCodeScript() {
        
        [
            Language(id: "az-Cyrl"),
            Language(id: "az_Cyrl"),
            Language(code: "az", script: "Cyrl")
        ]
        .forEach {
                
            XCTAssertEqual($0.id, "az-Cyrl")
            XCTAssertEqual($0.code, "az")
            XCTAssertEqual($0.script, "Cyrl")
            XCTAssertNil($0.region)
        }
    }
    
    //code-script-region
    func testCodeScriptRegion() {
        
        let languages = [
            Language(id: "az-Cyrl-AZ"),
            Language(id: "az_Cyrl-AZ"),
            Language(id: "az-Cyrl_AZ"),
            Language(id: "az_Cyrl_AZ"),
            Language(code: "az", script: "Cyrl", region: "AZ")
        ]
        
        languages.forEach {
                
            XCTAssertEqual($0.id, "az-Cyrl-AZ")
            XCTAssertEqual($0.code, "az")
            XCTAssertEqual($0.script, "Cyrl")
            XCTAssertEqual($0.region, "AZ")
        }
        
        for e1 in languages {
            
            for e2 in languages {
                
                XCTAssertEqual(e1, e2)
            }
        }
    }
    
    func testKindness() {
        
        let languages = [
            Language(id: "az-Cyrl-AZ"),
            Language(id: "az_Cyrl-AZ"),
            Language(id: "az-Cyrl_AZ"),
            Language(id: "az_Cyrl_AZ"),
            Language(id: "az-Cyrl"),
            Language(id: "az_Cyrl"),
            Language(id: "az-AZ"),
            Language(id: "az_AZ"),
            Language(id: "az"),
            Language(code: "az", script: "Cyrl", region: "AZ"),
            Language(code: "az", script: "Cyrl"),
            Language(code: "az", region: "AZ"),
            Language(code: "az")
        ]
        
        for e1 in languages {
            
            for e2 in languages {
                
                XCTAssertEqual(e1.code, e2.code)
            }
        }
    }
    
    func testEquality() {
        
        XCTAssertEqual(Language(id: "az-AZ"), Language(id: "az_AZ"));
    }
    
    func testCustomLanguage() {
        
        //code-script-region
        [
            Language(id: "customCode-customScript-customRegion"),
            Language(code: "customCode", script: "customScript", region: "customRegion")
        ]
        .forEach {
                
            XCTAssertEqual($0.id, "customCode-customScript-customRegion")
            XCTAssertEqual($0.code, "customCode")
            XCTAssertEqual($0.script, "customScript")
            XCTAssertEqual($0.region, "customRegion")
        }
        
        //code-region
        [
            Language(code: "customCode", region: "customRegion"),
        ]
        .forEach {
            
            XCTAssertEqual($0.id, "customCode-customRegion")
            XCTAssertEqual($0.code, "customCode")
            XCTAssertNil($0.script)
            XCTAssertEqual($0.region, "customRegion")
        }
        
        //code-script
        [
            Language(code: "customCode", script: "customScript"),
        ]
        .forEach {
            
            XCTAssertEqual($0.id, "customCode-customScript")
            XCTAssertEqual($0.code, "customCode")
            XCTAssertEqual($0.script, "customScript")
            XCTAssertNil($0.region)
        }
        
        //code         
        [
            Language(id: "customCode"),
            Language(code: "customCode")
        ]
        .forEach {
            
            XCTAssertEqual($0.id, "customCode")
            XCTAssertEqual($0.code, "customCode")
            XCTAssertNil($0.script)
            XCTAssertNil($0.region)
            XCTAssertEqual($0.code, $0.id)
        }
    }
}

