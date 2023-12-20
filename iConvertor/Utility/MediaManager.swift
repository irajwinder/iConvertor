//
//  MediaManager.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/17/23.
//

import Foundation
import AVKit

class MediaManager {
    private static func getCurrentWindow() -> UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        // Get the first window in the window scene
        return windowScene.windows.first
    }
    
    static func playMedia(mediaURL: URL) {
        // Create an AVPlayer with the mediaURL
        let mediaPlayer = AVPlayer(url: mediaURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = mediaPlayer
        
        // Get the current window scene
        if let window = getCurrentWindow() {
            window.rootViewController?.present(playerViewController, animated: true) {
                mediaPlayer.play()
            }
        }
    }
    
    static func shareViaOtherApps(fileURL: URL) {
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        
        // Get the current window scene
        if let window = getCurrentWindow() {
            window.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
    }
}
