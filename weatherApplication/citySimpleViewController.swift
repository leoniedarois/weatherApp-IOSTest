//
//  citySimpleViewViewController.swift
//  weatherApplication
//
//  Created by Léo on 11/06/2019.
//  Copyright © 2019 Léonie Grimoin. All rights reserved.
//

import UIKit

class citySimpleViewController: UIViewController {

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var background: UIView!
    var selectedCity:CityData = CityData(title: "Paris")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // api call openweathermap
        let q = selectedCity.title
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q="+q+"&units=metric&appid=55c9abe4a99520aec545290b0b43d1be") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return }
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any] else { return }
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)?.capitalizingFirstLetter()
                    let city = (json["name"] as? String)?.capitalizingFirstLetter()
                    DispatchQueue.main.async {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp, city: city)
                    }
                } catch {
                    print("Erreur")
                }
            }
        }
        task.resume()
    }
    
    // filling labels and choosing icons, colors
    func setWeather(weather: String?, description: String?, temp: Int, city: String?) {
            cityName.text = city ?? ""
            descriptionLabel.text = description ?? "..."
            tempLabel.text = "\(temp) C°"
            switch weather {
            case "Sunny":
                iconView.image = UIImage(named: "sunny")
                background.backgroundColor = UIColor(red: 0.97, green: 0.78, blue: 0.35, alpha: 1.0)
            case "Snow":
                iconView.image = UIImage(named: "Snow")
                background.backgroundColor = UIColor(red: 0.76, green: 0.93, blue: 0.98, alpha: 1.0)
            case "Rain":
                iconView.image = UIImage(named: "rain")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "Drizzle":
                iconView.image = UIImage(named: "rain")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "Clouds":
                iconView.image = UIImage(named: "cloudy")
                background.backgroundColor = UIColor(red: 0.76, green: 0.93, blue: 0.98, alpha: 1.0)
            default:
                iconView.image = UIImage(named: "cloudy")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            }
    }
}

// allows to have the first letter capitalized
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
