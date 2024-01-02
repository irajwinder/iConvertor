//
//  Constant.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

struct APIConstants {
    static let headers = ["Content-Type": "application/json"]
    static let baseURL = "https://v2.convertapi.com"
}

struct FileConstants {
    static let audioFolderName = "AudioFiles"
    static let audioFileExtension = ".wav"
    
    static let imageFolderName = "PhotoLibrary"
    static let imageFileExtension = ".jpg"
    
    static let videoFolderName = "VideoFiles"
    static let videoFileExtension = ".mp4"
}

struct ConversionConstants {
    static let imageFolderName = "PhotoLibrary"
    static let imageFileExtension = ".png"
}
