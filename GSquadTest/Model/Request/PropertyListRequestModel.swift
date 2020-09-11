//
//  PropertyListReqModel.swift
//  GSquadTest
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

// MARK: - PropertyListReqModel

struct PropertyListRequestModel: Codable {//request model to pass data to page
    let page, perPage, sortBy, sortType: String
    let distance, pointSearch: String
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case sortBy = "sort_by"
        case sortType = "sort_type"
        case distance
        case pointSearch = "point_search"
    }
}

