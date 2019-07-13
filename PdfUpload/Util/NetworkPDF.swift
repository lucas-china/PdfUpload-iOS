//
//  NetworkPDF.swift
//  PdfUpload
//
//  Created by Lucas Santana Brito on 13/07/19.
//  Copyright © 2019 lsb. All rights reserved.
//

import Foundation
import Alamofire

class NetworkPDF {
    
    static func uploadPDF(pdf: Data, nome: String, completed: @escaping (Bool) -> Void) {
        
        let url = "http://IP_SERVIDOR:3000/"
    
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(pdf, withName: "pdf", fileName: nome, mimeType:"application/pdf")
        },
            to: url,
            method: .post,
            headers: nil,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString { response in
                        if response.response?.statusCode == 200 {
                            completed(true)
                        } else {
                            completed(false)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    completed(false)
                }
            }
        )
        
    }
    
}
