//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Philip on 9/15/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var alertsLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionRadius = 30.0
    
    var friends: [Friend] = []
    var monitoredRegions: Dictionary<String, NSDate> = [:]
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let alertController = UIAlertController(title: "Disclaimer", message:
            "Welcome", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default,handler: nil))
        
        // 1. status is not determined
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .Denied {
            locationManager.requestAlwaysAuthorization()
        }
            // 3. we do have authorization
        else if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // locationManage setup:
        locationManager.delegate = self;
        locationManager.distanceFilter = 5;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.pausesLocationUpdatesAutomatically = false
        
        // mapView setup:
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
        
        // Center on user:
        let userLocation:CLLocation = locationManager.location! as CLLocation
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion (center: location,span: span)
        mapView.setRegion(region, animated: true)
        
        // Add friends to map:
        let friend = Friend(title: "Philip Vo", locationName: "Coding Dojo's Parking Lot",
                            coordinate: CLLocationCoordinate2D(latitude: 37.375196, longitude: -121.910414))
        friends.append(friend)
        
        setupData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

