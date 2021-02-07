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
		// Do any additional setup after loading the view.
	}
	
	@IBAction func refreshTapped(_ sender: UIButton) {
	}

}

