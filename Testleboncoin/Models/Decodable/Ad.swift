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
}
