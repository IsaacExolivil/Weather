//
//  ViewController.swift
//  WeatherIsaac
//
//  Created by Isaac Loez on 08/12/21.
//


import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
   
    @IBAction func searchPress(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
       
        return true
    }
    // func get the weather you city
    func textFieldDidEndEditing(_ textField: UITextField) {
        //we add all kinds of characters
        if let city = searchTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            weatherManager.fetchWeather(cityName: city)
        } else {
        searchTextField.text = ""
        }
    }
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.idLabel.text = String(weather.id)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}



