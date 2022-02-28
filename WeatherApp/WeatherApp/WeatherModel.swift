//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Anushree on 23/02/22.
//

import Foundation

struct Forecast: Codable {
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
