//
//  ShowLoaderJGProgressHUD.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 5/16/22.
//

import JGProgressHUD
import UIKit

extension UIViewController {
    
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool, withText text: String? = "Loading") {
      
        view.endEditing(true)
        let hud = JGProgressHUD(style: .extraLight)
        hud.textLabel.text = text

        if show == true {
            UIViewController.hud.show(in: view)
        } else if show == false {
            
            UIViewController.hud.dismiss()
        }
    }
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.accentColor.cgColor, UIColor.white.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
    }
    func alertUserErrorMessage(message: String) {
        let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
            self.showLoader(false)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func configureNavigationBar(withTitle title: String, prefersLargTitles: Bool) {
      
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes =  [.foregroundColor : UIColor.white]
        appearance.backgroundColor = .accentColor 
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = prefersLargTitles 
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.isTranslucent = true
        
       // navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        
    }
}
