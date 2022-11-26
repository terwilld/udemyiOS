//
//  WeatherData.swift
//  Clima
//
//  Created by David Terwilliger on 11/24/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let coord : Coord
    let main : Main
    let weather: [Weather]
    let name : String

}



struct Coord: Codable {
    let lon : Float
    let lat : Float
}

struct Main: Codable {
    let temp: Double
/*
    let feels_like : Float
    let temp_min : Float
    let temp_max : Float
    let pressure : Int
    let humidity : Int
 */
}

struct Weather: Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
    
    
    
}




//weather[0].description
