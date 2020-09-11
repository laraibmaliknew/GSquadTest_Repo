//
//  PropertyListResponseModel.swift
//  GSquadTest
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

// MARK: - PropertyListResponseModel
struct PropertyListResponseModel: Codable {
    let adsCount, pageCount, currentPage: Int
    let properties: [Property]

    enum CodingKeys: String, CodingKey {
        case adsCount = "ads_count"
        case pageCount = "page_count"
        case currentPage = "current_page"
        case properties
    }
}

// MARK: - Property
struct Property: Codable {
    let id, mlsID: Int
    let reference, mandate, mandateType, status: String
    let transactionTypeID: Int
    let transactionType, propertyType: String
    let propertyTypeID, publicationDate, lastModificationDate, brokerID: Int
    let agencyID: Int
    let favourite: Bool
    let offerState: Int
    let informations: Informations
    let area: Area
    let financial: Financial
    let broker: Broker
    let address: Address
    let medias: [Media]

    enum CodingKeys: String, CodingKey {
        case id
        case mlsID = "mls_id"
        case reference, mandate
        case mandateType = "mandate_type"
        case status
        case transactionTypeID = "transaction_type_id"
        case transactionType = "transaction_type"
        case propertyType = "property_type"
        case propertyTypeID = "property_type_id"
        case publicationDate = "publication_date"
        case lastModificationDate = "last_modification_date"
        case brokerID = "broker_id"
        case agencyID = "agency_id"
        case favourite
        case offerState = "offer_state"
        case informations, area, financial, broker, address, medias
    }
}

// MARK: - Address
struct Address: Codable {
    let showPinToCityCenter: Bool
    let addressFormatted: String
    let streetNumber: Int
    let streetName, zipcode, locality, sublocality: String
    let latitude, longitude: Double
    let administrativeAreaLevel1: String
    let administrativeAreaLevel2: JSONNull?
    let country: String
    let localityID, sublocalityID, countryID, administrativeAreaLevel1ID: Int

    enum CodingKeys: String, CodingKey {
        case showPinToCityCenter
        case addressFormatted = "address_formatted"
        case streetNumber = "street_number"
        case streetName = "street_name"
        case zipcode, locality, sublocality, latitude, longitude
        case administrativeAreaLevel1 = "administrative_area_level1"
        case administrativeAreaLevel2 = "administrative_area_level2"
        case country
        case localityID = "locality_id"
        case sublocalityID = "sublocality_id"
        case countryID = "country_id"
        case administrativeAreaLevel1ID = "administrative_area_level1_id"
    }
}

// MARK: - Area
struct Area: Codable {
    let rooms, bedrooms : Int
    let unitID: Int
    let unitFormatted: String

    enum CodingKeys: String, CodingKey {
        case rooms, bedrooms
        case unitID = "unit_id"
        case unitFormatted = "unit_formatted"
    }
}

// MARK: - Broker
struct Broker: Codable {
    let id: Int
    let name, firstname, lastname: String
    let friend: JSONNull?
}

// MARK: - Financial
struct Financial: Codable {
    let price: Int
    let priceFormatted: String

    enum CodingKeys: String, CodingKey {
        case price
        case priceFormatted = "price_formatted"
    }
}

// MARK: - Informations
struct Informations: Codable {
    let title: String
}

// MARK: - Media
struct Media: Codable {
    let url: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {//response model to pass data to page
        return true
    }

 
    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
