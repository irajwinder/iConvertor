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
                    Menu {
                        Button(action: {
                            MediaManager.shareViaOtherApps(fileURL: videoURL)
                        }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        
                        Button(action: {
                            MediaManager.shareViaEmail(fileURL: videoURL, mimeType: "video/mp4", fileName: "video.mp4")
                        }) {
                            Label("Share via Email", systemImage: "envelope")
                        }
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
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
