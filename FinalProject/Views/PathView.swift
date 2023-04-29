//
//  PathView.swift
//  FinalProject
//
//  Created by John Goulart on 4/27/23.
//

import SwiftUI
import Firebase

struct PathView: View {
    @Environment(\.dismiss) private var dismiss
    let backgroundImage = Image("background")
    @State private var presentContributer = false
    @State private var presentMoodSelection = false
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    Button ("Experience") {
                        presentMoodSelection = true
                    }
                    Button ("Contribute"){
                        presentContributer = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .font(.largeTitle)
                .foregroundColor(Color("SkyColor"))
                .padding()
                .tint(Color("AccentColor"))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            print("Log out successful!")
                            dismiss()
                        } catch {
                            print("Error: Could not sign out!")
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .background(backgroundImage.opacity(0.9))
            .fullScreenCover(isPresented: $presentContributer) {
                ContributerView()
            }
            .fullScreenCover(isPresented: $presentMoodSelection) {
                MoodSelectionView()
            }
        }
    }
}

struct PathView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PathView()
        }
    }
}
