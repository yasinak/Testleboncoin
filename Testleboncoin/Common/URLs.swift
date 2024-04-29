//
//  URLs.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//
/*
 Documentation de l’API : https://raw.githubusercontent.com/leboncoin/paperclip/master/swagger.yaml

 API 1 : API pour récupérer la liste d'annonces :
 https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json
 */


import Foundation

struct URLs {
    
    private static let HOST_API = "https://raw.githubusercontent.com"
    private static let PATH = "/leboncoin/paperclip/master"
    private static let LISTING_SERVICE = "/listing.json"
    
    static func leagueTeamsUrl() -> String {
        return HOST_API+PATH+LISTING_SERVICE
    }
    
}
