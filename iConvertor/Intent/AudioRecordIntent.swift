//
//  AudioRecordIntent.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import AVFoundation

class AudioRecordIntent: ObservableObject {
    @Published var audios: [URL] = []
    @Published var isMicrophonePermissionGranted = false
    
    var audioRecorder: AVAudioRecorder!
    
    //Set up the audio recorder
    func setupAudioRecorder() {
        guard let audioFilename = FileManagerClass.sharedInstance.saveAudioToFileManager() else {
            return
        }
        // Set up audio session
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            // Configure audio session for recording
            try audioSession.setCategory(.playAndRecord, mode: .default)
            
            // Set up audio recorder settings
            let settings = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]
            
            audioRecorder = try AVAudioRecorder(url: URL(fileURLWithPath: audioFilename), settings: settings)
        } catch {
            print("Audio recorder setup error: \(error)")
        }
    }
    
    //check and request microphone permission
    func checkMicrophonePermission() {
        let audioSession = AVAudioSession.sharedInstance()
        
        switch audioSession.recordPermission {
        case .granted:
            print("Microphone permission is granted.")
            self.isMicrophonePermissionGranted = true
        case .denied:
            print("Microphone permission is denied.")
            self.isMicrophonePermissionGranted = false
        case .undetermined:
            audioSession.requestRecordPermission { [weak self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Microphone permission granted.")
                        self!.isMicrophonePermissionGranted = true
                    } else {
                        print("Microphone permission denied.")
                        self?.isMicrophonePermissionGranted = false
                    }
                }
            }
        @unknown default:
            fatalError("Unhandled case.")
        }
    }
    
    // Start recording
    func startRecording() {
        setupAudioRecorder()
        audioRecorder.record()
    }
    
    // Stop recording
    func stopRecording() {
        audioRecorder.stop()
        fetchAudios()
    }
    
    
    func fetchAudios() {
        if let audioURLs = FileManagerClass.sharedInstance.loadAudioDataFromFileManager() {
            self.audios = audioURLs
        }
    }
    
    func deleteAudio(offsets: IndexSet) {
        // Get the selected audio file URL from the index
        let selectedAudioURL = audios[offsets.first!]
        // Delete the audio file using FileManager
        FileManagerClass.sharedInstance.deleteAudioFromFileManager(audioURL: selectedAudioURL)
        // Update the audios array to reflect the changes
        audios.remove(atOffsets: offsets)
    }
}
