//
//  FirstViewController.swift
//  QRCodeGenerating
//
//  Created by student on 4/13/22.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func QRCodeClicked(_ sender: UIButton) {
        
//        let storyboard = UIStoryboard(name : "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "QR")
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true)
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "QR") as! ViewController
        controller.text1 = "Hello"
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
    }
    
    


}
