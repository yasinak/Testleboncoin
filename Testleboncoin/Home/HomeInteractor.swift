//
//  HomeInteractor.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore {
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: Home.Something.Request) {
        worker = HomeWorker()
        worker?.doSomeWork()

        let response = Home.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
