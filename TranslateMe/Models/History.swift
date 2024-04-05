//
//  History.swift
//  TranslateMe
//
//  Created by Mina on 4/3/24.
//

import Foundation

struct History: Identifiable {
    
    var id: String?
    var text: String
    var translatedText: String
    var date: Date
    
    init (id: String, dictionary: [String: Any]) {
        self.id = id
        self.text = dictionary["text"] as? String ?? "error"
        self.translatedText = dictionary["translatedText"] as? String ?? "error"
        self.date = dictionary["date"] as? Date ?? Date()
    }
}
