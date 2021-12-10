//
//  ViewController.swift
//  WeatherIsaac
//
//  Created by Isaac Loez on 08/12/21.
//


import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        weatherManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
      
        searchTextField.delegate = self
    }
   
    @IBAction func locationPres(_ sender: UIButton) {
        locationManager.requestLocation()
        
        
    }
    
   
    
}
//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
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
    }



//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
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

//MARK: - CLLocation
extension WeatherViewController: CLLocationManagerDelegate {
  
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            if let location = locations.last {
                locationManager.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                print(lat)
                print(lon)
                weatherManager.fecthWeather(latitude: lat, longitude: lon)
            }

        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print("error:: \(error.localizedDescription)")
        }
    
}



