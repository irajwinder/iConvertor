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
        
        // Present the Media Player and start playing
        UIApplication.shared.windows.first?.rootViewController?.present(playerViewController, animated: true, completion: {
            mediaPlayer.play()
        })
    }
}
