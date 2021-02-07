//
//  ViewController.swift
//  WeatherApp
//
//  Created by Timur Begishev on 07.02.2021.
//

import UIKit

class ViewController: UIViewController {

	
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var pressureLabel: UILabel!
	@IBOutlet weak var humidityLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var appearentTemperatureLabel: UILabel!
	@IBOutlet weak var refreshButton: UIButton!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let icon = WeatherIconManager.snow.image
		let weather = CurrentWeather(temperature: -15, appearentTemperature: -20, humidity: 40, pressure: 720, icon: icon)
		
		updateUIWith(current: weather)
	}
	
	func updateUIWith(current weather: CurrentWeather) {
		
		imageView.image = weather.icon
		temperatureLabel.text = weather.temperatureString
		appearentTemperatureLabel.text = weather.appearentTemperatureString
		pressureLabel.text = weather.pressureString
		humidityLabel.text = weather.humidityString
	}
	
	@IBAction func refreshTapped(_ sender: UIButton) {
	}

}



