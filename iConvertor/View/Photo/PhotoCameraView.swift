//
//  PhotoCameraView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct PhotoCameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var observedObject: PhotoViewIntent
    @ObservedObject var permissionManager: PermissionManager
    
    @State private var pickedImage: Image?
    @State private var imageData: Data?
    @State private var showCameraPicker = false
    @State private var showLibraryPicker = false
    
    var body: some View {
        VStack {
            if let image = pickedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Button("Save Image") {
                    if let imageData = imageData {
                        FileManagerClass.sharedInstance.saveImageToFileManager(imageData)
                        observedObject.fetchImages()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            } else {
                VStack(spacing: 30) {
                    Button("Take Photo") {
                        showCameraPicker.toggle()
                    }.disabled(!permissionManager.isCameraPermissionGranted)
                    
                    Button("Choose from Library") {
                        showLibraryPicker.toggle()
                    }.disabled(!permissionManager.isPhotoLibraryPermissionGranted)
                }
            }
        }
        .sheet(isPresented: $showCameraPicker) {
            ImagePicker(pickedImage: $pickedImage, imageData: $imageData, sourceType: .camera)
        }
        .sheet(isPresented: $showLibraryPicker) {
            ImagePicker(pickedImage: $pickedImage, imageData: $imageData, sourceType: .photoLibrary)
        }
    }
}

#Preview {
    PhotoCameraView(observedObject: PhotoViewIntent(), permissionManager: PermissionManager())
}
