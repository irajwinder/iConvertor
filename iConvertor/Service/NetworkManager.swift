//
//  NetworkManager.swift
//  iConvertor
//
//  Created by Rajwinder Singh on 12/13/23.
//

import Foundation

class NetworkManager : NSObject {
    
    static let sharedInstance : NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    private override init() {
        super.init()
        
    }
    
    func convertImage(fromConvert: String, toConvert: String, imageURL: URL, completion: @escaping (ConversionResponse?) -> Void) {
        //         let url = "https://v2.convertapi.com/convert/jpg/to/png?Secret=cQuPvl6JL5eXUnOB&File=https://www.pawlovetreats.com/cdn/shop/articles/pembroke-welsh-corgi-puppy_1000x.jpg&StoreFile=true"
        let apiUrl = "\(APIConstants.baseURL)/convert/\(fromConvert)/to/\(toConvert)?Secret=cQuPvl6JL5eXUnOB"
        // 1. Get the url
        guard let requestURL = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        // 2. Get the URLRequest
        var urlRequest = URLRequest(url: requestURL)
        // Sets cache policy and timeout interval for the request
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = APIConstants.headers
        
        // 3. Prepare parameters
        let fileData = try? Data(contentsOf: imageURL)
        let base64EncodedFile = fileData?.base64EncodedString()
        let fileName = imageURL.lastPathComponent
        let fileValue = FileValue(Name: fileName, Data: base64EncodedFile ?? "")
        //Creates Parameters for the ConvertRequest
        let parameters = [
            Parameter(Name: "File", FileValue: fileValue, Value: nil),
            Parameter(Name: "StoreFile", FileValue: nil, Value: true)
        ]
        let convertRequest = ConvertRequest(Parameters: parameters)
        
        // 4. Encode ConvertRequest to JSON and set as HTTPBody
        if let jsonData = APIManager.sharedInstance.encodeConvertRequest(convertRequest) {
            urlRequest.httpBody = jsonData
        } else {
            completion(nil)
            return
        }
        
        // 5. Make API request
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            // Decode JSON response
            let conversionResponse = APIManager.sharedInstance.decodeConversionResponse(data: data)
            completion(conversionResponse)
        }
        task.resume()
    }
}
