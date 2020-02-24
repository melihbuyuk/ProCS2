//
//  DetailVC.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit
import Moya
import Hero

class DetailVC: UIViewController {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var imgTV: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSeasonNumber: UILabel!
    @IBOutlet weak var lblEpisodeNumber: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var btnLike: UIButton!

    var tvId = 0
    var img:UIImage?
    private lazy var viewModel: DetailVM = {
        let provider = MoyaProvider<MyService>()
        let network = NetworkManager(provider)
        return .init(network, id:tvId)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initVM()
    }
    
    func initUI() {
        self.hero.isEnabled = true
        imgTV.heroID = String(tvId)
        if let img = img {
            imgTV.image = img
        }
    }
    
    func initVM() {
        loading.startAnimating()
        viewModel.getData()
        
        viewModel.updateScreenStatus = { [weak self] () in
            if let self = self {
                self.loading.stopAnimating()
                self.setData()
            }
        }
        
        viewModel.showAlertClosure = { [weak self] (msg) in
            if let self = self {
                UIAlertController.showAlert("err".localize, msg: msg, firstButtonText: "tryagain".localize, target: nil, completionFirstButton: {
                    self.viewModel.getData()
                })
            }
        }
    }
    
    //set tv show info
    func setData() {
        btnLike.isSelected = viewModel.data.isLiked
        lblName.text = viewModel.data.title
        lblSeasonNumber.text = String(viewModel.data.season)
        lblEpisodeNumber.text = String(viewModel.data.episode)
        lblGenres.text = viewModel.data.genres
        //imgTV.kf.setImage(with: URL(string: viewModel.data.imagePath))
    }
    
    //fav button action
    @IBAction func btnAction(_ sender:AnyObject) {
        viewModel.actionLike()
    }
    
    //dismiss
    @IBAction func closeAction(_ sender:AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
