//
//  NetworkManager.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

typealias completionFailure = (Swift.Error) -> Void

struct NetworkManager {
    var provider:MoyaProvider<MyService>!
    
    init(_ provider:MoyaProvider<MyService>) {
        self.provider = provider
    }
    
    private func request(_ target: MyService, completionSuccess: @escaping (Response) -> (), completionFailure: @escaping completionFailure) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let resp = try response.filterSuccessfulStatusCodes()
                    completionSuccess(resp)
                } catch let error {
                    completionFailure(error)
                }
            case .failure(let error):
                completionFailure(error)
            }
        }
    }
}

extension NetworkManager { //service requests
    func getList(_ page:Int, completionSuccess: @escaping (ListResponse) -> (), completionFailure: @escaping completionFailure) {
        request(.list(page: page), completionSuccess: { (response) in
            do {
                let m = try response.mapObject(ListResponse.self)
                completionSuccess(m)
            } catch let error {
                completionFailure(error)
            }
        }) { (error) in
            completionFailure(error)
        }
    }
    
    func getDetail(_ id:Int, completionSuccess: @escaping (DetailResponse) -> (), completionFailure: @escaping completionFailure) {
        request(.detail(id: id), completionSuccess: { (response) in
            do {
                let m = try response.mapObject(DetailResponse.self)
                completionSuccess(m)
            } catch let error {
                completionFailure(error)
            }
        }) { (error) in
            completionFailure(error)
        }
    }
}
