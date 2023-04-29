//
//  HappyDetailView.swift
//  FinalProject
//
//  Created by John Goulart on 4/29/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct HappyDetailView: View {
    @EnvironmentObject var happyVM: HappyVideoViewModel
    @State var happyVideo: HappyVideo
    @State private var title = ""
    @State private var url = ""

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Group {
                TextField("Title", text: $happyVideo.title)
                    .font(.title2)
                TextField("URL", text: $happyVideo.url)
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
                    let success = await happyVM.saveHappyVideo(happyVideo: happyVideo)
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
                        let delete = await happyVM.deleteHappyVideo(happyVideo: happyVideo)
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

struct HappyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HappyDetailView(happyVideo: HappyVideo())
                .environmentObject(HappyVideoViewModel())
        }
    }
}
