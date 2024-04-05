//
//  TranslatedText.swift
//  TranslateMe
//
//  Created by Mina on 4/3/24.
//

import Foundation
    
    // MARK: - ResponseData
struct ResponseData: Decodable {
        let matches: [Match]?
    }

    // MARK: - Match
struct Match: Decodable {
        let translation: String
    }

