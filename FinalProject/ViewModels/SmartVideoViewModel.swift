//
//  SmartVideoViewModel.swift
//  FinalProject
//
//  Created by John Goulart on 4/29/23.
//


import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

class SmartVideoViewModel: ObservableObject {
    @Published var smartVideo = SmartVideo()
    
    func saveSmartVideo(smartVideo: SmartVideo) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = smartVideo.id {
            do {
                try await db.collection("smartVideos").document(id).setData(smartVideo.dictionary)
                print("Data updated successfully!")
                return true
            } catch {
                print("ERROR: Could not update data in 'smartVideos' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                try await db.collection("smartVideos").addDocument(data: smartVideo.dictionary)
                print("Data added successfully!")
                return true
            } catch {
                print("ERROR: Could not create a new post in 'smartVideos' \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func deleteSmartVideo(smartVideo: SmartVideo) async -> Bool {
        let db = Firestore.firestore()
        guard let smartVideoID = smartVideo.id else {
            print("ERROR: smartVideo.id = \(smartVideo.id ?? "")")
            return false
        }
        
        do {
            let _ = try await db.collection("smartVideos").document(smartVideoID).delete()
            print("Document successfully deleted!")
            return true
        } catch {
            print("ERROR: removing document \(error.localizedDescription)")
            return false
        }
    }
}
