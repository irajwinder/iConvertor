//
//  TabBarView.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            AudioListView()
                .tabItem {
                    Label("Audio", systemImage: "mic")
                }
            VideoListView()
                .tabItem {
                    Label("Video", systemImage: "video")
                }
            PhotoListView()
                .tabItem {
                    Label("Photo", systemImage: "photo")
                }
        }
    }
}

#Preview {
    TabBarView()
}
