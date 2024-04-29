//
//  HomeWorker.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class HomeWorker {
    
    
    func fetchAdsAndCategories() -> AnyPublisher<([Ad],[Category]),Error> {
        // Création des URL pour les deux requêtes
        guard let url1 = URL(string: URLs.adsListUrl()) else {
            return Fail<([Ad],[Category]), Error>(error: LBCError.incorrectUrl).eraseToAnyPublisher()
        }
        guard let url2 = URL(string: URLs.categoriesListUrl()) else {
            return Fail<([Ad],[Category]), Error>(error: LBCError.incorrectUrl).eraseToAnyPublisher()
        }
        
        // Création des éditeurs (publishers) pour les deux requêtes
        let publisher1 = URLSession.shared.dataTaskPublisher(for: url1)
            .map { $0.data }
            .decode(type: [Ad].self, decoder: LBCJSONDecoder())
            .mapError { $0 as Error }
        
        let publisher2 = URLSession.shared.dataTaskPublisher(for: url2)
            .map { $0.data }
            .decode(type: [Category].self, decoder: LBCJSONDecoder())
            .mapError { $0 as Error }
        
        // Utilisation de l'opérateur zip pour effectuer les deux requêtes en parallèle
        let combinedPublisher = Publishers.Zip(publisher1, publisher2)
            .eraseToAnyPublisher()
        
        // Abonnement pour recevoir les résultats combinés
        return combinedPublisher
    }
}
