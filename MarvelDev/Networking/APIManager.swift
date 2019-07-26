//
//  APIManager.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 23/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import Foundation
import Alamofire

struct APIManager {
    var heroes: [ Hero ]? = []
    
    private let hostURL = "https://gateway.marvel.com:443/v1/public"
    private let ts = 3
    private let apikey = "34ffb8bc1bd05814909e68ce513bb6f5"
    private let hash = "72dec51a3581a83f97479316fec89ea4"
    
    func getHero(byId id: Int? = nil, completion: @escaping (( [Hero?]? ) -> Void )) {
        var parameters: [String : Any] = ["ts": ts, "apikey": apikey, "hash": hash]
        if let uID = id {
            parameters["id"] = uID
        }
        let requestURL = "\(hostURL)/characters"
        getData(url: requestURL, parameters: parameters, completion: completion)
    }
    
    func getComic (by id: Int, completion: @escaping (([Comic?]?) -> Void)) {
        let requestURL = "\(hostURL)/comics"
        let parameters: [String : Any] = ["ts": ts, "apikey": apikey, "hash": hash]
        getData(url: requestURL, parameters: parameters, completion: completion)
    }
    
    
    // Funcion generica para obtener datos
    private func getData<T: Codable>(url: String, parameters: [String:Any], byId id: Int? = nil,
                                     completion: @escaping ( ( [ T? ]? ) -> Void ) ) {
        Alamofire.request(url, parameters: parameters).responseJSON { ( response ) in
            let jsonDecoder = JSONDecoder()
            guard let data = response.data else {
                completion( nil )
                return
            }
            let dataResponse = try? jsonDecoder.decode( MarvelResponse<T>.self, from: data)
            completion( dataResponse?.data.results )
        }
    }
}
