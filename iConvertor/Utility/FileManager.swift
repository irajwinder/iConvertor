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
    
    func saveAudioToFileManager() -> String? {
        // folder name and file name
        let folderName = "AudioFiles"
        let audioFilename = UUID().uuidString + ".wav"
        let relativeURL = "\(folderName)/\(audioFilename)"
        
        do {
            // Get the documents directory URL
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(relativeURL)
            
            // Create the necessary directory structure if it doesn't exist
            try FileManager.default.createDirectory(at: fileURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            
            return fileURL.path
        } catch {
            // Print an error message if any issues occur during the audio-saving process
            print("Error saving audio:", error.localizedDescription)
            return nil
        }
    }
    
    func loadAudioDataFromFileManager() -> [URL]? {
        do {
            // Get the documents directory URL
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            // Get contents of the "AudioFiles" directory
            let audioFilesURL = documentsDirectory.appendingPathComponent("AudioFiles")
            let audioFileURLs = try FileManager.default.contentsOfDirectory(at: audioFilesURL, includingPropertiesForKeys: nil)
            
            return audioFileURLs
        } catch {
            print("Error getting audio file URLs:", error.localizedDescription)
            return nil
        }
    }
    
    func deleteAudioFromFileManager(audioURL: URL) {
        do {
            try FileManager.default.removeItem(at: audioURL)
            print("Audio deleted from file manager:", audioURL)
        } catch {
            print("Error deleting audio from file manager:", error.localizedDescription)
        }
    }
    
    func saveImageToFileManager(_ imageData: Data) {
        let folderName = "PhotoLibrary"
        let imageFilename = UUID().uuidString + ".jpg"
        let relativeURL = "\(folderName)/\(imageFilename)"
        
        do {
            // Get the documents directory URL
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(relativeURL)
            
            // Create the necessary directory structure if it doesn't exist
            try FileManager.default.createDirectory(at: fileURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            
            // Write the image data to the file at the specified URL
            try imageData.write(to: fileURL)
        } catch {
            // Print an error message if any issues occur during the image-saving process
            print("Error saving image:", error.localizedDescription)
        }
    }
    
    func loadImageDataFromFileManager() -> [URL]? {
        do {
            // Get the documents directory URL
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            // Get contents of the "PhotoLibrary" directory
            let photoFilesURL = documentsDirectory.appendingPathComponent("PhotoLibrary")
            let photoFileURLs = try FileManager.default.contentsOfDirectory(at: photoFilesURL, includingPropertiesForKeys: nil)
            
            return photoFileURLs
        } catch {
            print("Error getting photo file URLs:", error.localizedDescription)
            return nil
        }
    }
    
    func deleteImageFromFileManager(imageURL: URL) {
        do {
            try FileManager.default.removeItem(at: imageURL)
            print("Image deleted from file manager:", imageURL)
        } catch {
            print("Error deleting image from file manager:", error.localizedDescription)
        }
    }
    
    func saveVideoToFileManager(_ videoData: Data) {
        let folderName = "VideoFiles"
        let videoFilename = UUID().uuidString + ".mp4"
        let relativeURL = "\(folderName)/\(videoFilename)"
        
        do {
            // Get the documents directory URL
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(relativeURL)
            
            // Create the necessary directory structure if it doesn't exist
            try FileManager.default.createDirectory(at: fileURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            
            // Write the video data to the file at the specified URL
            try videoData.write(to: fileURL)
        } catch {
            // Print an error message if any issues occur during the video-saving process
            print("Error saving video:", error.localizedDescription)
        }
    }
    
    func loadVideoDataFromFileManager() -> [URL]? {
        do {
            // Get the documents directory URL
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            // Get contents of the "VideoFiles" directory
            let videoFilesURL = documentsDirectory.appendingPathComponent("VideoFiles")
            let videoFileURLs = try FileManager.default.contentsOfDirectory(at: videoFilesURL, includingPropertiesForKeys: nil)
            
            return videoFileURLs
        } catch {
            print("Error getting video file URLs:", error.localizedDescription)
            return nil
        }
    }
    
    func deleteVideoFromFileManager(videoURL: URL) {
        do {
            try FileManager.default.removeItem(at: videoURL)
            print("Video deleted from file manager:", videoURL)
        } catch {
            print("Error deleting video from file manager:", error.localizedDescription)
        }
    }
}

let fileManagerClassInstance = FileManagerClass.sharedInstance

