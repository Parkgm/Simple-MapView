//
//  ViewController.swift
//  Simple MapView
//
//  Created by D7703_11 on 2018. 6. 5..
//  Copyright © 2018년 gyuminpark. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    var foodStoreNames = ["늘해랑","번개반점","아딸","왕짜장","토마토도시락","홍콩반점"]
    var foodStoreAddress = ["부산광역시 부산진구 양정2동 336-17",
                            "부산광역시 부산진구 양정동 418-282",
                            "부산광역시 부산진구 양정동 393-18",
                            "부산광역시 부산진구 양정1동 356-22",
                            "부산광역시 부산진구 양정1동 350-1",
                            "부산광역시 부산진구 양정동 353-38"]
    var foodStoreTel = ["051-1111-1234",
                        "051-2222-1234",
                        "051-3333-1234",
                        "051-4444-1234",
                        "051-5555-1234",
                        "051-6666-1234"]
    var count = 0
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 초기화면에서 mapkit api 적용 시켜야함
        
        
        
        // 번개반점
        // 35.1675767, 129.0683719
        // 부산광역시 부산진구 양정동 418-282
        
        // 동의과학대학교
        // 35.1657753, 129.0703383
        // 부산광역시 부산진구 양정동 양지로 54
        
        // 지도 center, span ,region 표시하기
        // 위도,경도
        
     
        // 번개반점
        let loc01 = CLLocationCoordinate2D(latitude: 35.1675767, longitude: 129.0683719)
        
        // 동의과학대학교
        let center = CLLocationCoordinate2D(latitude: 35.1657753, longitude: 129.0703383)
        
        
        // 반경(zoom in, out)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        
        // region 객체(center,span)
        let region = MKCoordinateRegion(center: center, span: span)
        
        // 지도에 표시하기
        myMapView.setRegion(region, animated: true)
        
        // annotation 표시하기
        let pin01 = MKPointAnnotation()
        pin01.coordinate = loc01
        pin01.title = "번개반점"
        pin01.subtitle = "부산광역시 부산진구 양정동 418-282"
        myMapView.addAnnotation(pin01)
        
        let pin02 = MKPointAnnotation()
        pin02.coordinate = center
        pin02.title = "동의과학대학교"
        pin02.subtitle = "부산광역시 부산진구 양정동 양지로 54"
        myMapView.addAnnotation(pin02)
        
        // geocoding : 주소 -> 위도,경도
        // 주소를 가져와서 위도 경도를 계산해서 뿌려주는 형식
//        let addr = "부산광역시 부산진구 양정1동 350-1"
//        let geocoder = CLGeocoder()
//
//        geocoder.geocodeAddressString(addr) {
//
//            //후행 클로져 형식
//            (placemarks: [CLPlacemark]?, error:Error?) -> Void in
//            if let error = error {
//                print(error)
//                return
//            } else {
//                print("nil 발생")
//            }
//
//            if let placemarks = placemarks {
//                let placemark = placemarks[0]
//
//                let loc02 = placemark.location?.coordinate
//                let pin03 = MKPointAnnotation()
//                pin03.coordinate = loc02!
//                pin03.title = "토마토 도시락"
//                pin03.subtitle = addr
//                self.myMapView.addAnnotation(pin03)
//
//            } else {
//                print("nil 발생")
//            }
//        }
        
        for addr in foodStoreAddress {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addr) {
                (placemarks: [CLPlacemark]?, error: Error?) -> Void in
                    if let myError = error {
                        print(myError)
                        return
                    }
                    
                    let myPlacemark = placemarks![0]
//                    print(myPlacemark.location?.coordinate)
                    let loc = myPlacemark.location?.coordinate
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = loc!
                    annotation.title = self.foodStoreNames[self.count]
                    annotation.subtitle = self.foodStoreTel[self.count]
                    self.count = self.count + 1
                self.annotations.append(annotation)

                print(self.annotations)
                
                self.myMapView.addAnnotations(self.annotations)
                
//                self.myMapView.addAnnotation(annotation)
                
                
                
            }
        }
    }
}

