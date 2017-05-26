//
//  ValueRequest.swift
//  RestServices
//
//  Created by Elliot Palominos on 5/25/17.
//  Copyright © 2017 Elliot Palominos. All rights reserved.
//

import RestKit

class ValueRequest: Request, RequestDataSource {
 
     init() {
        super.init(method: RKRequestMethod.GET)
        self.dataSource = self
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMapping() -> RKObjectMapping {
        return ValueMapping.valueMapped()
    }
    
    func obtainPathPattern() -> String {
        return "key/value/one/two"
    }
    
    func obtainKeyPath() -> String {
        return ""
    }
    
    func obtainName() -> String {
        return NSStringFromClass(NSString.self)
    }

}
