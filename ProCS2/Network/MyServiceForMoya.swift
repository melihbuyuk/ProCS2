//
//  Moya.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit
import Moya

enum MyService {
    case list(page: Int)
    case detail(id: Int)
}

extension MyService: TargetType {
    enum params:String {
        case api_key = "api_key"
        case page = "page"
    }
    
    var baseURL: URL {
        return Constants.urls.baseURL
    }
    
    var path: String {
        switch self {
        case .list:
            return Constants.endPoints.tvSeriesList
        case .detail(let id):
            return Constants.endPoints.tvSeriesDetail + String(id)
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .list(let page):
            return .requestParameters(parameters: [params.api_key.rawValue: Constants.keys.apiKey, params.page.rawValue: page], encoding: URLEncoding.queryString)
        case .detail:
            return .requestParameters(parameters: [params.api_key.rawValue: Constants.keys.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}


