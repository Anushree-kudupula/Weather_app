//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Anushree on 25/02/22.
//

import UIKit

protocol PassSearchedCityName {
    func passCity(cityName: String)
}

class SearchCityViewController: UIViewController, UISearchBarDelegate {
    
    var cityDelegate: PassSearchedCityName?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if let city = searchBar.text {
            cityDelegate?.passCity(cityName: city)
            self.searchBar.text = ""
        }
    }
}
