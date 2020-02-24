//
//  DetailVM.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit

class DetailVM {
    private var apiClient:NetworkManager!
    private var tvId:Int = 0
    var data = TVSeriesData()
    var alertMessage:String? {
        didSet {
            if let alertMessage = self.alertMessage {
                self.showAlertClosure?(alertMessage)
            }
        }
    }
    
    var updateScreenStatus: (() -> ())?
    var showAlertClosure: ((String) -> ())?
    
    init(_ network:NetworkManager, id:Int) {
        apiClient = network
        tvId = id
    }
    
    //set object tv show data
    func setData(_ m:DetailResponse?) {
        if let m = m {
            data.id = m.id ?? 0
            data.title = m.name ?? ""
            data.season = "season".localize + "\(m.number_of_seasons)"
            data.episode = "episode".localize + "\(m.number_of_episodes)"
            data.imagePath = m.poster_path != nil ? Constants.urls.imageBaseURL + Constants.imageSizes.w400 + m.poster_path! : Constants.urls.dummyImage
            if let genres = m.genres {
                let arr = genres.map { $0.name ?? "" }
                data.genres = arr.joined(separator: ", ")
            }
            data.isLiked = DBManager.shared.isLiked(data.id)
        }
    }
    
    //like or unlike tv show
    func actionLike() {
        let act = DBManager.shared.likeUnlikeTV(data.id)
        data.isLiked = act
        self.updateScreenStatus?()
    }
}

//MARK: ServiceCall
extension DetailVM {
    //get data from api
    func getData() {
        apiClient.getDetail(tvId, completionSuccess: { (result) in
            self.alertMessage = nil
            self.setData(result)
            self.updateScreenStatus?()
        }) { (error) in
            self.alertMessage = error.localizedDescription
        }
    }
}


//MARK: Data Classes
class TVSeriesData {
    var id = 0
    var title = ""
    var season = ""
    var episode = ""
    var imagePath = ""
    var genres = ""
    var isLiked = false
}
