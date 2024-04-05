//
//  TranslationViewModel.swift
//  TranslateMe
//
//  Created by Mina on 4/3/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum Languages: String, CaseIterable, Identifiable {
    
    
    case English = "en"
    case Italian = "it"
    case French = "fr"
    case German = "de"
    case Mandarin = "zh"
    case Arabic = "ar"
    case Russian = "ru"
    case Portuguese = "pt"
    case Japanese = "ja"
    case Hindi = "hi"
    case Turkish = "tr"
    case Greek = "el"
    case Romanian = "ro"
    
    var name: String {
        switch self {
        case .English:
            "English"
        case .Italian:
            "Italian"
        case .French:
            "French"
        case .German:
            "German"
        case .Mandarin:
            "Mandarin"
        case .Arabic:
            "Arabic"
        case .Russian:
            "Russian"
        case .Portuguese:
            "Portuguese"
        case .Japanese:
            "Japanese"
        case .Hindi:
            "Hindi"
        case .Turkish:
            "Turkish"
        case .Greek:
            "Greek"
        case .Romanian:
            "Romanian"
        }
    }
    var id: String {
        return self.rawValue
    }
    
}

@Observable
class TranslationViewModel {
    
    var inputLanguage = ""
    var outputLanguage = ""
    var text = ""
    //var languagePair = "en|it"
    var history: [History] = []
    
    
    func translatedText() async throws -> String? {
        guard let url = URL(string: "https://api.mymemory.translated.net/get?q=\(text)&langpair=\(inputLanguage)|\(outputLanguage)") else {return nil}
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ResponseData.self, from: data)
        guard result.matches?.count ?? 0 > 0 else {return "No Matches"}
        if let translatedMatchText = result.matches?[0].translation {
            saveTranslation(translatedText: translatedMatchText)
            return translatedMatchText
        } else if let translatedMatchText = result.matches?[0].translation {
            saveTranslation(translatedText: translatedMatchText)
            return translatedMatchText
        } else {
            return "No Translation"
        }
    }
    
    private func saveTranslation(translatedText: String) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("Users").document(userID).collection("History").addDocument(data: ["text" : text, "translatedText" : translatedText, "date" : Date()])
    }
    
    func fetchHistory() async throws {
        
        var tempHistory: [History] = []
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("Users").document(userID).collection("History").getDocuments()
        snapshot.documents.forEach { document in
            let historyItem =  History(id: document.documentID, dictionary: document.data())
            tempHistory.append(historyItem)
        }
        history = tempHistory
    }
    
    func deleteHistory() async throws {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let reference = Firestore.firestore().collection("Users").document(userID).collection("History")
        let documents = try await reference.getDocuments()
        for document in documents.documents {
            try await document.reference.delete()
        }
        history = []
    }
    
    
    
}
