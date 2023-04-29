//
//  ContributerView.swift
//  FinalProject
//
//  Created by John Goulart on 4/27/23.
//


import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ContributerView: View {
    @FirestoreQuery(collectionPath: "posts") var posts: [Post]
    @FirestoreQuery(collectionPath: "happyVideos") var happyVideos: [HappyVideo]
    @FirestoreQuery(collectionPath: "funnyVideos") var funnyVideos: [FunnyVideo]
    @FirestoreQuery(collectionPath: "smartVideos") var smartVideos: [SmartVideo]
    @FirestoreQuery(collectionPath: "sadVideos") var sadVideos: [SadVideo]
    @State private var happySheetIsPresented = false
    @State private var funnySheetIsPresented = false
    @State private var smartSheetIsPresented = false
    @State private var sadSheetIsPresented = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Group {
                Group {
                    HStack {
                        Text("Happy Videos")
                        Spacer()
                        Button("Add"){
                            happySheetIsPresented.toggle()
                        }
                    }
                    .font(.title2)
                    .padding(.horizontal)
                }
                List(happyVideos) { happyVideo in
                    NavigationLink {
                        HappyDetailView(happyVideo: happyVideo)
                    } label: {
                        Text(happyVideo.title)
                            .font(.system(size:15))
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button("Back") {
                            dismiss()
                        }
                    }
                }
                Group {
                    HStack {
                        Text("Funny Videos")
                        Spacer()
                        Button("Add"){
                            funnySheetIsPresented.toggle()
                        }
                    }
                    .font(.title2)
                    .padding(.horizontal)
                }
                List(funnyVideos) { funnyVideo in
                    NavigationLink {
                        FunnyDetailView(funnyVideo: funnyVideo)
                    } label: {
                        Text(funnyVideo.title)
                            .font(.system(size:15))
                    }
                }
                Group {
                    HStack {
                        Text("Smart Videos")
                        Spacer()
                        Button("Add"){
                            smartSheetIsPresented.toggle()
                        }
                    }
                    .font(.title2)
                    .padding(.horizontal)
                }
                List(smartVideos) { smartVideo in
                    NavigationLink {
                        SmartDetailView(smartVideo: smartVideo)
                    } label: {
                        Text(smartVideo.title)
                            .font(.system(size:15))
                    }
                }
                Group {
                    HStack {
                        Text("Sad Videos")
                        Spacer()
                        Button("Add"){
                            sadSheetIsPresented.toggle()
                        }
                    }
                    .padding(.horizontal)
                    .font(.title2)
                }
                List(sadVideos) { sadVideo in
                    NavigationLink {
                        SadDetailView(sadVideo: sadVideo)
                    } label: {
                        Text(sadVideo.title)
                            .font(.system(size:15))
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("All Videos")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $happySheetIsPresented) {
                NavigationStack {
                    HappyDetailView(happyVideo: HappyVideo())
                }
            }
            .sheet(isPresented: $funnySheetIsPresented) {
                NavigationStack {
                    FunnyDetailView(funnyVideo: FunnyVideo())
                }
            }
            .sheet(isPresented: $smartSheetIsPresented) {
                NavigationStack {
                    SmartDetailView(smartVideo: SmartVideo())
                }
            }
            .sheet(isPresented: $sadSheetIsPresented) {
                NavigationStack {
                    SadDetailView(sadVideo: SadVideo())
                }
            }
        }
    }
}

struct ContributerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContributerView()
        }
    }
}
