//
//  XCTestExtensions.swift
//  https://gist.github.com/KoCMoHaBTa/4ba07984d7c95822bc05
//
//  Created by Milen Halachev on 3/18/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    public func performExpectation(description: String = "XCTestCase Default Expectation", timeout: NSTimeInterval = 10, handler: (expectation: XCTestExpectation!) -> Void) {
        
        let expectation = self.expectationWithDescription(description)
        handler(expectation: expectation)
        
        self.waitForExpectationsWithTimeout(timeout, handler: { (error) -> Void in
            
            XCTAssertNil(error, "There should be no error")
        })
    }
}

extension XCTestExpectation {
    
    private struct AssociatedKeys {
        
        static var conditionsKey = "XCTestExpectation.AssociatedKeys.conditionsKey"
    }
    
    public private(set) var conditions: [String: Bool] {
        
        get {
            
            return objc_getAssociatedObject(self, &AssociatedKeys.conditionsKey) as? [String: Bool] ?? [:]
        }
        
        set {
            
            objc_setAssociatedObject(self, &AssociatedKeys.conditionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func addConditions(conditions: [String]) {
        
        conditions.forEach { (condition) -> () in
            
            self.conditions[condition] = false
        }
    }
    
    public func fulfillCondition(condition: String) {
        
        guard self.conditions[condition] == false else { return }
        
        self.conditions[condition] = true
        
        for state in Array(self.conditions.values) {
            
            if state == false {
                
                return
            }
        }
        
        self.fulfill()
    }
}