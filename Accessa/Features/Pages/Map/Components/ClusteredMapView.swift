//
//  ClusteredMapView.swift
//  Accessa
//
//  Created by Tatarella on 22.01.26.
//

import MapKit
import SwiftUI

struct ClusteredMapView: UIViewRepresentable {

    let offers: [OfferMapItem]
    var onOfferTap: ((OfferMapItem) -> Void)? = nil

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        context.coordinator.mapView = map
        map.delegate = context.coordinator
        map.showsUserLocation = true
        map.userTrackingMode = .follow

        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "offerPin")
        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "cluster")

        return map
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {

        let currentIDs = offers.map { $0.id }
        if context.coordinator.lastOfferIDs == currentIDs { return}
        context.coordinator.lastOfferIDs = currentIDs

        let old = mapView.annotations.filter { !($0 is MKUserLocation) }
        mapView.removeAnnotations(old)

        let newAnnotations = offers.map { OfferAnnotation(offer: $0) }
        mapView.addAnnotations(newAnnotations)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onOfferTap: onOfferTap)
    }

    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {

        weak var mapView: MKMapView?
        private let locationManager = CLLocationManager()
        private let onOfferTap: ((OfferMapItem) -> Void)?

        private var didCenterOnUser = false
        var lastOfferIDs: [Int] = []

        init(onOfferTap: ((OfferMapItem) -> Void)?) {
            self.onOfferTap = onOfferTap
            super.init()

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            print("Requesting location permission")
            locationManager.requestWhenInUseAuthorization()
        }

        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                mapView?.showsUserLocation = true
                mapView?.userTrackingMode = .follow
                manager.startUpdatingLocation()

            case .denied, .restricted:
                mapView?.showsUserLocation = false

            case .notDetermined:
                manager.requestWhenInUseAuthorization()

            @unknown default:
                break
            }
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            guard didCenterOnUser == false else { return }

            didCenterOnUser = true

            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )

            mapView?.setRegion(region, animated: true)
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation { return nil }
            
            if let cluster = annotation as? MKClusterAnnotation {
                let identifier = "cluster"
                guard let view = mapView.dequeueReusableAnnotationView(
                    withIdentifier: identifier,
                    for: cluster
                ) as? MKMarkerAnnotationView else {
                    return nil
                }

                view.annotation = cluster
                view.canShowCallout = false
                view.markerTintColor = .colorSecondary
                view.glyphImage = nil
                view.glyphText = "\(cluster.memberAnnotations.count)"
                return view
            }

            guard let offerAnn = annotation as? OfferAnnotation else { return nil }
            let identifier = "offerPin"
            guard let view = mapView.dequeueReusableAnnotationView(
                withIdentifier: identifier,
                for: offerAnn
            ) as? MKMarkerAnnotationView else {
                return nil
            }

            view.annotation = offerAnn
            view.canShowCallout = true
            view.markerTintColor = .colorPrimary
            view.glyphImage = nil
            view.glyphText = offerAnn.discountText
            view.clusteringIdentifier = "offers"
            return view
        }


        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation as? OfferAnnotation {
                onOfferTap?(annotation.offer)
            }
        }

    }

}
