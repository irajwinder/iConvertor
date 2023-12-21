//
//  AudioRecordIntent.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import AVFoundation

class AudioRecordIntent: ObservableObject {
    @Published var audios: [URL] = []
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
    
    func startRecording() {
        setupAudioRecorder()
        audioRecorder.record()
    }
    
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
