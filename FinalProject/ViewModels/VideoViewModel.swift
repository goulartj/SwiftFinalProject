//
//  VideoViewModel.swift
//  FinalProject
//
//  Created by John Goulart on 4/28/23.
//

import Foundation
import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: videoID) else {
            return
        }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}
