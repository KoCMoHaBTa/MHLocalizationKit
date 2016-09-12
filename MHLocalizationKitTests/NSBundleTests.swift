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
        
        Bundle.language = nil
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        Bundle.language = nil
        
        super.tearDown()
    }
    
    func testDefaultConfig() {
        
        XCTAssertNil(Bundle.language)
        Bundle.language = "bg"
        XCTAssertEqual(Bundle.language, "bg")
    }
    
    //supported languages should resolve to .lproj folders - we will test only some of them
    func testSupportedLanguageBundle() {

        {
            $0.forEach {
                
                XCTAssertEqual(Bundle(for: type(of: self)).bundle(for: $0).bundleURL.lastPathComponent, "\($0.id).lproj")
            }
            
        }(["en", "en-US", "en_US", "en-GB", "bg", "az-Cyrl-AZ", "az-Cyrl", "az-AZ", "az"])
    }
    
    //non supported languages should resolve to the main bundle
    func testNonSupportedLanguageBundles() {
        
        {
            $0.forEach {
                
                XCTAssertEqual(Bundle(for: type(of: self)).bundle(for: $0), Bundle(for: type(of: self)))
            }
            
        }(["fr", "nonExistingLanguage"])
    }
    
    func testLanguageChange() {
        
        self.performExpectation { (expectation) -> Void in
            
            {
                $0.forEach {
                    
                    let providedLanguageID = $0
                    
                    expectation.add(conditions: ["\(providedLanguageID)-\(Bundle.LanguageWillChangeNotificationName)", "\(providedLanguageID)-\(Bundle.LanguageDidChangeNotificationName)"])
                }
                
                $0.forEach {
                    
                    let providedLanguageID = $0
                    let providedLanguage = Language(id: providedLanguageID)
                    let expectedOldLanguage = Bundle.language
                    
                    var o1: NSObjectProtocol!
                    o1 = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Bundle.LanguageWillChangeNotificationName), object: nil, queue: nil, using: { (notification) -> Void in
                        
                        NotificationCenter.default.removeObserver(o1, name: NSNotification.Name(rawValue: Bundle.LanguageWillChangeNotificationName), object: nil)
                        
                        XCTAssertNotNil(notification)
                        XCTAssertNotNil((notification as NSNotification).userInfo)
                        XCTAssertNil((notification as NSNotification).userInfo?[Bundle.LanguageKey.Old.rawValue])
                        XCTAssertEqual((notification as NSNotification).userInfo?[Bundle.LanguageKey.New.rawValue] as? String, providedLanguage.rawValue)
                        
                        expectation.fulfill(condition: "\(providedLanguageID)-\(Bundle.LanguageWillChangeNotificationName)")
                    })
                    
                    var o2: NSObjectProtocol!
                    o2 = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Bundle.LanguageDidChangeNotificationName), object: nil, queue: nil, using: { (notification) -> Void in
                        
                        NotificationCenter.default.removeObserver(o2, name: NSNotification.Name(rawValue: Bundle.LanguageDidChangeNotificationName), object: nil)
                        
                        XCTAssertNotNil(notification)
                        XCTAssertNotNil((notification as NSNotification).userInfo)
                        XCTAssertEqual((notification as NSNotification).userInfo?[Bundle.LanguageKey.Old.rawValue] as? String, expectedOldLanguage?.rawValue)
                        XCTAssertEqual((notification as NSNotification).userInfo?[Bundle.LanguageKey.New.rawValue] as? String, providedLanguage.rawValue)
                        
                        expectation.fulfill(condition: "\(providedLanguageID)-\(Bundle.LanguageDidChangeNotificationName)")
                    })
                    
                    Bundle.language = providedLanguage
                }
                
            }(["en", "en-US", "bg, az-Cyrl-AZ", "en_GB"])
        }
    }
}
