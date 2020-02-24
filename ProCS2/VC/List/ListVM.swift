//
//  ListVM.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit

class ListVM {
    private var apiClient:NetworkManager!
    private var page = 1
    private var pageCount = 20
    var data:[TVSeriesListData] = []
    var alertMessage:String? {
        didSet {
            if let alertMessage = self.alertMessage {
                self.showAlertClosure?(alertMessage)
            }
        }
    }
    var needRefresh:Bool = false {
        didSet {
            if self.needRefresh {
                self.showRefresh?()
            }
        }
    }
    
    var updateScreenStatus: (() -> ())?
    var showRefresh: (() -> ())?
    var showAlertClosure: ((String) -> ())?
    
    init(_ network:NetworkManager) {
        apiClient = network
    }
    
    func setData(_ m:ListResponse?) {
        if let m = m, let results = m.results {
            page = m.page ?? 1
            for result in results {
                let item = TVSeriesListData()
                item.id = result.id ?? 0
                item.title = result.name ?? ""
                item.rating = "rating".localize + "\(result.vote_average)"
                item.imagePath = result.poster_path != nil ? Constants.urls.imageBaseURL + Constants.imageSizes.w400 + result.poster_path! : Constants.urls.dummyImage
                data.append(item)
            }
        }
    }
    
    //increase page count for next page
    func increasePageInd() {
        page += 1
    }
    
    //check first page list if changed
    func checkListIfChanged(_ m:ListResponse?) {
        if let m = m, let results = m.results {
            for i in 0..<results.count {
                if i<results.count, i<data.count {
                    let new = results[i]
                    let old = data[i]
                    if new.id != old.id {
                        self.needRefresh = true
                        break
                    }
                }
            }
        }
    }
    
    //clear all data
    func clearData() {
        needRefresh = false
        page = 1
        data.removeAll()
    }
    
    //check item index to request for next page
    func isGetNextPage(_ i:Int) -> Bool {
        return i == ((pageCount * page) - 4) ? true:false
    }
}

//MARK: TableView
extension ListVM {
    func getTableRowCount() -> Int {
        return data.count
    }
    
    func getTableRowData(_ row:Int) -> TVSeriesListData {
        return data[row]
    }
}

//MARK: ServiceCall
extension ListVM {
    //get data from api
    func getData(_ isCheck:Bool = false) {
        let p = isCheck ? 1:page
        apiClient.getList(p, completionSuccess: { (result) in
            self.alertMessage = nil
            if isCheck { //if check request just check data do not add list
                self.checkListIfChanged(result)
            } else {
                self.setData(result)
                self.updateScreenStatus?()
            }
        }) { (error) in
            self.alertMessage = error.localizedDescription
        }
    }
}


//MARK: Data Classes
class TVSeriesListData {
    var id = 0
    var title = ""
    var rating = ""
    var imagePath = ""
}
