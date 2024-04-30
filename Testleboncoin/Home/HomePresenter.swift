//
//  HomePresenter.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentAds(responseAds: [Home.Ads.ResponseAd], responseCategories: [Home.Ads.ResponseCategory])
    func presentError()
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    // MARK: Do something

    func presentAds(responseAds: [Home.Ads.ResponseAd], responseCategories: [Home.Ads.ResponseCategory]) {
        
        let sortedByDateResponseAds = responseAds.sorted { responseAd1, responseAd2 in
            (responseAd1.creationDate ?? Date()) > (responseAd2.creationDate ?? Date())
        }

        let sortedByDateAndUrgentPropertyResponseAds = sortedByDateResponseAds.sorted { responseAd1, responseAd2 in
            (responseAd1.isUrgent ?? false) && !(responseAd2.isUrgent ?? false)
        }
        
        let viewModelAds = sortedByDateAndUrgentPropertyResponseAds.compactMap { responseAd in
            return Home.Ads.ViewModelAd(id: responseAd.id,
                                 categoryName: getCategoryName(responseAd: responseAd, responseCategories: responseCategories),
                                 title: responseAd.title,
                                 price: "\(responseAd.price ?? 0)€",
                                 imagesUrlSmall: responseAd.imagesUrlSmall,
                                 imagesUrlThumb: responseAd.imagesUrlThumb,
                                 creationDate: responseAd.creationDate,
                                 isUrgent: responseAd.isUrgent)
        }
        
        viewController?.displayAds(viewModelAds: viewModelAds,
                                   viewModelCategories: [])
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    private func getCategoryName(responseAd: Home.Ads.ResponseAd, responseCategories: [Home.Ads.ResponseCategory]) -> String {
        return responseCategories.filter{ $0.id == responseAd.categoryId }.first?.name ?? ""
    }
}
