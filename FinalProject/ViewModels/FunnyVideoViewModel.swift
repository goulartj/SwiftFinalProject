//
//  FunnyVideoViewModel.swift
//  FinalProject
//
//  Created by John Goulart on 4/29/23.
//


import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

class FunnyVideoViewModel: ObservableObject {
    @Published var funnyVideo = FunnyVideo()
    
    func saveFunnyVideo(funnyVideo: FunnyVideo) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = funnyVideo.id {
            do {
                try await db.collection("funnyVideos").document(id).setData(funnyVideo.dictionary)
                print("Data updated successfully!")
                return true
            } catch {
                print("ERROR: Could not update data in 'funnyVideos' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                try await db.collection("funnyVideos").addDocument(data: funnyVideo.dictionary)
                print("Data added successfully!")
                return true
            } catch {
                print("ERROR: Could not create a new post in 'funnyVideos' \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func deleteFunnyVideo(funnyVideo: FunnyVideo) async -> Bool {
        let db = Firestore.firestore()
        guard let funnyVideoID = funnyVideo.id else {
            print("ERROR: funnyVideo.id = \(funnyVideo.id ?? "")")
            return false
        }
        
        do {
            let _ = try await db.collection("funnyVideos").document(funnyVideoID).delete()
            print("Document successfully deleted!")
            return true
        } catch {
            print("ERROR: removing document \(error.localizedDescription)")
            return false
        }
    }
}
