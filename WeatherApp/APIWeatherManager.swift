//
//  APIWeatherManager.swift
//  WeatherApp
//
//  Created by Timur Begishev on 07.02.2021.
//

import Foundation

struct Coordinates {
	let latitude: Double
	let longitude: Double
}

enum ForecastType: FinalURLPoint {
	case current(apiKey: String, coordinates: Coordinates)
//	2a6d8e376a69c1ae07d4a52dd0c2dfdc
	var baseURL: URL { return URL(string: "https://api.forecast.io")! }
	var path: String {
		switch self {
		case .current(let apiKey, let coordinates):
			return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)"
		}
	}
	var request: URLRequest {
		let url = URL(string: path, relativeTo: baseURL)
		return URLRequest(url: url!)
	}
}

final class APIWeatherManager: APIManager {
	
	let sessionConfiguration: URLSessionConfiguration
	lazy var session: URLSession = {
		return URLSession(configuration: self.sessionConfiguration)
	}()
	let apiKey: String
	
	init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
		self.sessionConfiguration = sessionConfiguration
		self.apiKey = apiKey
	}
	
	convenience init(apiKey: String) {
		self.init(sessionConfiguration: .default, apiKey: apiKey)
	}
	
	func fetchCurrentWeather(with coordinates: Coordinates, completion: @escaping (APIResult<CurrentWeather>) -> Void) {
		let request = ForecastType.current(apiKey: self.apiKey, coordinates: coordinates).request
		
		fetch(request: request, parse: { (json) -> CurrentWeather? in
			if let dictionary = json["currently"] as? [String: AnyObject] {
				return CurrentWeather(JSON: dictionary)
			} else {
				return nil
			}
		}, completion: completion)

	}
}
