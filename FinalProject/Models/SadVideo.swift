//
//  SadVideo.swift
//  FinalProject
//
//  Created by John Goulart on 4/29/23.
//


import Foundation
import Firebase
import FirebaseFirestoreSwift

struct SadVideo: Identifiable, Codable {
    @DocumentID var id: String?
    var user = Auth.auth().currentUser?.email ?? ""
    var title = ""
    var url = ""
        
    var dictionary: [String: Any] {
        return["user": user, "title": title, "url": url]
    }
}
