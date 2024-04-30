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
    func fetchAds(categoryId: Int)
}

protocol HomeDataStore {
    var ads: [Home.Ads.ResponseAd]? { get set }
    var categories: [Home.Ads.ResponseCategory]? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    var ads: [Home.Ads.ResponseAd]?
    var categories: [Home.Ads.ResponseCategory]?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Do something
    
    func fetchAds(categoryId: Int) {
        let responseAds = ads?.filter{ responseAd in
            responseAd.categoryId == categoryId
        } ?? []
        let responseCategory = categories?.filter{ responseCategory in
            responseCategory.id == categoryId
        }.first ?? nil
        self.presenter?.presentAds(responseAds: responseAds, responseCategory: responseCategory)
    }
    
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
            }, receiveValue: { [weak self] responseAds, responseCategories in
                self?.ads = responseAds.compactMap { ad in
                    Home.Ads.ResponseAd(id: ad.id,
                                        categoryId: ad.category_id,
                                        title: ad.title,
                                        price: ad.price,
                                        imagesUrlSmall: ad.images_url?.small,
                                        imagesUrlThumb: ad.images_url?.thumb,
                                        creationDate: ad.creation_date,
                                        isUrgent: ad.is_urgent)
                }
                
                self?.categories = responseCategories.compactMap { category in
                    Home.Ads.ResponseCategory(id: category.id,
                                              name: category.name)
                }
                self?.presenter?.presentAdsAndCategories(responseAds: self?.ads ?? [],
                                                         responseCategories: self?.categories ?? [])
                
            })
            .store(in: &cancellables)
    }
}
