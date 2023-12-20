//
//  VideoDetailView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct VideoDetailView: View {
    var videoURL: URL
    
    var body: some View {
        VStack {
            Button(action: {
                MediaManager.playMedia(mediaURL: videoURL)
            }) {
                Label("Play Video", systemImage: "play.circle")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .navigationTitle("Video Detail")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        MediaManager.shareViaOtherApps(fileURL: videoURL)
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    VideoDetailView(videoURL: URL(fileURLWithPath: ""))
}
