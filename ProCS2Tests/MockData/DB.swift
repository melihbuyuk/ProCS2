//
//  DB.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 21.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit

class DBManager {
    static let shared = DBManager()
    
    func isLiked(_ id:Int) -> Bool {
        return false
    }
    
    func likeUnlikeTV(_ id:Int) -> Bool {
        return true
    }
}
