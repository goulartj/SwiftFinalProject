//
//  SadVideoViewModel.swift
//  FinalProject
//
//  Created by John Goulart on 4/29/23.
//


import Foundation

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

class SadVideoViewModel: ObservableObject {
    @Published var sadVideo = SadVideo()
    
    func saveSadVideo(sadVideo: SadVideo) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = sadVideo.id {
            do {
                try await db.collection("sadVideos").document(id).setData(sadVideo.dictionary)
                print("Data updated successfully!")
                return true
            } catch {
                print("ERROR: Could not update data in 'sadVideos' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                try await db.collection("sadVideos").addDocument(data: sadVideo.dictionary)
                print("Data added successfully!")
                return true
            } catch {
                print("ERROR: Could not create a new post in 'sadVideos' \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func deleteSadVideo(sadVideo: SadVideo) async -> Bool {
        let db = Firestore.firestore()
        guard let sadVideoID = sadVideo.id else {
            print("ERROR: sadVideo.id = \(sadVideo.id ?? "")")
            return false
        }
        
        do {
            let _ = try await db.collection("sadVideos").document(sadVideoID).delete()
            print("Document successfully deleted!")
            return true
        } catch {
            print("ERROR: removing document \(error.localizedDescription)")
            return false
        }
    }
}
