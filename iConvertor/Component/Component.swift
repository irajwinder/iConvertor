//
//  Component.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: Image?
    @Binding var imageData: Data?

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
                // Update the image and its data
                parent.image = Image(uiImage: uiImage)
                parent.imageData = uiImage.jpegData(compressionQuality: 0.5)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    // Create a Coordinator instance
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    // Create and configure the UIImagePickerController
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

