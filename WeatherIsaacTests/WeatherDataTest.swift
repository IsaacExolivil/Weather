//
//  WeatherDataTest.swift
//  WeatherIsaacTests
//
//  Created by Isaac Loez on 10/12/21.
//

import XCTest
@testable import WeatherIsaac

class WeatherDataTest: XCTestCase {

     func testCanParseWeather() throws {
         let json = """
                 {
                     "coord": {
                         "lon": -122.4194,
                         "lat": 37.7749
                     },
                     "weather": [
                         {
                             "id": 801,
                             "main": "Clouds",
                             "description": "few clouds",
                             "icon": "02n"
                         }
                     ],
                     "base": "stations",
                     "main": {
                         "temp": 7.7,
                         
                     },
                     
                     "clouds": {
                         "all": 20
                     },
                    
                     
                     "id": 5391959,
                     "name": "San Francisco",
                     "cod": 200
                 }
                """

                let jsonData = json.data(using: .utf8)!
                let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData)

         XCTAssertEqual(7.7, weatherData?.main.temp)
         XCTAssertEqual(5391959, weatherData?.id)
                XCTAssertEqual("San Francisco", weatherData?.name)
            }
    
    func testCanParseWeatherEmptyCity() throws {
        let json = """
                {
                    "coord": {
                        "lon": -122.4194,
                        "lat": 37.7749
                    },
                    "weather": [
                        {
                            "id": 801,
                            "main": "Clouds",
                            "description": "few clouds",
                            "icon": "02n"
                        }
                    ],
                    "base": "stations",
                    "main": {
                        "temp": 7.7,
                        
                    },
                    
                    "clouds": {
                        "all": 20
                    },
                   
                    
                    "id": 5391959,
                    "name": "",
                    "cod": 200
                }
               """

               let jsonData = json.data(using: .utf8)!
               let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData)

               XCTAssertEqual("", weatherData?.name)
           }
    

    

}
