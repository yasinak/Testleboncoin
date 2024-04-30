//
//  HomeInteractorTests.swift
//  TestleboncoinTests
//
//  Created by Yasin Akinci on 30/04/2024.
//

import XCTest
import Combine
@testable import Testleboncoin

class HomeInteractorTests: XCTestCase {

    // MARK: Subject under test
    var interactor: HomeInteractor!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupHomeInteractor()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func setupHomeInteractor() {
        interactor = HomeInteractor()
    }
    
    class HomePresentationLogicSpy: HomePresentationLogic {
        var presentAdsCalled = false
        var expectPresentAds: XCTestExpectation?
        func presentAds(responseAds: [Home.Ads.ResponseAd], responseCategories: [Home.Ads.ResponseCategory]) {
            presentAdsCalled = true
        }
        
        var presentErrorCalled = false
        func presentError() {
            presentErrorCalled = true
        }
    }

    class HomeWorkerSpy: HomeWorker {
        var presentAdsCalled = false
        
        override func fetchAdsAndCategories() -> AnyPublisher<([Ad],[AdCategory]),Error> {
            presentAdsCalled = true

            let publisher = Just(([Ad(id: 123, category_id: 2, title: "An Ads", price: 100, images_url: nil, creation_date: nil, is_urgent: false)
                                   , Ad(id: 321, category_id: 3, title: "An other Ads", price: 200, images_url: nil, creation_date: nil, is_urgent: false)],
                                  [AdCategory(id: 1, name: "Category 1"), AdCategory(id: 2, name: "Category 2")]))
                .setFailureType(to: Error.self) // Définir le type d'échec à Error
                .eraseToAnyPublisher() // Effacer le type de l'éditeur
            
            return publisher
        }
        
    }
    
    func testSuccessFetchAdsAndCategories() {
        let presenter = HomePresentationLogicSpy()
        presenter.expectPresentAds = XCTestExpectation(description: "expect present Ads")
        
        let worker = HomeWorkerSpy()
        interactor.presenter = presenter
        interactor.worker = worker
        
        interactor.fetchAdsAndCategories()
        
        XCTWaiter(delegate: nil).wait(for: [presenter.expectPresentAds!], timeout: 1)
        XCTAssertTrue(worker.presentAdsCalled, "testFetchAdsAndCategories() worker should be called")
        XCTAssertTrue(presenter.presentAdsCalled, "testFetchAdsAndCategories() should ask the presenter to format the result")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
