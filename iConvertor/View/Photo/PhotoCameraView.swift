//
//  PhotoCameraView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import PhotosUI
import SwiftUI

struct PhotoCameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var observedObject: PhotoViewIntent
    
    @State private var selectedPickerImage: PhotosPickerItem?
    @State private var photoImage: Image?
    @State private var photoData: Data?
    
    @State private var showCamera = false
    
    var body: some View {
        VStack {
            if photoImage == nil {
                PhotosPicker(
                    "Select photo",
                    selection: $selectedPickerImage,
                    matching: .images
                )
                .padding()
                
                Button("Take Photo") {
                    showCamera.toggle()
                }
            } else {
                photoImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Button("Save Image") {
                    fileManagerClassInstance.saveImageToFileManager(photoData ?? Data())
                    observedObject.fetchImages()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(image: $photoImage, imageData: $photoData)
        }
        .onChange(of: selectedPickerImage) {
            Task {
                do {
                    guard let data = try await selectedPickerImage?.loadTransferable(type: Data.self) else {
                        print("Failed to load image data.")
                        return
                    }
                    
                    guard let uiImage = UIImage(data: data) else {
                        print("Failed to create UIImage from loaded data.")
                        return
                    }
                    
                    self.photoImage = Image(uiImage: uiImage)
                    self.photoData = data
                } catch {
                    print("Error loading image: \(error)")
                }
            }
        }
    }
}

#Preview {
    PhotoCameraView(observedObject: PhotoViewIntent())
}
