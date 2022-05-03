//
//  HomeViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/18/22.
//

import UIKit

class HomeViewController: UIViewController{
    
    var str : String?
    var tokee : String?
    
    var links : [String] = []
    
    var vaccineLink : [String] = []
    
    
    var isClicked = true
    
    var sClicked = true
    
    @IBOutlet weak var welcomeOutlet: UILabel!
    
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
    
//    var scrollView: UIScrollView!
//    var mainView : UIView!
    
    @IBOutlet weak var sideViewControl: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        scrollView?.contentSize = (CGSize(width: mainView.frame.size.width, height: mainView.frame.size.height))
        welcomeOutlet.text = "\(dhpID!)"
        sideViewControl.constant = -240
        
        personIconConstraint.constant = 210
        
        
    }
    
    
    
    
    @IBOutlet weak var personIconConstraint: NSLayoutConstraint!
    
    
    
    @IBAction func iconClicked(_ sender: Any) {
        
        if(isClicked == false)
        {
            sideViewControl.constant = -240
        }
        
        sClicked = !sClicked
        if sClicked
        {
            personIconConstraint.constant = 210
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            personIconConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func personalInfoClicked(_ sender: Any) {
        
        sideViewControl.constant = -240
        
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
    
    
    @IBAction func changePasswordClicked(_ sender: Any) {
        
        sideViewControl.constant = -240
        
        
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
    
    
    
    @IBAction func singOutClicked(_ sender: Any) {
        
        sideViewControl.constant = -240
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)

    }
    
    
    @IBAction func homeButtonClicked(_ sender: UIButton) {
        
        
        isClicked = !isClicked
        if isClicked
        {
            sideViewControl.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideViewControl.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    @IBAction func QRCodeClicked(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
        controller.text1 = "https://dhp-server.herokuapp.com/api/verifier/transaction/2ccc86adf6130d3bcaa8a3425f67216a34087cc8fa51dd11ab461d74c2f418f3/625f61a70a93881dc1d88408"
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
    
    func qrcode(){
        
        
    }
    
    
    
    @IBAction func covidReportClicked(_ sender: UIButton) {
        
        postData()
        
        
    }
    
    
    
    
    
    
    @IBAction func navClicked(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name : "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "covidVaccination")
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true)
        
        
        if(sClicked == false)
        {
            personIconConstraint.constant = 210
        }
        
        isClicked = !isClicked
        if isClicked
        {
            sideViewControl.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideViewControl.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
  
    @IBAction func vaccinationButton(_ sender: Any) {
        postVaccinationData()
        //mohi()
        
    }
    
    
    var user: User? = nil
    var token: String = ""
    
    
    var txs: [Transactions] = []
    
    func postVaccinationData()
    {
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(str!)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee!)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transactions].self, from: data);
                DispatchQueue.main.async {
                    
                    
                    
                    
                    self.txs = decoded
                    print("**********")
                    var n = self.txs.count-1
                    print("Number ::::::",n)
                    for i  in 0...n{
                        print("***")
                        print(self.txs[i].transaction_id!,"  Created at :",self.txs[i].createdAt!,"Report Type:", self.txs[i].info?.report!)
                    }
                    print("**********")
                    
                    
                    self.mohi()
                    
//                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
//                    controller.links = self.links
//                    controller.fname = self.fname
//                    controller.lname = self.lname
//                    controller.dob = self.dob
//                    controller.passNum = self.passNum
//                    controller.issuedCountry = self.issuedCountry
//                    controller.phNum = self.phNum
//                    controller.mailId = self.mailId
//                    controller.dhpID = self.dhpID
//
//                    controller.modalPresentationStyle = .fullScreen
//                    self.present(controller, animated: true, completion: nil)
                    
                    
                    
                    
                }
               
            } catch let error {
                //print("Error in JSON parsing", error)
                print("*****")
                print("No Files Found")
            }
        }
        // 4) make an API call
        dataTask.resume()
    }
    func vdata()
    {
        let userid = user?._id ?? ""
        
        //links.append("")
        var n = txs.count-1
        
        
        for i in 0...n{
        let reqURL = "https://dhp-server.herokuapp.com/api/verifier/transaction/\(txs[i].transaction_id!)/\(txs[i].holder_id!)"
            
            if(txs[i].info?.report == "vaccination"){
            vaccineLink.append(reqURL)
                if(!vaccineLink.isEmpty)
                {
                 print("Hello: ",vaccineLink[i])
                }
            print("**********")
            }
            if(vaccineLink.isEmpty)
            {
                let uialert = UIAlertController( title: "", message: "No File Found", preferredStyle: UIAlertController.Style.alert)
                            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                            self.present(uialert, animated: true, completion: nil)
            }
            else{
            display()
            }
        }
    }
        func display()
        {
            let pdfview = PDFViewController()
            //pdfview.pfdfURL = self.pdfUrl
            pdfview.pfdfURL = URL(string: vaccineLink[vaccineLink.count-1])
            present(pdfview, animated: true, completion: nil)
        }
    
    func mohi(){
        var c = 0
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/verifier/transaction/\(txs[1].transaction_id!)/\(txs[1].holder_id!)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee!)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transactions].self, from: data);
                DispatchQueue.main.async {
                    let pdfview = PDFViewController()
                    //pdfview.pfdfURL = self.pdfUrl
                    pdfview.pfdfURL = URL(string: reqURL)
                    self.present(pdfview, animated: true, completion: nil)
                    
                    
                }
               
            } catch let error {
                //c = 1
                print("Error in JSON parsing", error)
                print("*****")
                print("No File Found in vaccination")
            }
            

        }
        // 4) make an API call
        dataTask.resume()
        
    }
    
    func postData() {
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(str!)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee!)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transactions].self, from: data);
                DispatchQueue.main.async {
                    self.txs = decoded
                    print("**********")
                    var n = self.txs.count-1
                    print("Number ::::::",n)
                    for i  in 0...n{
                        print("***")
                        print(self.txs[i].transaction_id!,"  Created at :",self.txs[i].createdAt!)
                        //print(self.txs[i].transaction_id!,"  Created at :",self.txs[i].createdAt!,"Report Type:", self.txs[i].info?.report!)
                    }
                    print("**********")
                    
                    
                    self.cdata()
                    
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
                    controller.links = self.links
                    controller.fname = self.fname
                    controller.lname = self.lname
                    controller.dob = self.dob
                    controller.passNum = self.passNum
                    controller.issuedCountry = self.issuedCountry
                    controller.phNum = self.phNum
                    controller.mailId = self.mailId
                    controller.dhpID = self.dhpID
                    controller.tokee = self.tokee
                    controller.str = self.str
                    controller.txs = self.txs
                    controller.linksDisplay = self.linksDisplay

                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                    
                    
                    
                    
                }
               
            } catch let error {
                //print("Error in JSON parsing", error)
                print("*****")
                print("No File Found")
            }
        }
        // 4) make an API call
        dataTask.resume()
    }
    var linksDisplay : [String] = []
    
    func cdata()
    {
        let userid = user?._id ?? ""
        
        //links.append("")
        var n = txs.count-1
        
        
        for i in 0...n{

            let reqURL = "https://dhp-server.herokuapp.com/api/holder/transaction/\(txs[i].transaction_id!)/\(txs[i].holder_id!)"
            if(txs[i].info?.report == "covid-report"){
                var x = (txs[i].info?.report)!
            links.append(reqURL)
            linksDisplay.append(x)
            print("**********")
            }
            
            //covid-report
        }
        
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
//        controller.modalPresentationStyle = .fullScreen
//        self.present(controller, animated: true, completion: nil)
        
    }
    
    func ddata()
    {
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/verifier/transaction/\(txs[0].transaction_id!)/\(txs[0].holder_id!)"
        print(reqURL)
        
        
        
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee!)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
//            do {
//                let decoded = try JSONDecoder().decode([Transactions].self, from: data);
//                DispatchQueue.main.async {
//                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
//                    controller.text1 = reqURL
//
//                     //https://arxiv.org/pdf/2005.08922.pdf
//
//                    controller.modalPresentationStyle = .fullScreen
//                    self.present(controller, animated: true, completion: nil)
//                }
//
//            } catch let error {
//                print("Error in JSON parsing", error)
//            }
        }
        // 4) make an API call
        dataTask.resume()
    }
    
    
    
}

