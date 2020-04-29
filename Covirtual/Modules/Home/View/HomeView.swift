//
//  HomeView.swift
//  Covirtual
//
//  Created by Bona Deny S on 09/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeView: UIViewController {
    var viewModel: HomeViewModelProtocol?
    var provinces: [String] = []
    
    @IBOutlet weak var Greetings: UILabel!
    @IBOutlet weak var Wish: UILabel!
    @IBOutlet weak var LocationAndTemperature: UILabel!
    @IBOutlet weak var Weather: UIImageView!
    
    @IBOutlet weak var Provinces: UIPickerView!
    @IBOutlet weak var SelectedLocation: UILabel!
    @IBOutlet weak var LastUpdate: UILabel!
    
    @IBOutlet weak var DeadCounter: UILabel!
    @IBOutlet weak var PositiveCounter: UILabel!
    @IBOutlet weak var CureCounter: UILabel!
    
    @IBOutlet weak var EmbededMap: RoundView!
    @IBOutlet weak var MapView: MKMapView!
    var locationManager:CLLocationManager!
    var currentLocationStr = "Current location"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            determineCurrentLocation()
    }

}

// MARK: - View setup
extension HomeView {
    func setupView() {
        guard let viewModel = viewModel else {
            return
        }
        title = viewModel.title
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        Provinces.dataSource = self
        Provinces.delegate = self
        
        viewModel.provinces { (provinces) in
            DispatchQueue.main.async {
                self.provinces = provinces
                self.Provinces.reloadAllComponents()
                self.Provinces.selectRow(7, inComponent:0, animated:true)
                self.LastUpdate.text = viewModel.timeUpdate()
            }
        }
        viewModel.province(province: ["name":"Indonesia"], completion: { (data) in
            DispatchQueue.main.async {
                self.DeadCounter.text = data.attributes.kasusMeni.description
                self.PositiveCounter.text = data.attributes.kasusPosi.description
                self.CureCounter.text = data.attributes.kasusSemb.description
                self.SelectedLocation.text = "Update Kasus Korona Indonesia"
            }
        })
    }
}

// MARK: - Creating UIPicker
extension HomeView: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.subviews.forEach({
            $0.isHidden = $0.frame.height < 1.0
        })

        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return provinces.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;

        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()

            pickerLabel?.font = UIFont(name: "Montserrat", size: 14)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }

        pickerLabel?.text = provinces[row]

        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.province(province: ["name":provinces[row]], completion: { (data) in
            DispatchQueue.main.async {
                self.DeadCounter.text = data.attributes.kasusMeni.description
                self.PositiveCounter.text = data.attributes.kasusPosi.description
                self.CureCounter.text = data.attributes.kasusSemb.description
                self.SelectedLocation.text = "Update Kasus Korona \(self.provinces[row])"
            }
        })
    }
    
}

//MARK:- Create Location
extension HomeView: CLLocationManagerDelegate, MKMapViewDelegate {
    //MARK:- CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
        
        MapView.setRegion(mRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    
    //MARK:- Intance Methods
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()


        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            if let mPlacemark = placemarks{
                if let dict = mPlacemark[0].addressDictionary as? [String: Any]{
                    if let City = dict["City"] as? String{
                        if let State = dict["State"] as? String{
                            DispatchQueue.main.async {
                                self.LocationAndTemperature.text = City+", "+State+", 28°C"
                            }
                            self.locationManager.stopUpdatingLocation()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Creating instances
extension HomeView {
    static func create() -> HomeView {
        return HomeView(nibName: "HomeView", bundle: Bundle.main)
    }
}
