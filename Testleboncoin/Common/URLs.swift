//
//  URLs.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//
/*
 Documentation de l’API : https://raw.githubusercontent.com/leboncoin/paperclip/master/swagger.yaml

 API 1 : pour récupérer la liste d'annonces :
 https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json
 
 API 2 : liste de catégories :
 https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json
 */


import Foundation

struct URLs {
    
    private static let HOST_API = "https://raw.githubusercontent.com"
    private static let PATH = "/leboncoin/paperclip/master"
    private static let ADS_SERVICE = "/listing.json"
    private static let CATEGORIES_SERVICE = "/categories.json"
    
    static func adsListUrl() -> String {
        return HOST_API+PATH+ADS_SERVICE
    }

    static func categoriesListUrl() -> String {
        return HOST_API+PATH+CATEGORIES_SERVICE
    }
    
}
