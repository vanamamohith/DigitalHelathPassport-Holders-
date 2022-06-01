//
//  EachFileQRViewController.swift
//  SignupAndLogin
//
//  Created by student on 5/27/22.
//

import UIKit

class EachFileQRViewController: UIViewController {
    
    var txId: String? = ""
    var LatesttxId: String? = ""
    //********************************
    //retreve data from signup
    var fname : String?
    var lname : String?
    var dob : String?
    var phNum : String?
    var passNum : String?
    var issuedCountry : String?
    var mailId : String?
    var dhpID : String?
    //*********************************
    var user: User? = nil
    var txs: [Transaction] = []
    var tokee: String = ""
    var tx: Transaction? = nil
    var othtestlist: [Transaction] = []
    
    @IBOutlet weak var imgQR: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let myString = txId
        {
        let data = myString.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter (name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "InputMessage")
        let cilmage = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage = cilmage?.transformed(by: transform)
            let im = UIImage(ciImage: transformImage!)
            imgQR.image = im
            

        }
    }
    
    @IBAction func backToFile(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "viewC") as! ReportViewController
        controller.tx = tx
        controller.dhpID = dhpID
        controller.token = tokee
        controller.txs = txs
        controller.user = user
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.LatesttxId = LatesttxId
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
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


}
