//
//  HappyVideoViewModel.swift
//  FinalProject
//
//  Created by John Goulart on 4/29/23.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

class HappyVideoViewModel: ObservableObject {
    @Published var happyVideo = HappyVideo()
    
    func saveHappyVideo(happyVideo: HappyVideo) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = happyVideo.id {
            do {
                try await db.collection("happyVideos").document(id).setData(happyVideo.dictionary)
                print("Data updated successfully!")
                return true
            } catch {
                print("ERROR: Could not update data in 'happyVideos' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                try await db.collection("happyVideos").addDocument(data: happyVideo.dictionary)
                print("Data added successfully!")
                return true
            } catch {
                print("ERROR: Could not create a new post in 'happyVideos' \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func deleteHappyVideo(happyVideo: HappyVideo) async -> Bool {
        let db = Firestore.firestore()
        guard let happyVideoID = happyVideo.id else {
            print("ERROR: happyVideo.id = \(happyVideo.id ?? "")")
            return false
        }
        
        do {
            let _ = try await db.collection("happyVideos").document(happyVideoID).delete()
            print("Document successfully deleted!")
            return true
        } catch {
            print("ERROR: removing document \(error.localizedDescription)")
            return false
        }
    }
}
