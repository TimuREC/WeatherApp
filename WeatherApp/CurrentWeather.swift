//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Timur Begishev on 07.02.2021.
//

import UIKit

struct CurrentWeather {
	
	let temperature: Double
	let appearentTemperature: Double
	let humidity: Double
	let pressure: Double
	let icon: UIImage
	
//	let locationLabel: Double
//	let refreshButton: Double
	
}

extension CurrentWeather {
	
	var pressureString: String {
		return "\(Int(pressure)) mm"
	}
	var humidityString: String {
		return "\(Int(humidity))%"
	}
	var temperatureString: String {
		return "\(Int(temperature))ºC"
	}
	var appearentTemperatureString: String {
		return "Feels like: \(Int(appearentTemperature))ºC"
	}
}
