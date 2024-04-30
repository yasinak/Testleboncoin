//
//  HomePresenter.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentAdsAndCategories(responseAds: [Home.Ads.ResponseAd], responseCategories: [Home.Ads.ResponseCategory])
    func presentAds(responseAds: [Home.Ads.ResponseAd], responseCategory: Home.Ads.ResponseCategory?)
    func presentError()
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentAdsAndCategories(responseAds: [Home.Ads.ResponseAd], responseCategories: [Home.Ads.ResponseCategory]) {
        
        let sortedByDateResponseAds = sortAdsByDate(responseAds: responseAds)
        
        let sortedByDateAndUrgentPropertyResponseAds = sortAdsByIfUrgent(responseAds: sortedByDateResponseAds)
        
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
        
        let viewModelCategories = responseCategories.compactMap { category in
            Home.Ads.ViewModelCategory(id: category.id, name: category.name)
        }
        
        viewController?.displayAds(viewModelAds: viewModelAds)
        viewController?.getCategories(viewModelCategories: viewModelCategories)
    }
    
    func presentAds(responseAds: [Home.Ads.ResponseAd], responseCategory: Home.Ads.ResponseCategory?) {
        
        let sortedByDateResponseAds = sortAdsByDate(responseAds: responseAds)
        
        let sortedByDateAndUrgentPropertyResponseAds = sortAdsByIfUrgent(responseAds: sortedByDateResponseAds)
        
        let viewModelAds = sortedByDateAndUrgentPropertyResponseAds.compactMap { responseAd in
            return Home.Ads.ViewModelAd(id: responseAd.id,
                                        categoryName: responseCategory?.name,
                                        title: responseAd.title,
                                        price: "\(responseAd.price ?? 0)€",
                                        imagesUrlSmall: responseAd.imagesUrlSmall,
                                        imagesUrlThumb: responseAd.imagesUrlThumb,
                                        creationDate: responseAd.creationDate,
                                        isUrgent: responseAd.isUrgent)
        }
        
        viewController?.displayAds(viewModelAds: viewModelAds)
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    private func sortAdsByDate(responseAds: [Home.Ads.ResponseAd]) -> [Home.Ads.ResponseAd] {
        return responseAds.sorted { responseAd1, responseAd2 in
            (responseAd1.creationDate ?? Date()) > (responseAd2.creationDate ?? Date())
        }
    }
    
    private func sortAdsByIfUrgent(responseAds: [Home.Ads.ResponseAd]) -> [Home.Ads.ResponseAd] {
         return responseAds.sorted { responseAd1, responseAd2 in
            (responseAd1.isUrgent ?? false) && !(responseAd2.isUrgent ?? false)
        }
    }
    
    private func getCategoryName(responseAd: Home.Ads.ResponseAd, responseCategories: [Home.Ads.ResponseCategory]) -> String {
        return responseCategories.filter{ $0.id == responseAd.categoryId }.first?.name ?? ""
    }
}
