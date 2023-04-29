//
//  FunnyVideoView.swift
//  FinalProject
//
//  Created by John Goulart on 4/29/23.
//


import SwiftUI

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct FunnyVideoView: View {
    @FirestoreQuery(collectionPath: "funnyVideos") var funnyVideos: [FunnyVideo]
    @Environment(\.dismiss) private var dismiss
    @State private var temp = ""
    let backgroundImage = Image("background")
    var body: some View {
        NavigationStack {
            VStack {
                VideoView(videoID: funnyVideos.randomElement()?.url ?? "")
                    .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.5)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .onAppear {
                        for post in funnyVideos {
                            print(post.title)
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button ("Back") {
                        dismiss()
                    }
                }
            }
            .background(backgroundImage)
        }
    }
}

struct FunnyVideoView_Previews: PreviewProvider {
    static var previews: some View {
        FunnyVideoView()
    }
}
