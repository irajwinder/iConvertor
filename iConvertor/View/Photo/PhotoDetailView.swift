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
    }
}

#Preview {
    PhotoDetailView(imageURL: URL(fileURLWithPath: ""))
}
