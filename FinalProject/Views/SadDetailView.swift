//
//  SadDetailView.swift
//  FinalProject
//
//  Created by John Goulart on 4/29/23.
//


import SwiftUI
import FirebaseFirestoreSwift

struct SadDetailView: View {
    @EnvironmentObject var sadVM: SadVideoViewModel
    @State var sadVideo: SadVideo
    @State private var title = ""
    @State private var url = ""

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Group {
                TextField("Title", text: $sadVideo.title)
                    .font(.title2)
                TextField("URL", text: $sadVideo.url)
                    .font(.title2)
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray.opacity(0.9), lineWidth: 2)
            }
            .padding(.horizontal)
            .padding(.top)
            
            
            Button("Upload") {
                Task {
                    let success = await sadVM.saveSadVideo(sadVideo: sadVideo)
                    if success {
                        dismiss()
                    } else {
                        print("Error saving post!")
                    }
                }
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color("AccentColor"))
            .foregroundColor(Color("SkyColor"))
            .font(.title)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Delete") {
                    Task {
                        let delete = await sadVM.deleteSadVideo(sadVideo: sadVideo)
                        if delete {
                            dismiss()
                        } else {
                            print("Error deleting post!")
                        }
                    }
                    dismiss()
                }
            }
        }
    }
}

struct SadDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SadDetailView(sadVideo: SadVideo())
                .environmentObject(SadVideoViewModel())
        }
    }
}
