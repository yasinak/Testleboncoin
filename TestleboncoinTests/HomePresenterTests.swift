//
//  HomePresenterTests.swift
//  TestleboncoinTests
//
//  Created by Yasin Akinci on 30/04/2024.
//

import XCTest
@testable import Testleboncoin

class HomePresenterTests: XCTestCase {

    // MARK: Subject under test
    var presenter: HomePresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupHomePresenter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Test setup

    func setupHomePresenter() {
        presenter = HomePresenter()
    }
    
    class HomeDisplayLogicSpy: HomeDisplayLogic {
        
        var displayAdsCalled = false
        func displayAds(viewModelAds: [Home.Ads.ViewModelAd]) {
            displayAdsCalled = true
        }
        
        var displayCategoriesCalled = false
        func getCategories(viewModelCategories: [Home.Ads.ViewModelCategory]) {
            displayCategoriesCalled = true
        }
        
        var displayErrorCalled = false
        func displayError() {
            displayErrorCalled = true
        }
    }
    
    func testPresentAds() {
        let viewController = HomeDisplayLogicSpy()
        presenter.viewController = viewController
        presenter.presentAds(responseAds: [], responseCategory: Home.Ads.ResponseCategory(id: 1, name: "Véhicule"))
        XCTAssertTrue(viewController.displayAdsCalled, "presentAds(:) should ask the view controller to display the result")
        
        presenter.presentError()
        XCTAssertTrue(viewController.displayErrorCalled, "presentError(:) should ask the view controller to display the result")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
