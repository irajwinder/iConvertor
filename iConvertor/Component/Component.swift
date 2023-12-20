//
//  Component.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI
import AVKit

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var pickedImage: Image?
    @Binding var imageData: Data?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    // Create a Coordinator instance
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // Create and configure the UIImagePickerController
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    // Coordinator class to handle delegate methods
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        // Reference to the parent ImagePicker
        var parent: ImagePicker
        
        // Coordinator initializer
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        // Delegate method called when an image is picked
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Check if the picked media is an image
            if let uiImage = info[.originalImage] as? UIImage {
                parent.pickedImage = Image(uiImage: uiImage)
                parent.imageData = uiImage.jpegData(compressionQuality: 0.5)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct VideoPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var pickedVideoURL: URL?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    // Create a Coordinator instance
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // Create and configure the UIImagePickerController
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.mediaTypes = [UTType.movie.identifier] // Specify that only videos are allowed
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    // Coordinator class to handle delegate methods
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        // Reference to the parent VideoPicker
        var parent: VideoPicker
        
        // Coordinator initializer
        init(parent: VideoPicker) {
            self.parent = parent
        }
        
        // Delegate method called when a video is picked
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Check if the picked media is a video
            if let videoURL = info[.mediaURL] as? URL {
                parent.pickedVideoURL = videoURL
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AVPlayerController: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
