//
//  ListResponse.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit
import ObjectMapper

class ListResponse: Mappable {
    var page: Int?
    var results: [DetailResponse]?
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map : Map){
        page <- map["page"]
        results <- map["results"]
    }
}
