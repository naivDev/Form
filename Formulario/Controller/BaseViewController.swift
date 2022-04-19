//
//  BaseViewController.swift
//  Formulario
//
//  Created by Oscar Ivan Pérez Salazar on 21/01/22.
//

import UIKit

class BaseViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            dismissTapKeyboard()
            disableDarkMode()
            
        }
        //Ocultar Teclado al tocar en cualquier lugar de pantalla
        func dismissTapKeyboard() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        //Inhabilitar modo oscuro
        func disableDarkMode() {
            overrideUserInterfaceStyle = .light
        }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
}
