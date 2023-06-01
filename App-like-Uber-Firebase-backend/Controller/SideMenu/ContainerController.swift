//
//  ContainerController.swift
//  App-like-Uber-Firebase-backend
//
//  Created by Tazo Gigitashvili on 27.05.23.
//

import UIKit
import Firebase

class ContainerController: UIViewController {
    
    //MARK: - Properties
    
    private let homeController = HomeController()
    private var menuController: MenuController!
    private var isExpanded = false
    private let blackView = UIView()
    private lazy var xOrigin = self.view.frame.width - 80
    
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            print("TAZO: User home locations is \(user.homeLocation)")
            homeController.user = user
            configureMenuController(withUser: user)
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    //MARK: - @objc Selectors
    
    @objc func dismissMenu() {
        isExpanded = false
        animateMenu(shouldExpand: isExpanded)
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
            configure()
        }
    }
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { user in
            self.user = user
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } catch {
            print("TAZO: Error signing out")
        }
    }
    
    //MARK: - UI
    
    func configure() {
        view.backgroundColor = .backgroundColor
        configureHomeController()
        fetchUserData()
    }
    
    func configureHomeController() {
        addChild(homeController)
        homeController.didMove(toParent: self)
        view.addSubview(homeController.view)
        homeController.delegate = self
    }
    
    func configureMenuController(withUser user: User) {
        menuController = MenuController(user: user)
        addChild(menuController)
        menuController.didMove(toParent: self)
        menuController.view.frame = self.view.bounds
        view.insertSubview(menuController.view, at: 0)
        menuController.delegate = self
        configureBlackView()
    }
    
    func configureBlackView() {
        blackView.frame = CGRect(x: xOrigin, y: 0, width: 80, height: self.view.frame.height)
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.alpha = 0
        view.addSubview(blackView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        blackView.addGestureRecognizer(tap)
    }
    
    func animateMenu(shouldExpand: Bool, completion: ((Bool) -> Void)? = nil) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.homeController.view.frame.origin.x = self.xOrigin
                self.blackView.alpha = 1
            }
        } else {
            self.blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.homeController.view.frame.origin.x = 0
            }, completion: completion)
        }
        
        animateStatusBar()
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension ContainerController: SettingsControllerDelegate {
    func updateUser(_ controller: SettingsController) {
        self.user = controller.user
    }
}

//MARK: - HomeControllerDelegate

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle() {
        isExpanded.toggle()
        animateMenu(shouldExpand: isExpanded)
    }
}

//MARK: - MenuControllerDelegate

extension ContainerController: MenuControllerDelegate {
    func didSelect(option: MenuOptions) {
        isExpanded.toggle()
        animateMenu(shouldExpand: isExpanded) { _ in
            switch option {
            case .yourTrips:
                break
            case .settings:
                guard let user = self.user else { return }
                let controller = SettingsController(user: user)
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            case .logout:
                let alert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
                    self.signOut()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
}

