//
//  Constants.swift
//  GSquadTest
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation


struct K {
    struct ProductionServer {
        
        // Live
        static let baseURL = "https://staging.mls-connect.com/en/api/mobile/v1/" //considering this as base url, we will append the routes 
        static let apiKey = "71avwBG421KL"
        static let apiToken = "04aa8c55-1af9-4eb4-b852-9ee258db0044"
        static let userId = 23051
        static let mlsId = 1
    }
    static let perPageCount = "200"//number of items per page
    struct  HeaderFields {
        static let authentication = "Authorization"
        static let apiKey = "apiKey"
        static let apiToken = "apiToken"
        static let userId = "userId"
        static let mlsId = "mlsId"
        static let contentType = "Content-Type"
        static let acceptType = "Accept"
    }
}


enum ContentType: String {
    case json = "application/json"
}

