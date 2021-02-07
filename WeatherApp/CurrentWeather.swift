//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Timur Begishev on 07.02.2021.
//

import UIKit

struct CurrentWeather {
	
	let temperature: Double
	let apparentTemperature: Double
	let humidity: Double
	let pressure: Double
	let icon: UIImage
	
//	let locationLabel: Double
//	let refreshButton: Double
	
}

extension CurrentWeather: JSONDecodable {
	init?(JSON: [String : AnyObject]) {
		guard let temperature = JSON["temperature"] as? Double,
			  let appearentTemperature = JSON["apparentTemperature"] as? Double,
			  let humidity = JSON["humidity"] as? Double,
			  let pressure = JSON["pressure"] as? Double,
			  let iconString = JSON["icon"] as? String
		else { return nil }
		
		let icon = WeatherIconManager(rawValue: iconString).image
		self.temperature = temperature
		self.apparentTemperature = appearentTemperature
		self.humidity = humidity
		self.pressure = pressure
		self.icon = icon
	}
}

extension CurrentWeather {
	
	var pressureString: String {
		return "\(Int(pressure * 0.750062)) mm"
	}
	var humidityString: String {
		return "\(Int(humidity * 100))%"
	}
	var temperatureString: String {
		return "\(Int(5 / 9 * (temperature - 32)))ºC"
	}
	var appearentTemperatureString: String {
		return "Feels like: \(Int(5 / 9 * (apparentTemperature - 32)))ºC"
	}
}
