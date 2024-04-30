//
//  HomeInteractor.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

protocol HomeBusinessLogic {
    func fetchAdsAndCategories()
}

protocol HomeDataStore {
    
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Do something
    
    func fetchAdsAndCategories() {
        worker?.fetchAdsAndCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self.presenter?.presentError()
                }
            }, receiveValue: { [weak self] responseAd, responseCategory in
                let ads = responseAd.compactMap { ad in
                    Home.Ads.ResponseAd(id: ad.id,
                                       categoryId: ad.category_id,
                                       title: ad.title,
                                       price: ad.price,
                                       imagesUrlSmall: ad.images_url?.small,
                                       imagesUrlThumb: ad.images_url?.thumb,
                                       creationDate: ad.creation_date,
                                       isUrgent: ad.is_urgent)
                }
                
                let categories = responseCategory.compactMap { category in
                    Home.Ads.ResponseCategory(id: category.id,
                                             name: category.name)
                }
                self?.presenter?.presentAds(responseAds: ads,
                                      responseCategories: categories)
                
            })
            .store(in: &cancellables)
    }
}
