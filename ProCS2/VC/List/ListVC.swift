//
//  ListVC.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit
import Moya
import SwiftyTimer
import Kingfisher

class ListVC: UIViewController {
    
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var btnRefresh: UIButton!

    private let cell = String(describing: ListCollCell.self)
    private let cellSize = CGSize(width: UIScreen.main.bounds.size.width/2, height: 215)
    private lazy var viewModel: ListVM = {
        let provider = MoyaProvider<MyService>()
        let network = NetworkManager(provider)
        return .init(network)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collView.reloadData()
    }
    
    func initUI() {
        btnRefresh.layer.cornerRadius = 5
        collView.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)
    }
    
    func initVM() {
        getDataWithLoading()
        startTimer()
        
        viewModel.updateScreenStatus = { [weak self] () in
            if let self = self {
                self.loading.stopAnimating()
                self.collView.reloadData()
            }
        }
        
        viewModel.showRefresh = { [weak self] () in
            if let self = self {
                self.btnRefresh.isHidden = false
            }
        }
        
        viewModel.showAlertClosure = { [weak self] (msg) in
            if let self = self {
                UIAlertController.showAlert("err".localize, msg: msg, firstButtonText: "tryagain".localize, target: nil, completionFirstButton: {
                    self.getDataWithLoading()
                })
            }
        }
    }
    
    //show loading and get data
    func getDataWithLoading(_ isCheck:Bool = false) {
        if !isCheck {
            loading.startAnimating()
        }
        viewModel.getData(isCheck)
    }
    
    //request first page every minute
    func startTimer() {
        Timer.every(Constants.duration.reloadDuration) { (timer: Timer) in
            self.getDataWithLoading(true)
        }
    }
    
    //refresh button action, clear all data and get new list
    @IBAction func btnAction(_ sender:AnyObject) {
        collView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        btnRefresh.isHidden = true
        viewModel.clearData()
        collView.reloadData()
        getDataWithLoading()
    }
    
    //go next screen
    func goDetailScreen(_ id:Int, img:UIImage?) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC {
            vc.tvId = id
            vc.img = img
            self.present(vc, animated: true)
        }
    }
}

extension ListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTableRowCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as? ListCollCell {
            cell.setCellData(viewModel.getTableRowData(indexPath.row))
            if viewModel.isGetNextPage(indexPath.row) {
                viewModel.increasePageInd()
                getDataWithLoading()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getTableRowData(indexPath.row)
        KingfisherManager.shared.retrieveImage(with: URL(string: item.imagePath)!) { result in
            if let image = try? result.get().image {
                self.goDetailScreen(item.id, img:image)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}
