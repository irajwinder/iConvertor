//
//  VideoViewIntent.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/18/23.
//

import Foundation

class VideoViewIntent: ObservableObject {
    @Published var videos: [URL] = []
    
    func fetchVideos() {
        if let videoURLs = FileManagerClass.sharedInstance.loadVideoDataFromFileManager() {
            self.videos = videoURLs
        }
    }
    
    func deleteVideo(offsets: IndexSet) {
        // Get the selected video file URL from the index
        let selectedVideoURL = videos[offsets.first!]
        // Delete the video file using FileManager
        fileManagerClassInstance.deleteVideoFromFileManager(videoURL: selectedVideoURL)
        // Update the videos array to reflect the changes
        videos.remove(atOffsets: offsets)
    }
}
