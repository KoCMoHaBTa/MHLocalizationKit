//
//  Language.swift
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public struct Language {
    
    public let id: String   //code-script-region; code-region; code-script; code
    
    //designators
    public let code: String         //2-3 chars: en, bg, fr
    public let script: String?      //4-5 chars: Cyrl, Latn, Arab, POSIX
    public let region: String?      //2 chars: US, GB
    
    private init(id: String, code: String, script: String?, region: String?) {
     
        self.id = id
        self.code = code
        self.script = script
        self.region = region
    }
}

extension Language {
    
    ///Do not use for custom languages, or have in mind that region is restricted to 2 chars for `code-region` `code-script` cases
    public init(id: String) {
        
        let id = id.stringByReplacingOccurrencesOfString("_", withString: "-")
        
        //create designators
        let code: String
        var script: String?
        var region: String?
        
        let components = id.componentsSeparatedByString("-")
        
        switch components.count {
            
        case 3:
            region = components[2]
            fallthrough
        case 2:
            
            if region == nil && components[1].utf8.count == 2  {
                
                region = components[1]
            }
            else {
                
                script = components[1]
            }
            
            
            
            fallthrough
            
        default:
            code = components[0]
        }
        
        self.init(id: id, code: code, script: script, region: region)
    }
}

extension Language {
    
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

extension Language: StringLiteralConvertible {
    
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
