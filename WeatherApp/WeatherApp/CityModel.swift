//
//  CityModel.swift
//  WeatherApp
//
//  Created by Anushree on 25/02/22.
//

import Foundation

struct CityModel: Codable {
    
    struct Weather: Codable {
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
        let humidity: Int
    }
    let name: String
    let weather: [Weather]
    let main: Main
}
