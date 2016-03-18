//
//  NSBundleTests.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHLocalizationKit

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
    
    func testLanguageChange() {
        
        self.performExpectation { (expectation) -> Void in
            
            {
                $0.forEach {
                    
                    let providedLanguageID = $0
                    
                    expectation.addConditions(["\(providedLanguageID)-\(NSBundle.LanguageWillChangeNotificationName)", "\(providedLanguageID)-\(NSBundle.LanguageDidChangeNotificationName)"])
                }
                
                $0.forEach {
                    
                    let providedLanguageID = $0
                    let providedLanguage = Language(id: providedLanguageID)
                    let expectedOldLanguage = NSBundle.language
                    
                    var o1: NSObjectProtocol!
                    o1 = NSNotificationCenter.defaultCenter().addObserverForName(NSBundle.LanguageWillChangeNotificationName, object: nil, queue: nil, usingBlock: { (notification) -> Void in
                        
                        NSNotificationCenter.defaultCenter().removeObserver(o1, name: NSBundle.LanguageWillChangeNotificationName, object: nil)
                        
                        XCTAssertNotNil(notification)
                        XCTAssertNotNil(notification.userInfo)
                        XCTAssertNil(notification.userInfo?[NSBundle.LanguageKey.Old.rawValue])
                        XCTAssertEqual(notification.userInfo?[NSBundle.LanguageKey.New.rawValue] as? String, providedLanguage.rawValue)
                        
                        expectation.fulfillCondition("\(providedLanguageID)-\(NSBundle.LanguageWillChangeNotificationName)")
                    })
                    
                    var o2: NSObjectProtocol!
                    o2 = NSNotificationCenter.defaultCenter().addObserverForName(NSBundle.LanguageDidChangeNotificationName, object: nil, queue: nil, usingBlock: { (notification) -> Void in
                        
                        NSNotificationCenter.defaultCenter().removeObserver(o2, name: NSBundle.LanguageDidChangeNotificationName, object: nil)
                        
                        XCTAssertNotNil(notification)
                        XCTAssertNotNil(notification.userInfo)
                        XCTAssertEqual(notification.userInfo?[NSBundle.LanguageKey.Old.rawValue] as? String, expectedOldLanguage?.rawValue)
                        XCTAssertEqual(notification.userInfo?[NSBundle.LanguageKey.New.rawValue] as? String, providedLanguage.rawValue)
                        
                        expectation.fulfillCondition("\(providedLanguageID)-\(NSBundle.LanguageDidChangeNotificationName)")
                    })
                    
                    NSBundle.language = providedLanguage
                }
                
            }(["en", "en-US", "bg, az-Cyrl-AZ", "en_GB"])
        }
    }
}