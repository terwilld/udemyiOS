//
//  WeatherManager.swift
//  Clima
//
//  Created by David Terwilliger on 11/24/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error : Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=664ba5a16dd836bfb5664c8624385519&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName : String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print("My url String: \(urlString)")
        performRequest(with: urlString)
        
    }
    func fetchWeather(latitude: CLLocationDegrees , longitude : CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print("My url String: \(urlString)")
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            //            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    print("About to enter parse JSON")
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather:weather)
                    }

                }
            }
            print(url)
            //4. STart the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
/*            print("Testing Computed value")
            print(weather.conditionName)
            print(weather.temperatureString)
            let conditionString = getConditionName(weatherId : id)
            print(conditionString)
            print(decodedData)
*/

            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
/*
        print("inside Parse JSON")
        let str = String(data: weatherData, encoding: .utf8)
        print(str!)
        print(weatherData)
*/
    }

    
    /*
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil {
            print("Error!")
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print("Valid String")
            print(dataString!)
        }
        
    }
    */

}

/*
https://stackoverflow.com/questions/33997994/swift-360-image-with-device-motion

 https://www.google.com/search?q=taking+a+360+photo+with+swift&sxsrf=ALiCzsbZnIOOsPdFsX3mq5OCbroRCW95IQ%3A1669391525089&ei=peSAY9T8BLSg5NoPofSO6A4&ved=0ahUKEwiU49-G2Mn7AhU0EFkFHSG6A-0Q4dUDCBA&uact=5&oq=taking+a+360+photo+with+swift&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCCEQoAEyBQghEKABMgUIIRCgATIICCEQFhAeEB06CggAEEcQ1gQQsAM6BQghEKsCSgQIQRgASgQIRhgAUKwIWO0MYN0NaAFwAXgAgAGFAYgB-QOSAQM0LjGYAQCgAQHIAQjAAQE&sclient=gws-wiz-serp
 
 https://cocoapods.org/pods/Image360
 */
