//
//  QRViewController.swift
//  SignupAndLogin
//
//  Created by student on 4/14/22.
//

import UIKit

class QRViewController: UIViewController {
    
    var text1 =  " "
    var isClicked = true
    
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
    
    @IBOutlet weak var sideViewConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var personConstarint: NSLayoutConstraint!
    
    
    @IBOutlet weak var welcomeOutlet: UILabel!
    
    
    @IBOutlet weak var QRImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeOutlet.text = "\(dhpID!)"
        
        sideViewConstraint.constant = -240
        
        personConstarint.constant = 210

        if text1 != " " {
            QRImg.image = generateQRCode(from: text1)
        }
        else{
            QRImg.image = generateQRCode(from: "Let learn")
        }
    }
    
    
    @IBAction func homeClicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func QRButtonClicked(_ sender: UIButton) {
        isClicked = !isClicked
        if isClicked
        {
            sideViewConstraint.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideViewConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func covidReportClicked(_ sender: UIButton) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
        //controller.links = self.links
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
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
    
    
    @IBAction func sideBarClicked(_ sender: UIButton) {
        
        if(sClicked == false)
        {
            personConstarint.constant = 210
        }
        
        isClicked = !isClicked
        if isClicked
        {
            sideViewConstraint.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideViewConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    var sClicked = true
    
    @IBAction func personClicked(_ sender: UIButton) {
        
        if(isClicked == false)
        {
            sideViewConstraint.constant = -240
        }
        
        sClicked = !sClicked
        if sClicked
        {
            personConstarint.constant = 210
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            personConstarint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @IBAction func personInfoClicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PersonalInfo") as! PersonalInfoViewController
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func changePassClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "changePassword") as! ChangePasswordViewController
        
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func signOutClicked(_ sender: UIButton) {
        sideViewConstraint.constant = -240
        
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    
    
    

}
