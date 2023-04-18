//
//  LocationInputView.swift
//  App-like-Uber-Firebase-backend
//
//  Created by Tazo Gigitashvili on 18.04.23.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject {
    func dismissLocationInputView()
}

class LocationInputView: UIView {

    //MARK: - Properties
    
    weak var delegate: LocationInputViewDelegate?
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addShadow()
        
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor,paddingTop: 44, paddingLeft: 12, width: 24, height: 25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - #Selectors
    
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
}