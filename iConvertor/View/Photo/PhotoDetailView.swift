//
//  PhotoDetailView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct PhotoDetailView: View {
    var imageURL: URL
    
    var body: some View {
        Image(uiImage: (UIImage(contentsOfFile: imageURL.path) ?? UIImage(systemName: "photo"))!)
            .resizable()
            .scaledToFit()
            .navigationTitle("Photo Detail")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            MediaManager.shareViaOtherApps(fileURL: imageURL)
                        }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        
                        Button(action: {
                            MediaManager.shareViaEmail(fileURL: imageURL, mimeType: "image/jpg", fileName: "photo.jpg")
                        }) {
                            Label("Share via Email", systemImage: "envelope")
                        }
                        
                        Button(action: {
                            convertImage()
                        }) {
                            Label("Convert Image", systemImage: "photo.badge.plus")
                        }
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                    }
                }
            }
    }
    
    func convertImage() {
        NetworkManager.sharedInstance.convertImage(fromConvert: "jpg", toConvert: "png", imageURL: imageURL) { conversionResponse in
            if let response = conversionResponse {
                print("Conversion successful. Files: \(response.Files)")
                for file in response.Files {
                    print("Conversion URL: \(file.Url)")
                    
                    if let imageData = try? Data(contentsOf: file.Url) {
                        FileManagerClass.sharedInstance.saveFile(imageData)
                    } else {
                        print("Failed to convert file URL to Data.")
                    }
                }
            } else {
                print("Conversion failed.")
            }
        }
    }
}

#Preview {
    PhotoDetailView(imageURL: URL(fileURLWithPath: ""))
}
