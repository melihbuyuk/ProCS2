//
//  ListVMTests.swift
//  ProCS2Tests
//
//  Created by Serhat Akkurt on 18.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import XCTest
import SwiftyTimer

class ListVMTests: ProCS2Tests {
    var vm: ListVM!
    
    func testGetListFail() {
        //given
        let network = NetworkManager(providerFail)
        let viewModel = ListVM(network)
        
        //when
        viewModel.getData(false)
        
        //then
        let predicate = NSPredicate(block: { m, _ in
            guard let vm = m as? ListVM else { return false }
            return vm.alertMessage != nil
        })
        _ = self.expectation(for: predicate, evaluatedWith: viewModel, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func testGetList() {
        //given
        let network = NetworkManager(providerSuccess)
        let viewModel = ListVM(network)
        
        //when
        viewModel.getData(false)
        
        //then
        let predicate = NSPredicate(block: { m, _ in
            guard let vm = m as? ListVM else { return false }
            return vm.data.count == 3
        })
        _ = self.expectation(for: predicate, evaluatedWith: viewModel, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func testCheckListIfChanged() {
        //given
        let network = NetworkManager(providerSuccess)
        let viewModel = ListVM(network)
        let detail = DetailResponse()
        detail.id = 1
        detail.name = "Test"
        let resp = ListResponse()
        resp.page = 1
        resp.results = [detail]
        
        //when
        viewModel.getData(false)
        
        //then
        let predicate = NSPredicate(block: { m, _ in
            guard let vm = m as? ListVM else { return false }
            vm.checkListIfChanged(resp)
            return vm.needRefresh == true
        })
        _ = self.expectation(for: predicate, evaluatedWith: viewModel, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func testClearData() {
        //given
        let network = NetworkManager(providerSuccess)
        let viewModel = ListVM(network)
        
        //when
        viewModel.getData(false)
        viewModel.clearData()
        
        //then
        XCTAssertEqual(viewModel.data.count, 0)
    }
    
    func testIsGetNextPageTrue() {
        //given
        let network = NetworkManager(providerSuccess)
        let viewModel = ListVM(network)
        
        //when
        let status = viewModel.isGetNextPage(16)
        
        //then
        XCTAssertTrue(status)
    }
    
    func testIsGetNextPageFalse() {
        //given
        let network = NetworkManager(providerSuccess)
        let viewModel = ListVM(network)
        
        //when
        let status = viewModel.isGetNextPage(5)
        
        //then
        XCTAssertFalse(status)
    }
    
    func testGetTableRowCount() {
        //given
        let network = NetworkManager(providerSuccess)
        let viewModel = ListVM(network)
        
        //when
        viewModel.getData(false)
       
        //then
        let predicate = NSPredicate(block: { m, _ in
            guard let vm = m as? ListVM else { return false }
            return vm.getTableRowCount() == 3
        })
        _ = self.expectation(for: predicate, evaluatedWith: viewModel, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func testGetTableRowData() {
        //given
        let network = NetworkManager(providerSuccess)
        let viewModel = ListVM(network)
        
        //when
        viewModel.getData(false)
       
        //then
        let predicate = NSPredicate(block: { m, _ in
            guard let vm = m as? ListVM else { return false }
            var id = 0
            if vm.data.count > 0 {
                let item = vm.getTableRowData(0)
                id = item.id
            }
            return id == 31917
        })
        _ = self.expectation(for: predicate, evaluatedWith: viewModel, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
}
