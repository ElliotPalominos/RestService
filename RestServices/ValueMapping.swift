//
//  ValueMapping.swift
//  RestServices
//
//  Created by Elliot Palominos on 5/25/17.
//  Copyright © 2017 Elliot Palominos. All rights reserved.
//

import RestKit

class ValueMapping: NSObject {
    
    class func valueMapped () -> RKObjectMapping {
        
        let value = RKObjectMapping(for: Value.self)
        value?.addAttributeMappings(from: ["one", "key"])
        
        return value!
    }
}
