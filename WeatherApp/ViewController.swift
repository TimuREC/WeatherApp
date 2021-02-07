//
//  ViewController.swift
//  WeatherApp
//
//  Created by Timur Begishev on 07.02.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

	
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var pressureLabel: UILabel!
	@IBOutlet weak var humidityLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var appearentTemperatureLabel: UILabel!
	@IBOutlet weak var refreshButton: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	let locationManager = CLLocationManager()
	
	lazy var weatherManager = APIWeatherManager(apiKey: "2a6d8e376a69c1ae07d4a52dd0c2dfdc")
	var coordinates = Coordinates(latitude: 55.783659, longitude: 49.128216)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
		locationManager.requestWhenInUseAuthorization()
		
		
		getCurrentWeatherData()
	}
	
	func getCurrentWeatherData() {
		locationManager.requestLocation()
		weatherManager.fetchCurrentWeather(with: coordinates) { [weak self] (result) in
			guard let self = self else { return }
			self.toggleActivityIndicator(on: false)
			switch result {
			case .success(let currentWeather):
				self.updateUIWith(current: currentWeather)
			case .failure(let error as NSError):
				let alert = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
				let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
				alert.addAction(ok)
				self.present(alert, animated: true, completion: nil)
			}
		}
	}
	
	func toggleActivityIndicator(on: Bool) {
		refreshButton.isHidden = on
		
		if on {
			activityIndicator.startAnimating()
		} else {
			activityIndicator.stopAnimating()
		}
	}
	
	func updateUIWith(current weather: CurrentWeather) {
		imageView.image = weather.icon
		temperatureLabel.text = weather.temperatureString
		appearentTemperatureLabel.text = weather.appearentTemperatureString
		pressureLabel.text = weather.pressureString
		humidityLabel.text = weather.humidityString
	}
	
	@IBAction func refreshTapped(_ sender: UIButton) {
		toggleActivityIndicator(on: true)
		getCurrentWeatherData()
	}

}

extension ViewController: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation = locations.last! as CLLocation
		coordinates = Coordinates(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
		let geocoder = CLGeocoder()
		geocoder.cancelGeocode()
		geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
			if let error = error {
				print(error)
				return
			}
			
			guard let placemarks = placemarks,
				  let placemark = placemarks.first,
				  let country = placemark.country,
				  let city = placemark.locality
			else { return }
			DispatchQueue.main.async { [weak self] in
				self?.locationLabel.text = "\(city), \(country)"
			}
			
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error.localizedDescription)
	}
}



