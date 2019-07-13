//
//  Alert.swift
//  PdfUpload
//
//  Created by Lucas Santana Brito on 13/07/19.
//  Copyright © 2019 lsb. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Util {
    
    static func createAlert(view: UIViewController, titulo: String, mensagem: String) {
        
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        view.present(alert, animated: true)
    }
    
    static func isConnectToInternet() -> Bool {
        return Alamofire.NetworkReachabilityManager()?.isReachable ?? false
    }
    
}
