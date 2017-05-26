//
//  Request.swift
//  RestServices
//
//  Created by Elliot Palominos on 5/23/17.
//  Copyright © 2017 Elliot Palominos. All rights reserved.
//

import RestKit

protocol RequestDataSource {
    func createMapping() -> RKObjectMapping
    func obtainPathPattern() -> String
    func obtainKeyPath() -> String
    func obtainName() -> String
}

protocol RequestPOSTDataSource : RequestDataSource {
    func createRequestMapping() -> RKObjectMapping
    func createResponseMapping() ->RKObjectMapping
    func getRequestObjectClassForMapping() -> AnyClass
    func getPostObject() -> Any
}

protocol RequestDELETEDataSource : RequestDataSource {
    func getPostObject() -> Any
}

protocol RequestDataSourceWithQueryParams : RequestDataSource {
    func obtainQueryParams() -> NSDictionary
}

class Request: NSObject {
    
    static let baseURL = "http://echo.jsontest.com/"
    
    var responseDescriptor : RKResponseDescriptor!
    var objectManager : RKObjectManager!
    var requestOperation : RKObjectRequestOperation!
    
    fileprivate var baseUrl : String!
    fileprivate var method : RKRequestMethod!
    var dataSource : RequestDataSource!
    
    public init(method: RKRequestMethod) {
        super.init()
        self.method = method
        self.baseUrl = Request.baseURL
    }
    
    public init(dataSource: RequestDataSource!, method: RKRequestMethod) {
        super.init()
        self.dataSource = dataSource
        self.method = method
        self.baseUrl = Request.baseURL
    }
    
    public init(dataSource: RequestDataSource!, method: RKRequestMethod, baseUrl: String) {
        super.init()
        self.dataSource = dataSource
        self.method = method
        self.baseUrl = baseUrl
    }
    
    public func execute(delegate: ResponseProtocol) {
        if self.method == .GET {
            executeObjectRequestOperation(delegate: delegate, withSecure: true)
        } else if self.method == .POST {
            
        } else if self.method == .PATCH {
            
        } else if self.method == .PUT {
            
        } else if self.method == .DELETE {
        
        }
    }
    
    private func executeObjectRequestOperation(delegate: ResponseProtocol, withSecure: Bool) {
        
        var url : URL
        if let _ = self.dataSource as? RequestDataSourceWithQueryParams {
            let queryParams = queryParamsURLEncoded(queryParams: (self.dataSource as! RequestDataSourceWithQueryParams).obtainQueryParams())
            url = URL(string: self.baseUrl + self.dataSource.obtainPathPattern() + queryParams)!
        } else {
            url = URL(string: self.baseUrl + self.dataSource.obtainPathPattern())!
        }
        
        let client = AFRKHTTPClient(baseURL: url)
        //client?.setDefaultHeader("token", value: "valor token") aqui seteamos el header para el cliente
        
        self.responseDescriptor = RKResponseDescriptor(mapping: self.dataSource.createMapping(), method: self.method, pathPattern: "", keyPath: self.dataSource.obtainKeyPath(), statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.successful))
        
        self.objectManager = RKObjectManager(httpClient: client)
        self.objectManager.setAcceptHeaderWithMIMEType(RKMIMETypeJSON)
        self.objectManager.addResponseDescriptor(self.responseDescriptor)
        
        self.objectManager.getObjectsAtPath(self.dataSource.obtainKeyPath(), parameters: nil, success: { (operation, mappingResult) in
            if mappingResult?.array() != nil {
                let object = mappingResult?.array()[0]
                delegate.onResponseSuccess(operation: operation!, object: object as Any)
            }
        }) { (operation, error) in
            delegate.onResponseError(operation: operation!, error: error!)
        }
    }
    
    private func queryParamsURLEncoded(queryParams: NSDictionary) -> String {
        
        let parts: NSMutableArray = NSMutableArray()
        
        for key in queryParams.allKeys {
            let value = queryParams.object(forKey: key as! String)
            let part: String = urlEncoded(object: key as! String) + urlEncoded(object: value as! String)
            parts.add(part)
        }
        
        return parts.componentsJoined(by: "&")
    }
    
    private func urlEncoded(object: String) -> String {
        return object.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
}
