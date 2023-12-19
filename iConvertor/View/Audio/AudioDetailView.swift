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
                if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                    audioManagerInstance.playAudio(audioUrl: audioURL, viewController: rootViewController)
                }
            }) {
                Label("Play Audio", systemImage: "play.circle")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .navigationTitle("Audio Detail")
            .padding()
        }
    }
}

#Preview {
    AudioDetailView(audioURL: URL(string: "")!)
}
