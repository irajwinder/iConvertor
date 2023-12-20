//
//  MediaManager.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/17/23.
//

import Foundation
import AVKit

class MediaManager {
    static func playMedia(mediaURL: URL) {
        // Create an AVPlayer with the mediaURL
        let mediaPlayer = AVPlayer(url: mediaURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = mediaPlayer
        
        // Get the current window scene
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            // Get the first window in the window scene
            if let window = windowScene.windows.first {
                // Present the Media Player and start playing
                window.rootViewController?.present(playerViewController, animated: true, completion: {
                    mediaPlayer.play()
                })
            }
        }
    }
}
