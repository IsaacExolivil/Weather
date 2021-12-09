//
//  WeatherData.swift
//  WeatherIsaac
//
//  Created by Isaac Loez on 08/12/21.
//

import Foundation
struct WeatherData: Decodable {
    let name: String
    let id: Int
    let main: Main
    let weather: [Weather]
    
}
struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
