//
//  APIConvertible.swift
//  SeSAC_iTunesSearchRx
//
//  Created by 문정호 on 11/6/23.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible{
    case iTunesSearch(query: String)
    
    var baseURL: String{
        switch self {
        case .iTunesSearch:
            return "https://itunes.apple.com"
        }
    }
    
    var endPoint: String{
        switch self {
        case .iTunesSearch:
            return "/search"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .iTunesSearch:
            return .get
        }
    }
    
    var headers: HTTPHeaders{
        switch self {
        case .iTunesSearch:
            return ["": ""]
        }
    }
    
    var query: [String: String] {
        switch self {
        case .iTunesSearch(let query):
            return ["term": query, "country":"KR", "media": "software", "lang": "ko_KR", "limit": "10"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL)!.appending(path: endPoint)
        var urlRequest = try URLRequest(url: url, method: method, headers: headers)
        
        urlRequest = try URLEncodedFormParameterEncoder(destination: .queryString).encode(query, into: urlRequest)
        
        return urlRequest
    }
}
