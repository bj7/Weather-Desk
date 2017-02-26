//
//  ViewController.swift
//  Weather Desk
//
//  Created by Joshua Bernitt on 1/1/17.
//  Copyright © 2017 Joshua Bernitt. All rights reserved.
//

import Cocoa
import CoreLocation

class ViewController: NSViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager();
    let secretKey = SecretKey().key;

    @IBOutlet weak var CurrentTemp: NSTextFieldCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self;
        locationManager.startUpdatingLocation();
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation();
        print("Found location: \(locations.first)");
        getWeather(location: manager.location);
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find location: \(error.localizedDescription)");
    }
    
    func getWeather(location: CLLocation!) -> Bool {
        let url = NSURL(string: "https://api.darksky.net/forecast/\(self.secretKey)/\(location.coordinate.latitude),\(location.coordinate.longitude)");
        print("\(url!)");
        
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, resp, err) in
            let rawString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String;
            let json = try? JSONSerialization.jsonObject(with: data!, options: []);
//            print(json!);
            let dictionary = json as? [String: Any];
            let temp = dictionary?["currently"] as? [String: Any];
            print((temp?["apparentTemperature"])!);
            let tempStr = (temp?["apparentTemperature"])! as? NSNumber;
            /*
             * Simply updating the textView in this asynchronous task will not update the UI appropriately.
             * Must pass update to main thread
             */
//            self.rawJSON.string = rawString;
            DispatchQueue.main.async {
                self.CurrentTemp.stringValue = "\(tempStr!)";
            }
        }
        task.resume();
        
        return true;
    }
}

