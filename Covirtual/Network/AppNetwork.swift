//
//  AppNetwork.swift
//  Covirtual
//
//  Created by Bona Deny S on 13/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

enum Header: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case x_api_key = "x-api-key"
    case content_type = "content-type"
    case application_x_www_form_urlencoded = "application/x-www-form-urlencoded"
    case application_json = "application/json"
}

class AppNetwork{
    private let base_key = API_KEY
    private let base_url = API_URL

    func get(url: String, params:[String:Any], method: Header, completionHandler: @escaping (_ data:Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        let task = URLSession.shared.dataTask(with: request(url,params,method.rawValue), completionHandler: completionHandler)
            task.resume()
    }
    private func request(_ url: String,_ params:[String:Any], _ method: String)->URLRequest{
        let data = try? JSONSerialization.data(withJSONObject: params, options: [])
        var request = URLRequest(url: URL(string: "\(base_url)\(url)")!)
        request.addValue(base_key.string, forHTTPHeaderField: Header.x_api_key.rawValue)
        request.addValue(Header.content_type.rawValue, forHTTPHeaderField: Header.content_type.rawValue)
        request.httpMethod = method
        request.httpBody = data
        
        return request
    }
}
