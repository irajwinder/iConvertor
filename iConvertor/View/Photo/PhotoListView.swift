//
//  PhotoListView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct PhotoListView: View {
    @StateObject private var stateObject = PhotoViewIntent()
    @State private var isPhotoCameraViewPresented = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if stateObject.photos.isEmpty {
                    Spacer()
                    Text("No photos available")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(stateObject.photos, id: \.self) { photoURL in
                            NavigationLink {
                                PhotoDetailView(imageURL: photoURL)
                            } label: {
                                Text(photoURL.lastPathComponent)
                            }
                        }
                        .onDelete(perform: stateObject.deletePhoto)
                    }
                }
            }
            .navigationTitle("Photo")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        isPhotoCameraViewPresented = true
                    }) {
                        Label("Photo", systemImage: "camera")
                    }
                    .sheet(isPresented: $isPhotoCameraViewPresented) {
                        PhotoCameraView(observedObject: stateObject)
                    }
                }
            }
            .onAppear {
                stateObject.fetchImages()
                stateObject.checkCameraAccess()
                stateObject.checkPhotoLibraryAccess()
            }
        }
    }
}

#Preview {
    PhotoListView()
}
