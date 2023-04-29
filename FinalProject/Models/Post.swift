//
//  Post.swift
//  FinalProject
//
//  Created by John Goulart on 4/28/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var user = Auth.auth().currentUser?.email ?? ""
    var title = ""
    var url = ""
    //var type = ""
    //var mood = ""
        
//    var dictionary: [String: Any] {
//        return["user": user, "title": title, "url": url, "type": type, "mood": mood]
//    }
    var dictionary: [String: Any] {
        return["user": user, "title": title, "url": url]
    }
}
