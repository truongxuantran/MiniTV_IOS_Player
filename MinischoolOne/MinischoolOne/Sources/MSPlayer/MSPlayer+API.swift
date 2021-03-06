//
//  MSPlayer+API.swift
//  MinischoolOne
//
//  Created by JONGYOUNG CHUNG on 29/07/2019.
//  Copyright © 2019 Minischool. All rights reserved.
//

import Foundation

extension MSPlayer {
    func callBackLog(payload: [String: Any]) {
        if !self.backLoggingOn {
            return
        }
        DispatchQueue.global().async {
            self.callAPI(payload: payload)
        }
    }
    
    func callAPI(payload: [String: Any]) {
        
        guard let payloadData = try? JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            , let payloadString = String(data: payloadData, encoding: String.Encoding.utf8)
            else { return }
        
        let class_key = self.classKeyAndToken.substring(0..<20)
        let token = self.classKeyAndToken.substring(from: 20)
        
        let json: [String: String] =
            [
                "class_key": class_key,
                "code": "p3-ios-debug",
                "payload": payloadString,
                "token": token
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        // create post request
        let url = URL(string: "https://dev-papi.ekidpro.com/v3/common/addCdrMsg")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DLog.printLog(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                DLog.printLog("rcallAPI esponseJSON: \(responseJSON)")
            }
        }
        task.resume()
    }
}
