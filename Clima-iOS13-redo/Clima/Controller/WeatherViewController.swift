//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self


    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UIText Field Delegate

extension WeatherViewController : UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            print("My city: \(city)")
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)  {
        print("inside view controller delegate: \(weather.temperature)")
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            print("Current Weather condition Name: \(weather.conditionName)")
            self.conditionImageView.image = UIImage(systemName : weather.conditionName)
        }
    }
    func didFailWithError(error: Error) {
        print("I'm inside the error handler: \(error)")
    }

}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("test")
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
//            print("Latitude: \(lat)")
//            print("Longitude: \(long)")
            weatherManager.fetchWeather(latitude : lat, longitude : lon)
        }
        
        print(locations)
        print(locations.last as Any)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}







//664ba5a16dd836bfb5664c8624385519


//https://api.openweathermap.org/data/2.5/weather?q=Boston&appid=664ba5a16dd836bfb5664c8624385519
// JSON viewer awesome

//https://api.openweathermap.org/data/2.5/weather?q=Boston&appid=664ba5a16dd836bfb5664c8624385519&units=imperial

//https://api.openweathermap.org/data/2.5/weather?appid=664ba5a16dd836bfb5664c8624385519&units=imperial&lat=51&lon=-0.1


//https://api.openweathermap.org/data/2.5/weather?appid=664ba5a16dd836bfb5664c8624385519&units=imperial&lat=42.3601&lon=-71.0589

//42.3601° N, 71.0589° W
//units=imperial
