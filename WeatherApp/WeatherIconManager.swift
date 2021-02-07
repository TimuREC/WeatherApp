//
//  WeatherIconManager.swift
//  WeatherApp
//
//  Created by Timur Begishev on 07.02.2021.
//

import UIKit

enum WeatherIconManager: String {
	case clearDay = "sun.max.fill"
	case clearNight = "moon.stars.fill"
	case rain = "cloud.rain.fill"
	case snow = "cloud.snow.fill"
	case sleet = "cloud.sleet.fill"
	case wind = "wind"
	case fog = "cloud.fog.fill"
	case cloudy = "cloud.fill"
	case parlyCloudyDay = "cloud.sun.fill"
	case partlyCloudyNight = "cloud.moon.fill"
	case unpredictedIcon = "nosign"
	
	init(rawValue: String) {
		switch rawValue {
		case "clear-day": self = .clearDay
		case "clear-night": self = .clearNight
		case "rain": self = .rain
		case "snow": self = .snow
		case "sleet": self = .sleet
		case "wind": self = .wind
		case "fog": self = .fog
		case "cloudy": self = .cloudy
		case "parly-cloudy-day": self = .parlyCloudyDay
		case "partly-cloudy-night": self = .partlyCloudyNight
		default: self = .unpredictedIcon
		}
	}
}

extension WeatherIconManager {
	var image: UIImage {
		return UIImage(systemName: self.rawValue)!
	}
}
