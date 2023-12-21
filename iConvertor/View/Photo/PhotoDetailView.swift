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
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                    }
                }
            }
    }
}

#Preview {
    PhotoDetailView(imageURL: URL(fileURLWithPath: ""))
}
