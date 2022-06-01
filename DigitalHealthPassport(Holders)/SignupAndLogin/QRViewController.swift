//
//  QRViewController.swift
//  SignupAndLogin
//
//  Created by student on 4/14/22.
//

import UIKit

class QRViewController: UIViewController {
    
    var txId: String? = ""
    var LatesttxId: String? = ""
    var text1 =  " "
    var isClicked = true
    var othtestlist: [Transaction] = []
    
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
    var testlist: [Transaction] = []
    
    @IBOutlet weak var sideViewConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var personConstarint: NSLayoutConstraint!
    
    
    @IBOutlet weak var welcomeOutlet: UILabel!
    
    
    @IBOutlet weak var QRImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeOutlet.text = "DHP ID: \(dhpID!)"
        
        sideViewConstraint.constant = -240
        
        personConstarint.constant = 210

        if let myString = LatesttxId
        {
        let data = myString.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter (name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "InputMessage")
        let cilmage = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage = cilmage?.transformed(by: transform)
            let im = UIImage(ciImage: transformImage!)
            QRImg.image = im
            

        }
    }
    
    
    @IBAction func homeClicked(_ sender: UIButton) {
        HomeViewController.count = HomeViewController.count + 1
        let controller = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum

        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.tokee = tokee
        controller.user = user
        controller.txId = txId
        controller.LatesttxId = LatesttxId
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
        
        HomeViewController.isCovidTest = 1
        if(CovidReportSearchViewController.testlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Covid test Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.othtestlist = othtestlist
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.txId = self.txId
        controller.user = self.user
        controller.LatesttxId = LatesttxId
        controller.tokee = tokee
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
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
    
    @IBAction func vaccineClicked(_ sender: Any) {
        HomeViewController.isCovidTest = 2
        HomeViewController.vaccineCount = HomeViewController.vaccineCount + 1
        if(HomeViewController.vaccinelist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Covid Vaccination Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else
        {
        let controller = storyboard?.instantiateViewController(withIdentifier: "viewC") as! ReportViewController

        controller.othtestlist = othtestlist
        controller.user = user
        controller.token  = tokee
        controller.dhpID = dhpID
        controller.txs = txs
        controller.tokee = tokee
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.LatesttxId = LatesttxId
        controller.tx = HomeViewController.vaccinelist[HomeViewController.vaccinelist.count-1]
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func otherVaccinationClicked(_ sender: Any) {
        HomeViewController.isCovidTest = 3
        if(HomeViewController.othtestlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Other Vaccination Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else
        {
        let controller = storyboard?.instantiateViewController(withIdentifier: "other") as! OtherVaccinationViewController
        controller.othtestlist = othtestlist
        controller.user = user
        controller.tokee  = tokee
        controller.dhpID = dhpID
        controller.txs = txs
        controller.token = tokee
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        //controller.tx = HomeViewController.vaccinelist[HomeViewController.vaccinelist.count-1]
        controller.LatesttxId = LatesttxId
        controller.txId = txId
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
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
        controller.txId = self.txId
        controller.user = self.user
        controller.LatesttxId = LatesttxId
        controller.tokee = tokee
        controller.othtestlist = othtestlist
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func signOutClicked(_ sender: UIButton) {
        sideViewConstraint.constant = -240
        HomeViewController.count = 0
        HomeViewController.otherCount = 0
        HomeViewController.vaccineCount = 0
        CovidReportSearchViewController.covidCount = 0
        HomeViewController.othtestlist.removeAll()
        HomeViewController.vaccinelist.removeAll()
        HomeViewController.qrlist.removeAll()
        CovidReportSearchViewController.testlist.removeAll()
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    
    
    

}
