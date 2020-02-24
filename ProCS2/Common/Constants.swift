//
//  Constants.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit

struct Constants {
    struct urls {
        static let baseURL: URL = {
            guard let url = URL(string: "https://api.themoviedb.org/3") else {
                fatalError("Root URL is invalid")
            }
            return url
        }()
        static let imageBaseURL = "https://image.tmdb.org/t/p"
        static let dummyImage = "http://forevervacationrentals.com/images/no-image-available2.jpg"
    }
    
    struct endPoints {
        static let tvSeriesList = "/tv/popular"
        static let tvSeriesDetail = "/tv/"
    }
    
    struct keys {
        static let apiKey = "e700d5f428fd2d7f826f5570aa5c4048"
    }
    
    struct imageSizes {
        static let w400 = "/w400"
    }
    
    struct duration {
        static let reloadDuration:Double = 1.minute
    }
}
