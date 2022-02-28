//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Anushree on 23/02/22.
//

import Foundation

class NetworkManager {
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?&appid=52ba266b5d15d637fed72551de63fea9&units=metric"
    var completionHandler: ((Weather) -> Void)?
    
    func loadWeatherData(
        _ completionHandler: @escaping((Weather) -> Void)
      ) {
        self.completionHandler = completionHandler
      }

    func fetchWeather (cityName: String) {
        
        let urlString = ("\(weatherURL)&q=\(cityName)")
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error? ) ->Void {
        
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            parseJSON(weatherData: safeData)
        }
        
        func parseJSON (weatherData: Data) {
            
            let decoder = JSONDecoder()
            do {
                
                let decodedData = try decoder.decode(Forecast.self, from: weatherData)
                print("Searched city is \(decodedData.name)")
                self.completionHandler?(Weather(response: decodedData))
                
            } catch {
                print(error)
            }
        }
    }
}

