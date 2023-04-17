//
//  HomeController.swift
//  App-like-Uber-Firebase-backend
//
//  Created by Tazo Gigitashvili on 17.04.23.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

//        checkIfUserIsLoggedIn()
        signOut()
        checkIfUserIsLoggedIn()
        view.backgroundColor = .red
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
            print("DEBUG: User id is \(Auth.auth().currentUser?.uid)")
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
}

