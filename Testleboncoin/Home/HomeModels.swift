//
//  HomeModels.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Home
{
    // MARK: Use cases
    
    enum Ads {
        struct Request {
        }
        
        struct ResponseAd {
            let id: Int?
            let categoryId: Int?
            let title: String?
            let price: Int?
            let imagesUrlSmall: URL?
            let imagesUrlThumb: URL?
            let creationDate: Date?
            let isUrgent: Bool?
        }
        
        struct ResponseCategory {
            let id: Int?
            let name: String?
        }
        
        struct ViewModelAd: Hashable {
            let id: Int?
            let categoryName: String?
            let title: String?
            let price: String?
            let imagesUrlSmall: URL?
            let imagesUrlThumb: URL?
            let creationDate: Date?
            let isUrgent: Bool?
        }
        
        
        struct ViewModelCategory {
            let id: Int?
            let name: String?
        }
    }
    
}
