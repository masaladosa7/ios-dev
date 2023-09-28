//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit


protocol CoinManagerDelegate{
    func didUpdateRate(_ coinManager: CoinManager, rate : Double?)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "?apikey=FA64F25A-600B-40B6-90FF-38F20BA247DE"
    
    var delegate : CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)\(apiKey)"
        performRequest(with: urlString)
    }
    

    func performRequest(with urlString:String){
        // if let since it creates an optional URL
        if let url = URL(string: urlString){
            
            //ends up creating a url session object which is effectively like our browser
            let session = URLSession(configuration: .default)
            
            //give the session a task
            
            // this is a closure, see carefully , dont get confused
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    let rate = self.parseJSON(safeData)
                    self.delegate?.didUpdateRate(self, rate: rate)
                }
            })
            
            //start the task
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ data: Data) -> Double?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
                  
                  }
                  
                  catch {
                      print(error)
                    return nil
        }
    }
    
}
