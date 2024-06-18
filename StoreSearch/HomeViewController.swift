//
//  HomeViewController.swift
//  StoreSearch
//
//  Created by cmStudent on 2024/6/16.
//

import UIKit

import Alamofire
import Foundation
import MapKit
import CoreLocation

class HomeViewController: BaseViewController,XMLParserDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate {
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var location: CLLocation!
    var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.creatHeadeViewString("", andHaveLeft: false, andHaveright: false)
        
        mapView = MKMapView()
        
        mapView.delegate = self
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // map追加
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
        searchButton = UIButton(type: .system)
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 10
        searchButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(44)
            
            let button = UIButton.init(frame: CGRectZero)
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            button.backgroundColor = .clear
            self.base_topView.addSubview(button)
            button.snp.makeConstraints { make in
                make.edges.equalTo(self.searchButton)
            }
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    @objc func buttonAction(_ sender : UIButton)
    {
        let vc = SearchViewController()
        vc.mylocation = self.location
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true //　今の位置情報
        }
        
    }
    //位置情報の更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            self.location = location
            locationManager.stopUpdatingLocation()
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
}
