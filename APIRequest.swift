//
// Created by Tiancheng Shuai on 12/3/21.
//

import Foundation

struct APIRequest {
    static func get_crypto_list(completion: @escaping (Array<crypto_name>) -> ()) {
        // Create URL
        let url = URL(string: "https://")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
            }
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            do {
                if let convertedJsonIntoArray = try JSONSerialization.jsonObject(with: data!, options: []) as? Array<AnyObject> {
                    //completion(convertedJsonIntoArray)
                    var cryptos = [crypto_name]()
                    for i in 0 ..< convertedJsonIntoArray.count {
                        var one = crypto_name(name: "initialName", symbol: "initialSymbol")
                        one.name = (convertedJsonIntoArray[i][0] as! String)
                        one.symbol = (convertedJsonIntoArray[i][1] as! String)
//                        print(one)
                        cryptos.append(one)
                    }
                    completion(cryptos)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    static func get_crypto_price(symbol: String, completion: @escaping (NSDictionary) -> ()) {
        // Create URL
        let url = URL(string: "https://\(symbol)")
        print(url)
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
            }
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            do {
                if let convertedJsonIntoArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
//                    print(convertedJsonIntoArray["price"])
                    completion(convertedJsonIntoArray)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

struct crypto_name {
    var name: String
    var symbol: String
}
