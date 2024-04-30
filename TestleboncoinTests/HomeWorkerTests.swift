//
//  HomeWorkerTests.swift
//  TestleboncoinTests
//
//  Created by Yasin Akinci on 30/04/2024.
//

import XCTest
import Combine
@testable import Testleboncoin

class HomeWorkerTests: XCTestCase {

    var worker: HomeWorker!
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupHomeWorker()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Test setup

    func setupHomeWorker() {
        worker = HomeWorker()
    }
    
    func testFetchAdsAndCategories() {
        let e = expectation(description: "fetchAdsAndCategories")
        
        worker.fetchAdsAndCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                e.fulfill()
            }, receiveValue: { ads, categories in
//                e.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5.0, handler: nil)

    }
    
    func testListingModel() {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "listing", ofType: "json") else {
            fatalError("listing.json not found") }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response = try LBCJSONDecoder().decode([Ad].self, from: data)

            XCTAssertNotNil(response, "[Ad] found")
            XCTAssertEqual(response.first?.id, 1461267313)
            XCTAssertEqual(response.last?.category_id, 5)
        } catch {
            fatalError("listing.json file format not correct")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
