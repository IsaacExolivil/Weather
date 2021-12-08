//
//  WeatherManager.swift
//  WeatherIsaac
//
//  Created by Isaac Loez on 08/12/21.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=d82109de35cd54ad77e2513f3bc961dc&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        Request(urlString: urlString)
    }
    func Request(urlString: String) {
        //1.URl
       if  let url = URL(string: urlString) {
        //2.Create a URLSesion
        let session = URLSession(configuration: .default)
        
       let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
        task.resume()
    }
}

func handle(data: Data?, response: URLResponse?, error: Error?) {
    
    if error != nil {
        print(error!)
        return
        
    }
    //if there is no error the data is safe
    if let safeData = data {
        let dataString = String(data: safeData, encoding: .utf8)
        print(dataString)
        
    }
    
    
}
    
}
    


