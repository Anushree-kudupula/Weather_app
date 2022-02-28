//
//  CityManager.swift
//  WeatherApp
//
//  Created by Anushree on 25/02/22.
//

import Foundation

class CityManager {
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?&APPID=52ba266b5d15d637fed72551de63fea9&units=metric"
    var completionHandler: ((City) -> Void)?
    
    func loadWeatherData(
        _ completionHandler: @escaping((City) -> Void)
      ) {
        self.completionHandler = completionHandler
      }
    
    func fetchLatitudeAndLongitude (lat: Double, long: Double) {
        let urlString = ("\(weatherURL)&lat=\(lat)&lon=\(long)")
        print(urlString)
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
            print(dataString)
            parseJSON(weatherData: safeData)
        }
        
        func parseJSON (weatherData: Data) {
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CityModel.self, from: weatherData)
                print("CITY is \(decodedData.name)")
                self.completionHandler?(City(response: decodedData))
            } catch {
                print(error)
                
            }
        }
    }
}
