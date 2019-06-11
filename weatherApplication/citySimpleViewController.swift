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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let url = URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=London&appid=55c9abe4a99520aec545290b0b43d1be") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return }
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any] else { return }
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)?.capitalizingFirstLetter()
                    DispatchQueue.main.async {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp)
                    }
                } catch {
                    print("We had an error retriving the weather...")
                }
            }
        }
        task.resume()
    }
    
        func setWeather(weather: String?, description: String?, temp: Int) {
            descriptionLabel.text = description ?? "..."
            tempLabel.text = "\(temp)°"
            switch weather {
            case "Sunny":
                iconView.image = UIImage(named: "sunny")
                background.backgroundColor = UIColor(red: 0.97, green: 0.78, blue: 0.35, alpha: 1.0)
            case "Snow":
                iconView.image = UIImage(named: "Snow")
                background.backgroundColor = UIColor(red: 0.76, green: 0.93, blue: 0.98, alpha: 1.0)
            case "Rain":
                iconView.image = UIImage(named: "rain")
                background.backgroundColor = UIColor(red: 0.97, green: 0.78, blue: 0.35, alpha: 1.0)
            case "Drizzle":
                iconView.image = UIImage(named: "rain")
                background.backgroundColor = UIColor(red: 0.88, green: 0.90, blue: 0.91, alpha: 1.0)
            default:
                iconView.image = UIImage(named: "cloudy")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            }
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
