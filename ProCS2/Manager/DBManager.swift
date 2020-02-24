//
//  DBManager.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    //MARK: - Variables
    private var database:Realm
    static let shared = DBManager()
    
    //MARK: - Initializer
    private init() {
        database = try! Realm()
    }
    
    //MARK: - Main Methods
    func getDataFromDB() -> Results<DBItem> {
        let results: Results<DBItem> = database.objects(DBItem.self)
        return results
    }
    
    func addData(object: DBItem) {
        try! database.write {
            database.add(object)
        }
    }
    
    func deleteAllFromDatabase() {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: DBItem) {
        let objc = database.objects(DBItem.self).filter("id == %@", object.id)
        guard let attachmentObject =  objc.first else { return print("cannot delete child") }
        try! database.write {
            database.delete(objc)
            database.delete(attachmentObject)
        }
    }
}

extension DBManager {
    //check tv show liked
    func isLiked(_ id:Int) -> Bool {
        if !getDataFromDB().isEmpty, let _ = getDataFromDB().first(where: {$0.id == id}) {
            return true
        }
        return false
    }
    
    //like or unlike tv show
    func likeUnlikeTV(_ id:Int) -> Bool {
        let item = DBItem()
        item.id = id
        if !getDataFromDB().isEmpty, let _ = getDataFromDB().first(where: {$0.id == id}) {
            deleteFromDb(object: item)
            return false
        } else {
            addData(object: item)
            return true
        }
    }
}
