//
//  MapViewController.swift
//  Yummy
//
//  Created by hamdi on 04/04/2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    static var region :MKCoordinateRegion?
    var areaName = ""
    var currentCoordinate :CLLocationCoordinate2D?
    @IBOutlet weak var mapView: MKMapView!
    var setLocationButton  = UIButton()
    let intiallcoation = CLLocation(latitude: 30.7936, longitude: 31.0047)
    let intialDistance :CLLocationDistance = 3000
    var locationButtonView: UIView!
    var locationButton: UIButton!
    var cliked = true
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor =   #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
        navigationItem.backButtonTitle = ""
        SetStartingLocation(location: intiallcoation, distance: intialDistance)
        mapView.delegate = self
        creatCurrentLocationButton()
        creatChangeMapTypeButton()
        let buttonWidth = view.frame.width
        setLocationButton = UIButton(frame: CGRect(x: 20, y: view.frame.size.height - 100, width: buttonWidth - 40, height: 50))
        setLocationButton.setTitle("Set Location", for: .normal)
        setLocationButton.setTitleColor(.white, for: .normal)
        setLocationButton.backgroundColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
        setLocationButton.layer.cornerRadius = 10
        setLocationButton.addTarget(self, action: #selector(btnSetLocationAction), for: .touchUpInside)
        
        view.addSubview(setLocationButton)
   
        }
    @objc func btnSetLocationAction (){
        //check location in visable
        var cheakarea =  CheckSelectedLocation()
        //pass data & navigate
        if cheakarea{
            let controller = AdressDataViewController.instantiate(storyBord: "HomeUI")
            MapViewController.region = MKCoordinateRegion(center: currentCoordinate ?? intiallcoation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            controller.areaName = areaName
            navigationController?.pushViewController(controller, animated: true)
        }else{
            
            callAlert()
        }
    }
    func callAlert(){
        let alertController = UIAlertController(title: "Unavailable", message: "Sorry, Yummy can't deliver to your location at this time.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            // Handle OK button action
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)

    }
    
    func creatChangeMapTypeButton(){
        let buttonSize: CGFloat = 25
        let buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        locationButtonView = UIView(frame: CGRect(x: view.frame.size.width - buttonSize - 20, y: view.frame.size.height - 140, width: buttonSize + 10, height: buttonSize + 10))
        locationButtonView.layer.cornerRadius = (buttonSize + 10) / 2
        locationButtonView.backgroundColor = .white
        locationButtonView.clipsToBounds = true
        locationButton = UIButton(frame: buttonFrame)
        locationButton.center = CGPoint(x: locationButtonView.bounds.width / 2, y: locationButtonView.bounds.height / 2)
        locationButton.setImage(UIImage(named: "map1")!, for: .normal) // Set the image of the button
        locationButton.addTarget(self, action: #selector(changeMapType), for: .touchUpInside) // Add a target to the button
        locationButtonView.addSubview(locationButton)
        view.addSubview(locationButtonView)
    }
    @objc func changeMapType (){
        
        if cliked {
            mapView.mapType = .hybrid
            locationButton.setImage(UIImage(named: "map2")!, for: .normal)
            cliked = !cliked
        }else{
            mapView.mapType = .standard
            locationButton.setImage(UIImage(named: "map1")!, for: .normal)
            cliked = !cliked
        }
    }
    func creatCurrentLocationButton (){
        let buttonSize: CGFloat = 25
        let buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        locationButtonView = UIView(frame: CGRect(x: view.frame.size.width - buttonSize - 20, y: view.frame.size.height - 200, width: buttonSize + 10, height: buttonSize + 10))
        locationButtonView.layer.cornerRadius = (buttonSize + 10) / 2
        locationButtonView.backgroundColor = .white
        locationButtonView.clipsToBounds = true
        locationButton = UIButton(frame: buttonFrame)
        locationButton.center = CGPoint(x: locationButtonView.bounds.width / 2, y: locationButtonView.bounds.height / 2)
        locationButton.setImage(UIImage(named: "Crrentlocation")!, for: .normal) // Set the image of the button
        locationButton.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside) // Add a target to the button
        locationButtonView.addSubview(locationButton)
        view.addSubview(locationButtonView)
    }
    
    @objc func getCurrentLocation() {
        if let userLocation = mapView.userLocation.location {
            let regionRadius: CLLocationDistance = 1000
            let coordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    func SetStartingLocation(location :CLLocation,distance:CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    
}
extension MapViewController :MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        setLocationButton.isHidden = true
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        setLocationButton.isHidden = false
        currentCoordinate = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude).coordinate
        getLocation(location:CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude) )
        
    }
    func getLocation(location :CLLocation){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { places, error in
            guard let place = places?.first,error == nil else {return}
            if let  name = place.name {
                self.areaName = name
            }
        }
    }
    func CheckSelectedLocation()->Bool{
        let tantaLocation = CLLocationCoordinate2D(latitude: 30.7936, longitude: 31.0047)
        let tantaRegion = CLCircularRegion(center: tantaLocation, radius: 20000, identifier: "Tanta") // Set a circular region around Tanta
        let visibleRegion = MKCoordinateRegion(center: mapView.centerCoordinate, span: mapView.region.span)
        let visibleLocation = CLLocation(latitude: visibleRegion.center.latitude, longitude: visibleRegion.center.longitude)
        
        if tantaRegion.contains(visibleLocation.coordinate) {
            return true // User selected a location within Tanta
        } else {
            return false // User selected a location outside of Tanta
        }
    }
    
}

