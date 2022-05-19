//
//  PDFViewController.swift
//  SignupAndLogin
//
//  Created by student on 4/21/22.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var pdfview = PDFView()
    var pfdfURL : URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(pdfview)
        
        if let document = PDFDocument(url: pfdfURL){
            pdfview.document = document
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:{
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    override func viewDidLayoutSubviews() {
        pdfview.frame = self.view.frame
    }
    

}
