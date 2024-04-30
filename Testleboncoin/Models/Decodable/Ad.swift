//
//  Ad.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//

import Foundation

struct Ad: Decodable {
    let id: Int?
    let category_id: Int?
    let title: String?
    let price: Int?
    let images_url: ImagesUrl?
    let creation_date: Date?
    let is_urgent: Bool?
    
    //  I add this function to allow dependency injection for the test
    init(
        id: Int?,
        category_id: Int?,
        title: String?,
        price: Int?,
        images_url: ImagesUrl?,
        creation_date: Date?,
        is_urgent: Bool?
         ) {
        self.id = id
        self.category_id = category_id
        self.title = title
        self.price = price
        self.images_url = images_url
        self.creation_date = creation_date
        self.is_urgent = is_urgent
    }
}
