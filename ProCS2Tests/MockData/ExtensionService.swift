//
//  ExtensionService.swift
//  ProCS2Tests
//
//  Created by Serhat Akkurt on 18.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit

extension MyService {
    var testSampleData: Data {
        switch self {
        case .list:
            return getJson("list")
        case .detail( _):
            return getJson("detail")
        }
    }
    
    func getJson(_ file:String) -> Data {
        if let url = Bundle(for: ProCS2Tests.self).path(forResource: file, ofType: "json") {
            return try! Data(contentsOf: URL(fileURLWithPath: url), options: .alwaysMapped)
        }
        return Data()
    }
}
