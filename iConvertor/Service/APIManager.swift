//
//  APIManager.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import Foundation

class APIManager: NSObject {
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    // Encode ConvertRequest to JSON data
    func encodeConvertRequest(_ convertRequest: ConvertRequest) -> Data? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(convertRequest)
            return jsonData
        } catch {
            print("Error encoding ConvertRequest: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Decode Conversion response
    func decodeConversionResponse(data: Data) -> ConversionResponse? {
        do {
            let decoder = JSONDecoder()
            let conversionResponse = try decoder.decode(ConversionResponse.self, from: data)
            return conversionResponse
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
