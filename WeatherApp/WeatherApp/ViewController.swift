//
//  ViewController.swift
//  WeatherApp
//
//  Created by Anushree on 22/02/22.
//

import CoreLocation
import UIKit

class ViewController: UIViewController {
    
    var latVal = 0.0
    var longVal = 0.0
    var searchedCityName = ""
    var celsiusTemparature: Int? = 0
    var locationManager = CLLocationManager()
    var instance = NetworkManager()
    var presentCityInstance = CityManager()
    var city = SearchCityViewController()
    
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var forecastedSymbol: UIImageView!
    @IBOutlet weak var forecastedTemparature: UILabel!
    @IBOutlet weak var forecastedDescription: UILabel!
    @IBOutlet weak var forecastedMinMaxTemparature: UILabel!
    @IBOutlet weak var forecastedHumidity: UILabel!
    @IBOutlet weak var fahrenheitButton: UIButton!
    @IBOutlet weak var celsiusButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.dateAndTime.text = Date().string(format: "E, dd MMM yyyy  hh:mm a")
        setViewLabels()
        setNavigationImage()
        getCurrentLocation()
    }
    
    func setNavigationImage() {
        
        let logo = UIImage(named: "splashScreenLogo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func getCurrentLocation() {
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setViewLabels() {
        
        presentCityInstance.loadWeatherData { City in
            DispatchQueue.main.async {
                
                self.cityName.text = City.cityName
                self.forecastedMinMaxTemparature.text = City.minTemp + "°" + " - " + City.maxTemp + "°"
                self.forecastedHumidity.text = "\(City.humidity)"
                self.forecastedDescription.text = City.description
                self.forecastedSymbol.image = UIImage(named: City.icon)
                self.forecastedTemparature.text = City.tempInCelsius
                self.celsiusTemparature = Int(City.tempInCelsius)
            }
        }
    }
    
    @IBAction func addToFavouriteTapped(_ sender: Any) {
        print("City added to favourite list")
    }
    
    @IBAction func celsiusButtonTapped(_ sender: Any) {
        
        if let temp = celsiusTemparature {
            forecastedTemparature.text = "\(temp)"
        }
        celsiusButton.backgroundColor = .white
        celsiusButton.tintColor = .red
        fahrenheitButton.backgroundColor = .clear
        fahrenheitButton.tintColor = .white
        print("Celsius scale is displayed")
    }
    
    @IBAction func fahrenheitButtonTapped(_ sender: Any) {
        
        if let temp = celsiusTemparature {
            forecastedTemparature.text = "\(temp * 9 / 5 + 32)"
        }
        celsiusButton.backgroundColor = .clear
        celsiusButton.tintColor = .white
        fahrenheitButton.backgroundColor = .white
        fahrenheitButton.tintColor = .red
        print("Fahrenhite scale is displayed")
    }
    
    @IBAction func searchCityTapped(_ sender: UIBarButtonItem) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchCityViewController") as! SearchCityViewController
        self.navigationController?.pushViewController(newVC, animated: true)
        newVC.cityDelegate = self
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latVal = locValue.latitude
        longVal = locValue.longitude
        presentCityInstance.fetchLatitudeAndLongitude(lat: latVal, long: longVal)
    }
}

extension ViewController: PassSearchedCityName {
    
    func passCity(cityName: String) {
        instance.fetchWeather(cityName: cityName)
        locationManager.stopUpdatingLocation()
        instance.loadWeatherData { Weather in
            DispatchQueue.main.async {
                
                self.cityName.text = Weather.city
                self.forecastedMinMaxTemparature.text = Weather.maxTemp + "°" + " - " + Weather.minTemp + "°"
                self.forecastedHumidity.text = "\(Weather.humidity)"
                self.forecastedDescription.text = Weather.description
                self.forecastedSymbol.image = UIImage(named: Weather.icon)
                self.forecastedTemparature.text = Weather.tempInCelsius
                self.celsiusTemparature = Int(Weather.tempInCelsius)
            }
        }
    }
}




