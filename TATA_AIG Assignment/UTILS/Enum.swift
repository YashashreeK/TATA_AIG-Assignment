//
//  Segue.swift
//  Shaadi.com
//
//  Created by Yashashree on 21/11/20.
//

import Foundation

fileprivate enum API_BASE: String {
    case key = "fbca4bb532880b835a26e7b109f071c7"
    case domain = "https://api.themoviedb.org/3"
    case imageDomain = "https://image.tmdb.org/t/p/w300/"
}

enum API_METHOD: String{
    case popularMovie = "/movie/popular"
}

enum API_URL{
    case movies(type: API_METHOD, param: String)
    case image(path: String)
    
    func url() -> String{
        switch self {
        case .image(let path):
            return "\(API_BASE.imageDomain)\(path)"
        case .movies(let type, let param):
            return "\(API_BASE.domain.rawValue)\(type.rawValue)?api_key=\(API_BASE.key.rawValue)\(param)"
        }
    }
}


enum NetworkError: Error {
    case badURL
    case noData
    case badStatusCode(code: Int)
    case conversionFailed
    case error(message: String)
}

extension NetworkError: LocalizedError{
    var errorDescription: String?{
        switch self {
        case .badURL:
            return "The requested url is not proper"
        case .badStatusCode(let code):
            return "Error: unexpected status code \(code)"
        case .noData:
            return "Error: No Data found for processing"
        case .conversionFailed:
            return "Error occurred while processing data"
        case .error(let message):
            return message
        }
    }
}

enum TITLE: String{
    case matchesList = "Matches"
    case userDetail = "User Details"
}

enum VIEWCONTROLLERS: String{
    case matchesList = "Matches"
    case userDetail = "UserDetail"
}


class test{
    /* API RESPONSE */
    let jsonProduct2000 = """
    {
        "status": "success",
        "data" : { "product1_2000" : 137, "product2_2000" : 13, "product3_2000" : 17, "product4_2000" : 127}
    }
    """

    let jsonOrder2000 = """
    {
        "status": "success",
        "data" : { "order1_2000" : 137, "order2_2000" : 13, "order3_2000" : 17, "order4_2000" : 127}
    }
    """

    let jsonProduct1999 = """
    {
        "status": "success",
        "data" : { "product1_1999" : 137, "product2_1999" : 13, "product3_1999" : 17, "product4_1999" : 127}
    }
    """

    let jsonOrder1999 = """
    {
        "status": "success",
        "data" : { "product1_1999" : 89, "product2_1999" : 90, "product3_1999" : 1, "product4_1999" : 17}
    }
    """


    //API DATA HANDLING
    var arrAllData = [[String: Any]]()

    func setDetails(){
        if let forcast_1999 = apiParsing(value: jsonProduct1999){
            if let order_1999 = apiParsing(value: jsonOrder1999){
                arrAllData.append(["forecast" : forcast_1999, "order" : order_1999])
            }
        }

        if let forcast_2000 = apiParsing(value: jsonProduct2000){
            if let order_2000 = apiParsing(value: jsonOrder2000){
                arrAllData.append(["forecast" : forcast_2000, "order" : order_2000])
            }
        }
    }

    func apiParsing(value: String) -> [String: Any]?{
        do {
            let parsedData = try JSONSerialization.jsonObject(with: value.data(using: String.Encoding.utf8)!, options: []) as! [String:Any]
           return parsedData["data"] as! [String : Any]
        } catch let error {
            print(error)
        }
        return nil
    }

    //LOGIC TO FETCH PRODUCTS

    func fetchProducts(){
        arrAllData.map({getData(forecast:$0["forecast"] as! [String : Any], order: $0["order"] as! [String : Any])})
    }

    func getData(forecast:[String: Any], order: [String : Any]){
        let array = forecast.compactMap{(key, value) -> String? in
            if (order[key] as? Int ?? 0) > (value as? Int ?? 0){
                return key
            }
            return nil
        }
        print("data:", array)
    }
}
