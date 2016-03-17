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
        
        {
            $0.forEach {
                
                XCTAssertEqual($0.id, "az")
                XCTAssertEqual($0.code, "az")
                XCTAssertNil($0.script)
                XCTAssertNil($0.region)
                XCTAssertEqual($0.code, $0.id)
            }
            
        }([
            Language(id: "az"),
            Language(code: "az")
            ])
    }
    
    //code-region
    func testCodeRegion() {
        
        //code-region
        {
            $0.forEach {
                
                XCTAssertEqual($0.id, "az-AZ")
                XCTAssertEqual($0.code, "az")
                XCTAssertNil($0.script)
                XCTAssertEqual($0.region, "AZ")
            }
            
        }([
            Language(id: "az-AZ"),
            Language(id: "az_AZ"),
            Language(code: "az", region: "AZ")
            ]);
    }
    
    //code-script
    func testCodeScript() {
        
        {
            $0.forEach {
                
                XCTAssertEqual($0.id, "az-Cyrl")
                XCTAssertEqual($0.code, "az")
                XCTAssertEqual($0.script, "Cyrl")
                XCTAssertNil($0.region)
            }
            
        }([
            Language(id: "az-Cyrl"),
            Language(id: "az_Cyrl"),
            Language(code: "az", script: "Cyrl")
            ]);
    }
    
    //code-script-region
    func testCodeScriptRegion() {
        
        {
            $0.forEach {
                
                XCTAssertEqual($0.id, "az-Cyrl-AZ")
                XCTAssertEqual($0.code, "az")
                XCTAssertEqual($0.script, "Cyrl")
                XCTAssertEqual($0.region, "AZ")
            }
            
            for e1 in $0 {
                
                for e2 in $0 {
                    
                    XCTAssertEqual(e1, e2)
                }
            }
            
        }([
            Language(id: "az-Cyrl-AZ"),
            Language(id: "az_Cyrl-AZ"),
            Language(id: "az-Cyrl_AZ"),
            Language(id: "az_Cyrl_AZ"),
            Language(code: "az", script: "Cyrl", region: "AZ")
            ]);
    }
    
    func testKindness() {
        
        {
            for e1 in $0 {
                
                for e2 in $0 {
                    
                    XCTAssertEqual(e1.code, e2.code)
                }
            }
            
        }([
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
            ]);
    }
    
    func testEquality() {
        
        XCTAssertEqual(Language(id: "az-AZ"), Language(id: "az_AZ"));
    }
    
    func testCustomLanguage() {
        
        //code-script-region
        {
            $0.forEach {
                
                XCTAssertEqual($0.id, "customCode-customScript-customRegion")
                XCTAssertEqual($0.code, "customCode")
                XCTAssertEqual($0.script, "customScript")
                XCTAssertEqual($0.region, "customRegion")
            }
            
        }([
            Language(id: "customCode-customScript-customRegion"),
            Language(code: "customCode", script: "customScript", region: "customRegion")
            ]);
        
        //code-region
        {
            $0.forEach {
                
                XCTAssertEqual($0.id, "customCode-customRegion")
                XCTAssertEqual($0.code, "customCode")
                XCTAssertNil($0.script)
                XCTAssertEqual($0.region, "customRegion")
            }
            
        }([
            Language(code: "customCode", region: "customRegion"),
            ]);
        
        
        //code-script
        {
            $0.forEach {
                
                XCTAssertEqual($0.id, "customCode-customScript")
                XCTAssertEqual($0.code, "customCode")
                XCTAssertEqual($0.script, "customScript")
                XCTAssertNil($0.region)
            }
            
        }([
            Language(code: "customCode", script: "customScript"),
            ]);
        
        //code 
        {
            $0.forEach {
                
                XCTAssertEqual($0.id, "customCode")
                XCTAssertEqual($0.code, "customCode")
                XCTAssertNil($0.script)
                XCTAssertNil($0.region)
                XCTAssertEqual($0.code, $0.id)
            }
            
        }([
            Language(id: "customCode"),
            Language(code: "customCode")
            ])
    }
}

