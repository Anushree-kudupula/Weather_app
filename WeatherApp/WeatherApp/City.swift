//
//  City.swift
//  WeatherApp
//
//  Created by Anushree on 25/02/22.
//

import Foundation

class City {
    
    let cityName : String
    let minTemp: String
    let maxTemp: String
    let humidity: Int
    let description: String
    let tempInCelsius: String
    let icon: String
    
    init(response: CityModel) {
        cityName = response.name
        minTemp = "\(Int(response.main.temp_min))"
        maxTemp = "\(Int(response.main.temp_max))"
        humidity = response.main.humidity
        description = response.weather[0].description
        tempInCelsius = "\(Int(response.main.temp))"
        icon = response.weather[0].icon
    }
}
