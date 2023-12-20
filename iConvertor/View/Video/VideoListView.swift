//
//  VideoListView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct VideoListView: View {
    @StateObject private var stateObject = VideoViewIntent()
    @State private var isRecordingViewPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if stateObject.videos.isEmpty {
                    Spacer()
                    Text("No video available")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(stateObject.videos, id: \.self) { videoURL in
                            NavigationLink {
                                VideoDetailView(videoURL: videoURL)
                            } label: {
                                Text(videoURL.lastPathComponent)
                            }
                        }
                        .onDelete(perform: stateObject.deleteVideo)
                    }
                }
            }
            .navigationTitle("Video")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        isRecordingViewPresented = true
                    }) {
                        Label("Record", systemImage: "video.fill")
                    }
                    .sheet(isPresented: $isRecordingViewPresented) {
                        VideoRecordView(observedObject: stateObject)
                    }
                }
            }
            .onAppear {
                stateObject.fetchVideos()
            }
        }
    }
}

#Preview {
    VideoListView()
}
