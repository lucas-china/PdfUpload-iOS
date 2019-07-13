//
//  ViewController.swift
//  PdfUpload
//
//  Created by Lucas Santana Brito on 13/07/19.
//  Copyright © 2019 lsb. All rights reserved.
//

import UIKit
import MobileCoreServices
import SwiftSpinner

class ViewController: UIViewController {

    @IBAction func uploadPdf(_ sender: UIButton) {
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF), String(kUTTypeImage)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        present(importMenu, animated: true, completion: nil)
    }
    
}

extension ViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        if !Util.isConnectToInternet() {
            Util.createAlert(view: self, titulo: "Ops! :/", mensagem: "Porfavor, conecte-se a internet para fazer upload do PDF.")
        }
        
        if FileManager.default.fileExists(atPath: url.relativePath) {
            SwiftSpinner.show("Uploading PDF...", animated: true)
            do {
                guard let nomePDF = url.pathComponents.last else { return }
                let pdfData = try Data(contentsOf: url)
                NetworkPDF.uploadPDF(pdf: pdfData, nome: nomePDF) { (isSuccess) in
                    SwiftSpinner.hide()
                    if isSuccess {
                        Util.createAlert(view: self, titulo: "PDF enviado com sucesso.", mensagem: ":)")
                    } else {
                        Util.createAlert(view: self, titulo: "Ops! :/", mensagem: "Ocerreu um erro ao enviar o pdf. Porfavor, tente novamente.")
                    }
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
        
    func documentMenu(_ documentMenu: UIDocumentPickerViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overCurrentContext
        present(documentPicker, animated: true, completion: nil)
    }
        
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        /// Picker was cancelled! Duh 🤷🏻‍♀️
    }
}
