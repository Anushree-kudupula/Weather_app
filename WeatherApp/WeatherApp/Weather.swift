//
//  Weather.swift
//  WeatherApp
//
//  Created by Anushree on 24/02/22.
//

import Foundation

public struct Weather {
    
    let city : String
    let minTemp: String
    let maxTemp: String
    let humidity: Int
    let description: String
    let icon: String
    let tempInCelsius: String
    
    init(response: Forecast) {
        city = response.name
        minTemp = "\(Int(response.main.temp_min))"
        maxTemp = "\(Int(response.main.temp_max))"
        humidity = response.main.humidity
        description = response.weather[0].description
        icon = response.weather[0].icon
        tempInCelsius = "\(Int(response.main.temp))"
    }
}
