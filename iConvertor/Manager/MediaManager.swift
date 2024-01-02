//
//  MediaManager.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/17/23.
//

import AVKit
import MessageUI

class MediaManager: NSObject {
    static let shared = MediaManager()
    
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
    
    static func shareViaEmail(fileURL: URL, mimeType: String, fileName: String) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Device cannot send email")
            return
        }
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.addAttachmentData(try! Data(contentsOf: fileURL), mimeType: mimeType, fileName: fileName)
        
        mailComposeVC.mailComposeDelegate = shared //Navigate back to the app
        
        // Get the current window scene
        if let window = getCurrentWindow() {
            window.rootViewController?.present(mailComposeVC, animated: true, completion: nil)
        }
    }
}

extension MediaManager: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
