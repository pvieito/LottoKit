//
//  LottoManager.swift
//  LottoKit
//
//  Created by Pedro José Pereira Vieito on 30/12/2017.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation

public struct LottoManager {
    enum LottoError: LocalizedError {
        case httpError(Int)
        case dataError(String)
        case serverError(String)
        
        var errorDescription: String? {
            switch self {
            case .httpError(let errorCode):
                return "HTTP error with code “\(errorCode)”."
            case .dataError(let description):
                return "Data error: \(description)."
            case .serverError(let description):
                return "Server error: \(description)."

            }
        }
    }
    
    public enum LottoMode: String {
        case christmas = "Christmas"
        case elNiño = "ElNiño"
        
        static var defaultMode: LottoMode {
            return .christmas
        }
        
        var apiEndpointString: String {
            switch self {
            case .christmas:
                return "https://api.elpais.com/ws/LoteriaNavidadPremiados"
            case .elNiño:
                return "https://api.elpais.com/ws/LoteriaNinoPremiados"
            }
        }
        
        var apiEndpoint: URL {
            return URL(string: self.apiEndpointString)!
        }
    }
    
    private static let lottoApiResponsePreffix = "busqueda="
    
    private static func getLottoURL(number: Int, mode: LottoMode) -> URL {
        var urlComponents = URLComponents(string: mode.apiEndpointString)!
        let numberQuery = URLQueryItem(name: "n", value: String(number))
        urlComponents.queryItems = [numberQuery]
        return urlComponents.url!
    }
    
    public static func checkLotto(number: Int, mode: LottoMode? = nil) throws -> LottoResult {
        let mode = mode ?? LottoMode.defaultMode
        
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        let taskQueue = DispatchQueue(label: "com.pvieito.LottoTool.URLSession")
        
        taskQueue.async {
            let dataTask = URLSession.shared.dataTask(with: self.getLottoURL(number: number, mode: mode)) { (taskData, taskResponse, taskError) in
                (data, response, error) = (taskData, taskResponse, taskError)
                semaphore.signal()
            }
            
            dataTask.resume()
        }
        
        semaphore.wait()
        
        if let error = error {
            throw error
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw LottoError.serverError("Response not available")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw LottoError.httpError(httpResponse.statusCode)
        }
        
        guard let responseData = data else {
            throw LottoError.dataError("No data available")
        }
        
        guard let responseString = String(bytes: responseData, encoding: .utf8),
            responseString.hasPrefix(LottoManager.lottoApiResponsePreffix),
            let jsonData = responseString.replacingOccurrences(of: LottoManager.lottoApiResponsePreffix, with: "").data(using: .utf8) else {
                throw LottoError.dataError("Malformed response string")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        guard let lottoResult = try? decoder.decode(LottoResult.self, from: jsonData) else {
            throw LottoError.serverError("Malformed response dictionary")
        }
        
        return lottoResult
    }
}
