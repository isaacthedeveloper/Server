//
//  MenuController.swift
//  Server
//
//  Created by Isaac Ballas on 2019-12-09.
//  Copyright © 2019 Isaac Ballas. All rights reserved.
//

import Foundation

class MenuController {
    let baseURL = URL(string: "http://localhost:8090/")!
    
    // GET request
    // No query parameters, or addtional data to send, and the response is an array of string.
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let categories = jsonDictionary["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // GET request
    // Query Parameter: category string, the JSON that is returned contains an array of dictionaries that we will deserialize into a MenuItem object.
    // Two parameters, catergory string and array of MenuItem objects
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        // Add the query param
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            // The data will be converted into an array of MenuItem objects. Create a JSONDecoder, since the top level of data is an items key with an array as its value, use the devoder to decode all the data into a single menuitems objecy. If the data is succesfully ecoded, call completion and pass in the items property on the MENUITEMS objecy.
            let jsonDecoder = JSONDecoder()
            if let data = data, let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
    
    // POST request
    // include the collection of menu item IDs, and the response will include an integer specifying the number of minutes the order will take to prep. The mehtod that will perform this network call should have two parameters, an array of integers to hold the IDs and a completion closure that takes in the order prep time.
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        // Setting URLSession is different for a POST request. First, modify the requests default type from a GET to a POST. Then you will tell the server what kind of data you will be sending (JSON).
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Next, store the array of menu IDs in JSON under the key menuIds. To do this create a dictionary of type `[String: [Int]]`, a type that can be converted to or from JSON by an instance of JSONEncoder.
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        // Unlike a GET, which appends query parameters to the URL, the data for a POST must be stoed within the body of the request.
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // JSON Data that can be decoded into the itermediary model PrepartionTime by passing this value as the argument to completion, you can inform the use how long the order wil ltakwe
            let jsonDecoder = JSONDecoder()
            if let data = data, let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
