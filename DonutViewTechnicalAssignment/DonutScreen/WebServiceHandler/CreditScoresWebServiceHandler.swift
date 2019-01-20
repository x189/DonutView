//
//  CreditScoresWebServiceHandler.swift
//  DonutViewTechnicalAssignment
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import Foundation

private struct CreditScoresWebServiceResponse: Decodable {
    // More properties could be added to this struct if we need them parsed
    // Currently, we only need those two, so I've only added them
    struct CreditReportInfo: Decodable {
        let score: Double
        let maxScoreValue: Double
    }
    
    let creditReportInfo: CreditReportInfo
}

enum CreditScoresWebServiceError {
    case invalidURL, missingResponseData
}

extension CreditScoresWebServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Couldn't create the needed URL for the credit scores information."
        case .missingResponseData:
            return "Couldn't receive credit scores information from the server."
        }
    }
}

class CreditScoresWebServiceHandler {
    private struct Constants {
        struct Endpoint {
            static let Scheme = "https"
            static let Host = "5lfoiyb0b3.execute-api.us-west-2.amazonaws.com"
            static let Path = "/prod/mockcredit/values"
            
            private init() { }
        }
        
        private init() { }
    }
    
    private lazy var url: URL? = {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.Endpoint.Scheme
        urlComponents.host = Constants.Endpoint.Host
        urlComponents.path = Constants.Endpoint.Path
        return urlComponents.url
    }()
    
    func getCreditScores(completionHandler: @escaping ((currentScore: Double, maxScore: Double)?, _ error: Error?) -> Void) {
        guard let url = url else {
            handleResponse(data: nil, error: CreditScoresWebServiceError.invalidURL, completionHandler: completionHandler)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.handleResponse(data: data, error: error, completionHandler: completionHandler)
            }.resume()
    }
    
    private func handleResponse(data: Data?, error: Error?, completionHandler: @escaping ((currentScore: Double, maxScore: Double)?, _ error: Error?) -> Void) {
        DispatchQueue.main.async{
            guard let data = data else {
                completionHandler(nil, CreditScoresWebServiceError.missingResponseData)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(CreditScoresWebServiceResponse.self, from: data) as CreditScoresWebServiceResponse
                completionHandler((decodedResponse.creditReportInfo.score, decodedResponse.creditReportInfo.maxScoreValue), nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
}
