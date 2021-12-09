//
//  WeatherManager.swift
//  WeatherIsaac
//
//  Created by Isaac Loez on 08/12/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
    
}

//MARK: - WeatherManager
struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid="
    let apikey = "d82109de35cd54ad77e2513f3bc961dc&units=metric"
    
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)\(apikey)&q=\(cityName)"
        Request(urlString: urlString)
    }
    func fecthWeather(zipcode: String){
        let zipcode = "\(weatherURL)&zip=\(zipcode)"
    }
    
    //MARK: - Request urlString
    func Request(urlString: String) {
        //1.URl
       if  let url = URL(string: urlString) {
        //2.Create a URLSesion
        let session = URLSession(configuration: .default)
        
           let task = session.dataTask(with: url) {(data, response, error) in
               if error != nil {
                  //if you get an error, go to the delegate
                   delegate?.didFailWithError(error: error!)
                   return
           }
               //if there is no error the data is safe
               if let safeData = data {
                   if let weather = self.parseJSON( safeData) {
                       delegate?.didUpdateWeather(self, weather: weather)
                       
                   }
                   
                   
               }
           }
        task.resume()
    }
 }
    //MARK: - ParseJSON
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let idCity = decodedData.id
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, id: idCity)
            print(weather.conditionName)
         
            //Imprimimos el id del pais
            print(decodedData.id)
            //
            print(decodedData.name)
            print(weather.temperatureString)
            return weather
            
           
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}




    


