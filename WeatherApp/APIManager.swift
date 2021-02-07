//
//  APIManager.swift
//  WeatherApp
//
//  Created by Timur Begishev on 07.02.2021.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

protocol JSONDecodable {
	init?(JSON: [String: AnyObject])
}

protocol FinalURLPoint {
	var baseURL: URL { get }
	var path: String { get }
	var request: URLRequest { get }
}

enum APIResult<T> {
	case success(T)
	case failure(Error)
}

protocol APIManager {
	var sessionConfiguration: URLSessionConfiguration { get }
	var session: URLSession { get }
	
	func JSONTask(with request: URLRequest, completion: @escaping JSONCompletionHandler) -> JSONTask
	func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completion: @escaping (APIResult<T>) -> Void)
}

extension APIManager {
	func JSONTask(with request: URLRequest, completion: @escaping JSONCompletionHandler) -> JSONTask {
		let dataTask = session.dataTask(with: request) { (data, response, error) in
			guard let HTTPResponse = response as? HTTPURLResponse else {
				let userInfo = [
					NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
				]
				let error = NSError(domain: TBWANetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
				
				completion(nil, nil, error)
				return
			}
			
			if data == nil {
				if let error = error {
					completion(nil, HTTPResponse, error)
				}
			} else {
				switch HTTPResponse.statusCode {
				case 200:
					do {
						let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
						completion(json, HTTPResponse, error)
					} catch let error as NSError  {
						completion(nil, HTTPResponse, error)
						print(error.localizedDescription)
					}
				default:
					print("We have got response status: \(HTTPResponse.statusCode)")
				}
			}
		}
		return dataTask
	}
	
	func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completion: @escaping (APIResult<T>) -> Void) {
		let dataTask = JSONTask(with: request) { (json, response, error) in
			DispatchQueue.main.async {
				guard let json = json else {
					if let error = error {
						completion(.failure(error))
					}
					return
				}
				
				if let value = parse(json) {
					completion(.success(value))
				} else {
					let error = NSError(domain: TBWANetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
					completion(.failure(error))
				}
			}
		}
		dataTask.resume()
	}
}
