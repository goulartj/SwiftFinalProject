//
//  MoodSelectionView.swift
//  FinalProject
//
//  Created by John Goulart on 4/27/23.
//


import SwiftUI

struct MoodSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    let backgroundImage = Image("background")
    @State private var happySheetIsPresented = false
    @State private var funnySheetIsPresented = false
    @State private var smartSheetIsPresented = false
    @State private var sadSheetIsPresented = false
    var body: some View {
        NavigationStack{
            VStack {
                Text("Select a Mood")
                    .font(.system(size:50))
                    .italic()
                    .underline()
                    .foregroundColor(.accentColor)
                    .frame(height:100)
                    .fontWeight(.black)
                    .padding(.top)
                Group {
                    Button("😃") {
                        happySheetIsPresented.toggle()
                    }
                    Button("🤣") {
                        funnySheetIsPresented.toggle()
                    }
                    Button("🧐") {
                        smartSheetIsPresented.toggle()
                    }
                    Button("😢") {
                        sadSheetIsPresented.toggle()
                    }
                }
                .font(.system(size:65))
                .font(.title2)
                .padding()
            }
            .background(backgroundImage.opacity(0.9))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
            .fullScreenCover(isPresented: $happySheetIsPresented) {
                HappyVideoView()
            }
            .fullScreenCover(isPresented: $funnySheetIsPresented) {
                FunnyVideoView()
            }
            .fullScreenCover(isPresented: $smartSheetIsPresented) {
                SmartVideoView()
            }
            .fullScreenCover(isPresented: $sadSheetIsPresented) {
                SadVideoView()
            }
        }
    }
}

struct MoodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MoodSelectionView()
        }
    }
}
