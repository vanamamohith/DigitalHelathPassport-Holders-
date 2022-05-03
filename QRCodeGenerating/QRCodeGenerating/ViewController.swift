//
//  ViewController.swift
//  QRCodeGenerating
//
//  Created by student on 3/31/22.
//

import UIKit

class ViewController: UIViewController {
    
    var text1 = " "
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if text1 != " " {
            imgView.image = generateQRCode(from: text1)
        }
        else{
            imgView.image = generateQRCode(from: "Let learn")
        }
        
        
    }
    
    
    func generateQRCode(from string:String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    
    @IBAction func clicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! FirstViewController
        //controller.text1 = "Hello"
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
    }
    
    


}

