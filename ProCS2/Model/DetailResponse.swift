//
//  DetailResponse.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit
import ObjectMapper

class DetailResponse: Mappable {
    var id: Int?
    var name: String?
    var poster_path: String?
    var genres: [Genre]?
    var number_of_seasons: Int = 0
    var number_of_episodes: Int = 0
    var vote_average: Double = 0
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map : Map){
        id <- map["id"]
        name <- map["name"]
        poster_path <- map["poster_path"]
        genres <- map["genres"]
        number_of_seasons <- map["number_of_seasons"]
        number_of_episodes <- map["number_of_episodes"]
        vote_average <- map["vote_average"]
    }
}

class Genre: Mappable {
    var id: Int?
    var name: String?
    
    required init?(map: Map) {}
    
    func mapping(map : Map){
        id <- map["id"]
        name <- map["name"]
    }
}
