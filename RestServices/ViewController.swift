//
//  ViewController.swift
//  RestServices
//
//  Created by Elliot Palominos on 5/23/17.
//  Copyright © 2017 Elliot Palominos. All rights reserved.
//

import UIKit
import RestKit

class ViewController: UIViewController, ResponseProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = ValueRequest()
        request.execute(delegate: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onResponseSuccess(operation: RKObjectRequestOperation, object: Any) {
        let value = object as! Value
        
        print(value.one!)
        print(value.key!)
    }
    
    func onResponseError(operation: RKObjectRequestOperation, error: Error) {
        
    }
}

