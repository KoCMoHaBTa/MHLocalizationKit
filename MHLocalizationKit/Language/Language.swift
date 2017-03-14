//
//  Language.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

///Represents a langauge formed by code, script and region
public struct Language {
    
    public let id: String           //code-script-region; code-region; code-script; code
    
    //designators
    public let code: String         //2-3 chars: en, bg, fr
    public let script: String?      //4-5 chars: Cyrl, Latn, Arab, POSIX
    public let region: String?      //2 chars: US, GB
    
    fileprivate init(id: String, code: String, script: String?, region: String?) {
     
        self.id = id
        self.code = code
        self.script = script
        self.region = region
    }
}

extension Language {
    
    /**
     
     Creates an instance of the receiver by parsing a language id into designators.
     
     - parameter id: The language id in one of the following forms - `code-script-region`, `code-region`, `code-script`, `code`.
     
     - warning: Do not use for custom languages, or have in mind that region is restricted to 2 chars for `code-region`, `code-script` cases.
     
     - note: For custom languages - use `init(code:region:script)`
     */
    public init(id: String) {
        
        let id = id.replacingOccurrences(of: "_", with: "-")
        
        //create designators
        let code: String
        var script: String?
        var region: String?
        
        let components = id.components(separatedBy: "-")
        
        switch components.count {
            
            //the 3rd components is always region
            case 3:
                region = components[2]
                fallthrough
            
            //the second components could be either 2 chars region or a script
            case 2:
                
                if region == nil && components[1].utf8.count == 2  {
                    
                    region = components[1]
                }
                else {
                    
                    script = components[1]
                }
                
                fallthrough
            
            //the first component is always the code
            default:
                code = components[0]
        }
        
        self.init(id: id, code: code, script: script, region: region)
    }
}

extension Language {
    
    ///Creates an instance of the receiver for with a code, script and region
    public init(code: String, script: String? = nil, region: String? = nil) {
        
        //create id
        var id = code
        
        if let script = script {
            
            id += "-\(script)"
        }
        
        if let region = region {
            
            id += "-\(region)"
        }
        
        self.init(id: id, code: code, script: script, region: region)
    }
}

//MARK: - CustomDebugStringConvertible

extension Language: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        
        var designators = ["code": self.code]
        designators["script"] = self.script
        designators["region"] = self.region
        
        return "\(self.id) <=> \(designators.debugDescription)"
    }
}

//MARK: - CustomStringConvertible

//extension Language: CustomStringConvertible {
//
//    public var description: String {
//
//        return self.id
//    }
//}

//MARK: - RawRepresentable

extension Language: RawRepresentable {
    
    public init?(rawValue: String) {
        
        self.init(id: rawValue)
    }
    
    public var rawValue: String {
        
        return self.id
    }
}

//MARK: - StringLiteralConvertible

extension Language: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        
        self.init(id: value)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        
        self.init(id: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        
        self.init(id: value)
    }
}

//MARK: - Hashable

extension Language: Hashable {
    
    public var hashValue: Int {
        
        return self.id.hashValue
    }
}

public func ==(lhs: Language, rhs: Language) -> Bool {
    
    return lhs.id == rhs.id
}
