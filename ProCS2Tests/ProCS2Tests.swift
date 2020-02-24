//
//  ProCS2Tests.swift
//  ProCS2Tests
//
//  Created by Serhat Akkurt on 21.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import XCTest
import Moya
@testable import ProCS2

class ProCS2Tests: XCTestCase {
    var providerSuccess: MoyaProvider<MyService>!
    var providerFail: MoyaProvider<MyService>!
    
    override func setUp() {
        providerSuccess = MoyaProvider<MyService>(endpointClosure: customEndpointClosureSuccess, stubClosure: MoyaProvider.delayedStub(2))
        providerFail = MoyaProvider<MyService>(endpointClosure: customEndpointClosureFail, stubClosure: MoyaProvider.immediatelyStub)
    }

    override func tearDown() {
        providerSuccess = nil
        providerFail = nil
    }
    
    func customEndpointClosureSuccess(_ target: MyService) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    func customEndpointClosureFail(_ target: MyService) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(500, Data()) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
}
