//
//  DetailVMTests.swift
//  ProCS2Tests
//
//  Created by Serhat Akkurt on 20.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import XCTest

class DetailVMTests: ProCS2Tests {
    var vm: DetailVM!
    var tvId = 1399
    
    func testGetDetailFail() {
        //given
        let network = NetworkManager(providerFail)
        let viewModel = DetailVM(network, id: tvId)
        
        //when
        viewModel.getData()
        
        //then
        let predicate = NSPredicate(block: { m, _ in
            guard let vm = m as? DetailVM else { return false }
            return vm.alertMessage != nil
        })
        _ = self.expectation(for: predicate, evaluatedWith: viewModel, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func testGetDetail() {
        //given
        let network = NetworkManager(providerSuccess)
        let viewModel = DetailVM(network, id: tvId)
        
        //when
        viewModel.getData()
        
        //then
        let predicate = NSPredicate(block: { m, _ in
            guard let vm = m as? DetailVM else { return false }
            return vm.data.title == "Game of Thrones"
        })
        _ = self.expectation(for: predicate, evaluatedWith: viewModel, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func testActionLike() {
        //given
        let network = NetworkManager(providerFail)
        let viewModel = DetailVM(network, id: tvId)
        
        //when
        viewModel.getData()
        viewModel.actionLike()
        
        //then
        XCTAssertTrue(viewModel.data.isLiked)
    }
}
