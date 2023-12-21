//
//  AudioDetailView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct AudioDetailView: View {
    var audioURL: URL
    
    var body: some View {
        VStack {
            Button(action: {
                MediaManager.playMedia(mediaURL: audioURL)
            }) {
                Label("Play Audio", systemImage: "play.circle")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .navigationTitle("Audio Detail")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            MediaManager.shareViaOtherApps(fileURL: audioURL)
                        }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        
                        Button(action: {
                            MediaManager.shareViaEmail(fileURL: audioURL, mimeType: "audio/wav", fileName: "audio.wav")
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
    AudioDetailView(audioURL: URL(string: "")!)
}
