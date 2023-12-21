//
//  FileManager.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import Foundation

class FileManagerClass: NSObject {
    
    static let sharedInstance: FileManagerClass = {
        let instance = FileManagerClass()
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    private func documentsDirectoryURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func saveDataToFileManager(folderName: String, data: Data, fileExtension: String) -> String? {
        let filename = UUID().uuidString + fileExtension
        let relativeURL = "\(folderName)/\(filename)"
        
        do {
            // Get the documents directory URL
            let documentsDirectory = documentsDirectoryURL()
            let fileURL = documentsDirectory.appendingPathComponent(relativeURL)
            
            // Create the necessary directory structure if it doesn't exist
            try FileManager.default.createDirectory(at: fileURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            
            // Write the data to the file at the specified URL
            try data.write(to: fileURL)
            
            return fileURL.path
        } catch {
            // Print an error message if any issues occur during the saving process
            print("Error saving data:", error.localizedDescription)
            return ""
        }
    }
    
    private func loadFilesFromFolder(folderName: String) -> [URL]? {
        do {
            // Get the documents directory URL
            let documentsDirectory = documentsDirectoryURL()
            // Get contents of the specified directory
            let folderURL = documentsDirectory.appendingPathComponent(folderName)
            
            // Check if the folder exists, and create it if it doesn't
            if !FileManager.default.fileExists(atPath: folderURL.path) {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            }
            
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            
            return fileURLs
        } catch {
            print("Error getting file URLs:", error.localizedDescription)
            return nil
        }
    }
    
    
    private func deleteFile(at fileURL: URL) {
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("File deleted from file manager:", fileURL)
        } catch {
            print("Error deleting file from file manager:", error.localizedDescription)
        }
    }
    
    // Audio methods
    func saveAudioToFileManager() -> String? {
        let folderName = FileConstants.audioFolderName
        let fileExtension = FileConstants.audioFileExtension
        return saveDataToFileManager(folderName: folderName, data: Data(), fileExtension: fileExtension)
    }
    
    func loadAudioDataFromFileManager() -> [URL]? {
        return loadFilesFromFolder(folderName: FileConstants.audioFolderName)
    }
    
    func deleteAudioFromFileManager(audioURL: URL) {
        deleteFile(at: audioURL)
    }
    
    // Image methods
    func saveImageToFileManager(_ imageData: Data) {
        let folderName = FileConstants.imageFolderName
        let fileExtension = FileConstants.imageFileExtension
        _ = saveDataToFileManager(folderName: folderName, data: imageData, fileExtension: fileExtension)
    }
    
    func loadImageDataFromFileManager() -> [URL]? {
        return loadFilesFromFolder(folderName: FileConstants.imageFolderName)
    }
    
    func deleteImageFromFileManager(imageURL: URL) {
        deleteFile(at: imageURL)
    }
    
    // Video methods
    func saveVideoToFileManager(_ videoData: Data) {
        let folderName = FileConstants.videoFolderName
        let fileExtension = FileConstants.videoFileExtension
        _ = saveDataToFileManager(folderName: folderName, data: videoData, fileExtension: fileExtension)
    }
    
    func loadVideoDataFromFileManager() -> [URL]? {
        return loadFilesFromFolder(folderName: FileConstants.videoFolderName)
    }
    
    func deleteVideoFromFileManager(videoURL: URL) {
        deleteFile(at: videoURL)
    }
}
