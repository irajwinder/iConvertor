//
//  VideoListView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct VideoListView: View {
    @State private var videos = [1, 2, 3, 4]
    @State private var isRecordingViewPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(videos.indices, id: \.self) { video in
                    NavigationLink {
                        VideoDetailView()
                    } label: {
                        Text("Video \(videos[video])")
                    }
                }
                .onDelete(perform: deleteVideo)
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
                        VideoRecordView()
                    }
                }
            }
        }
    }
    
    func deleteVideo(offsets: IndexSet) {
        
    }
}

#Preview {
    VideoListView()
}
