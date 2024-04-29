//
//  LBCJSONDecoder.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//

import Foundation

//  LBC for leboncoin
class LBCJSONDecoder: JSONDecoder {
    
//    let decoder = JSONDecoder()
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ'"
        return dateFormatter
    }()
    
    override init() {
        super.init()
        self.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
}
