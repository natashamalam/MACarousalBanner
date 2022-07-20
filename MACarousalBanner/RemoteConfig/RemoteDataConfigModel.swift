//
//  RemoteDataConfigModel.swift
//  MACarousalBanner
//
//  Created by Alam, Mahjabin | ECMPD on R 4/07/19.
//

import Foundation

struct RemoteConfigResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case arrowPattern = "pattern"
    }
    
    let arrowPattern: String?
}
