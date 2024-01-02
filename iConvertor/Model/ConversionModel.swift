//
//  ConversionModel.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/26/23.
//

import Foundation

struct ConvertRequest: Codable {
    let Parameters: [Parameter]
}

struct Parameter: Codable {
    let Name: String
    let FileValue: FileValue?
    let Value: Bool?
}

struct FileValue: Codable {
    let Name: String
    let Data: String
}

struct ConversionResponse: Codable {
    let ConversionCost: Int
    let Files: [ConvertedFile]
}

struct ConvertedFile: Codable {
    let FileName: String
    let FileSize: Int
    let Url: URL
}
