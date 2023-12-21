//
//  PermissionManager.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/21/23.
//

import AVFoundation
import Photos

class PermissionManager: ObservableObject {
    @Published var isMicrophonePermissionGranted = false
    @Published var isCameraPermissionGranted = false
    @Published var isPhotoLibraryPermissionGranted = false
    
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
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("Camera permission is granted.")
            self.isCameraPermissionGranted = true
        case .denied, .restricted:
            print("Camera permission is denied/restricted.")
            isCameraPermissionGranted = false
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Camera permission granted.")
                        self!.isCameraPermissionGranted = true
                    } else {
                        print("Camera permission denied.")
                        self?.isCameraPermissionGranted = false
                    }
                }
            }
        @unknown default:
            fatalError("Unhandled case.")
        }
    }
    
    func checkPhotoLibraryAccess() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            print("Photo library permission is granted.")
            self.isPhotoLibraryPermissionGranted = true
        case .limited:
            print("Photo library permission is limited.")
            self.isPhotoLibraryPermissionGranted = true
        case .denied, .restricted:
            print("Photo library permission is denied/restricted.")
            isPhotoLibraryPermissionGranted = false
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        print("Photo library permission granted.")
                        self?.isPhotoLibraryPermissionGranted = true
                    } else {
                        print("Photo library permission denied.")
                        self?.isPhotoLibraryPermissionGranted = false
                    }
                }
            }
        @unknown default:
            fatalError("Unhandled case.")
        }
    }
}
