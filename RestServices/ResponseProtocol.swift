//
//  ResponseProtocol.swift
//  RestServices
//
//  Created by Elliot Palominos on 5/23/17.
//  Copyright © 2017 Elliot Palominos. All rights reserved.
//

import RestKit

protocol ResponseProtocol {
    func onResponseSuccess(operation: RKObjectRequestOperation, object: Any)
    func onResponseError(operation:RKObjectRequestOperation, error: Error)
}
