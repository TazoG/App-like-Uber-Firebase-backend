//
//  HomeController.swift
//  App-like-Uber-Firebase-backend
//
//  Created by Tazo Gigitashvili on 17.04.23.
//

import UIKit
import FirebaseAuth
import MapKit

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    private let mapView = MKMapView()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
       
        checkIfUserIsLoggedIn()
//        signOut()
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configureUI()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Error signing out")
        }
    }
    
    //MARK: - #Selectors
    
    //MARK: - UI
    
    func configureUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
}

