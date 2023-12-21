//
//  PhotoViewIntent.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/17/23.
//

import Foundation
import Photos
import AVFoundation

class PhotoViewIntent: ObservableObject {
    @Published var photos: [URL] = []
    @Published var isCameraPermissionGranted = false
    @Published var isPhotoLibraryPermissionGranted = false
    
    func fetchImages() {
        if let imageURLs = FileManagerClass.sharedInstance.loadImageDataFromFileManager() {
            self.photos = imageURLs
        }
    }
    
    func deletePhoto(offsets: IndexSet) {
        // Get the selected photo file URL from the index
        let selectedImageURL = photos[offsets.first!]
        // Delete the photo file using FileManager
        FileManagerClass.sharedInstance.deleteImageFromFileManager(imageURL: selectedImageURL)
        // Update the photos array to reflect the changes
        photos.remove(atOffsets: offsets)
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
