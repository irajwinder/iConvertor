//
//  VideoRecordView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct VideoRecordView: View {
    @StateObject private var stateObject = VideoRecorder()
    @State private var isRecording = false
    
    var body: some View {
        VStack {
            Button(action: {
                if isRecording {
                    stateObject.stopRecording()
                } else {
                    stateObject.startRecording()
                }
                isRecording.toggle()
            }) {
                Image(systemName: isRecording ? "stop.circle" : "video.fill")
                    .font(.system(size: 40))
                    .foregroundColor(isRecording ? .red : .green)
            }
        }
        .onAppear {
            stateObject.setupCamera()
        }
    }
}

#Preview {
    VideoRecordView()
}
