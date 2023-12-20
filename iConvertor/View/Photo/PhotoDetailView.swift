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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        MediaManager.shareViaOtherApps(fileURL: imageURL)
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }
            }
            .navigationTitle("Photo Detail")
    }
}

#Preview {
    PhotoDetailView(imageURL: URL(fileURLWithPath: ""))
}
