//
//  AudioManager.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/17/23.
//

import Foundation
import AVKit

class AudioManager: NSObject {
    static let sharedInstance: AudioManager = {
        let instance = AudioManager()
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    //Use type property not not singleton / or struct
    func playAudio(audioUrl: URL, viewController: UIViewController) {
        // Create an AVPlayer with the audioUrl
        let audioPlayer = AVPlayer(url: audioUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = audioPlayer
        
        // Present the AVPlayerViewController and start playing the audio
        viewController.present(playerViewController, animated: true) {
            audioPlayer.play()
        }
    }
}

let audioManagerInstance = AudioManager.sharedInstance
