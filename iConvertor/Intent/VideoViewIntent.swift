//
//  VideoViewIntent.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/18/23.
//

import AVFoundation
import SwiftUI
import Photos

class VideoRecorder: NSObject, ObservableObject {
    
    var captureSession: AVCaptureSession?
    var movieOutput: AVCaptureMovieFileOutput?
    
    func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("Failed to get video device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            captureSession = AVCaptureSession()
            
            if captureSession?.canAddInput(input) == true {
                captureSession?.addInput(input)
            } else {
                print("Failed to add input to session")
                return
            }
            
            movieOutput = AVCaptureMovieFileOutput()
            
            if captureSession?.canAddOutput(movieOutput!) == true {
                captureSession?.addOutput(movieOutput!)
            } else {
                print("Failed to add output to session")
                return
            }
            
            DispatchQueue.main.async {
                self.captureSession?.startRunning()
            }
        } catch {
            print("Error setting up camera: \(error.localizedDescription)")
        }
    }
    
    func startRecording() {
        guard let movieOutput = self.movieOutput, let captureSession = self.captureSession else {
            print("Movie output or capture session is nil")
            return
        }
        
        print("Capture session state: \(captureSession.isRunning ? "Running" : "Not running")")
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mov")
        
        movieOutput.startRecording(to: outputURL, recordingDelegate: self)
    }
    
    func stopRecording() {
        guard let movieOutput = self.movieOutput else { return }
        movieOutput.stopRecording()
    }
    
    func saveVideoToFileManager(outputFileURL: URL) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mov")
        
        do {
            // If the file already exists, remove it
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }
            
            // Move the recorded video to the desired location
            try fileManager.moveItem(at: outputFileURL, to: destinationURL)
            
            print("Video saved to: \(destinationURL.absoluteString)")
        } catch {
            print("Error saving video to file manager: \(error.localizedDescription)")
        }
    }
}

extension VideoRecorder: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording video: \(error.localizedDescription)")
        } else {
            // Save the recorded video to FileManager
            saveVideoToFileManager(outputFileURL: outputFileURL)
        }
    }
}
