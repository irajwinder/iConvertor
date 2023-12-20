//
//  VideoRecordView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct VideoRecordView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var observedObject: VideoViewIntent
    
    @State private var recordedVideoURL: URL?
    @State private var showCameraPicker = false
    @State private var showLibraryPicker = false
    
    var body: some View {
        VStack {
            if let videoURL = recordedVideoURL {
                // Display the recorded video
                AVPlayerController(url: videoURL)
                    .frame(height: 300)
                
                Button("Save Video") {
                    if let videoData = try? Data(contentsOf: videoURL) {
                        // Handle saving the recorded video
                        FileManagerClass.sharedInstance.saveVideoToFileManager(videoData)
                        observedObject.fetchVideos()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Error reading video data.")
                    }
                }
            } else {
                VStack(spacing: 30) {
                    Button("Record Video") {
                        showCameraPicker.toggle()
                    }
                    
                    Button("Choose from Library") {
                        showLibraryPicker.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $showCameraPicker) {
            VideoPicker(pickedVideoURL: $recordedVideoURL, sourceType: .camera)
        }
        .sheet(isPresented: $showLibraryPicker) {
            VideoPicker(pickedVideoURL: $recordedVideoURL, sourceType: .photoLibrary)
        }
    }
}

#Preview {
    VideoRecordView(observedObject: VideoViewIntent())
}
