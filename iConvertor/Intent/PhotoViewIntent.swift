//
//  PhotoViewIntent.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/17/23.
//

import Foundation

class PhotoViewIntent: ObservableObject {
    @Published var photos: [URL] = []
    @Published var isPhotoLibraryPermissionGranted: Bool = false
    
    func fetchImages() {
        if let imageURLs = fileManagerClassInstance.loadImageDataFromFileManager() {
            self.photos = imageURLs
        }
    }
    
    func deletePhoto(offsets: IndexSet) {
        // Get the selected photo file URL from the index
        let selectedImageURL = photos[offsets.first!]
        // Delete the photo file using FileManager
        fileManagerClassInstance.deleteImageFromFileManager(imageURL: selectedImageURL)
        // Update the photos array to reflect the changes
        photos.remove(atOffsets: offsets)
    }
}
