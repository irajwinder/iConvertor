//
//  AudioListView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct AudioListView: View {
    @StateObject private var stateObject = AudioRecordIntent()
    @State private var isRecording = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if stateObject.audios.isEmpty {
                    Spacer()
                    Text("No recorded audios.")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(stateObject.audios, id: \.self) { audio in
                            NavigationLink(destination: AudioDetailView(audioURL: audio)) {
                                Text("\(audio.lastPathComponent)")
                            }
                        }
                        .onDelete(perform: stateObject.deleteAudio)
                    }
                }
                
                ZStack {
                    VStack {
                        
                    }
                }
            }
            .navigationTitle("Audio")
            .onAppear(perform: {
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                print(paths[0])
                
                stateObject.fetchAudios()
                stateObject.checkMicrophonePermission()
            })
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        if isRecording {
                            stateObject.stopRecording()
                        } else {
                            stateObject.startRecording()
                        }
                        isRecording.toggle()
                    }) {
                        Image(systemName: isRecording ? "stop.circle" : "mic")
                            .font(.system(size: 20))
                            .foregroundColor(isRecording ? .red : .blue)
                    }.disabled(!stateObject.isMicrophonePermissionGranted)
                }
            }
        }
    }
}

#Preview {
    AudioListView()
}
