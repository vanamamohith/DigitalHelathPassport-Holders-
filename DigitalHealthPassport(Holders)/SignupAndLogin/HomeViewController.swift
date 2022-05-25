//
//  HomeViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/18/22.
//

import UIKit

struct Transaction: Codable {
    let _id, transaction_id, issuer_id, holder_id, serviceType: String?
    let createdAt, updatedAt: String?
    let __v: Int?
    var info: Info?

}


class HomeViewController: UIViewController{
    
    var str : String?
    var tokee : String = ""
    
    var vacc = 0
    var covid = 0
    var qr = 0
    
    var txs: [Transaction] = []
    
    var testlist: [Transaction] = []
    
    var vaccinelist: [Transaction] = []
    
    var qrlist: [Transaction] = []
    
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

        welcomeOutlet.text = "DHP ID: \(dhpID!)"
        sideViewControl.constant = -240
        personIconConstraint.constant = 210
        
        print(vaccinelist.count)
        print(testlist.count)
        print(qrlist.count)
        
        
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
        
        QRcodefunc()
        
    }


    
    
    
    @IBAction func covidReportClicked(_ sender: UIButton) {
        
        postData()
        
        
    }

    
    
    
    
    
    
    @IBAction func navClicked(_ sender: UIButton) {
                
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
        
    }
    
    
    var user: User? = nil
    var token: String = ""
    
    func QRcodefunc()
    {
        txs = []
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(userid)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transaction].self, from: data);
                DispatchQueue.main.async {
                    self.txs = decoded
                    print("**********")
                    
                    self.qr = 1
                    self.qrfunc()
                    

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
    
    func qrfunc()
    {
        var n = txs.count-1
        
        if(qr == 0)
        {
            let uialert = UIAlertController( title: "", message: "No File Found", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        
        for i in 0...n{

            if(txs[i].info?.report == "covid-report"){
                qrlist.append(txs[i])
                print("***")
                print(txs[i].transaction_id)
            }
        }
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
        
        controller.txId = qrlist[qrlist.count-1].transaction_id
        controller.dhpID = dhpID
        controller.tokee = tokee
        controller.txs = txs
        controller.user = user
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
        }
        
    }

    
    func postVaccinationData()
    {
        txs = []
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(userid)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transaction].self, from: data);
                DispatchQueue.main.async {
                    self.txs = decoded
                    print("**********")
                    
                    self.vacc = 1
                    self.vdata()
                    

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

    func vdata()
    {
        var n = txs.count-1
        
        
        for i in 0...n{

            if(txs[i].info?.report == "vaccination" || txs[i].info?.report == "covid-vaccination"){
            vaccinelist.append(txs[i])
                print("***")
            }
        }
        if(vaccinelist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Record Found", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        let controller = storyboard?.instantiateViewController(withIdentifier: "viewC") as! ReportViewController
        
        controller.user = user
        controller.token  = tokee
        controller.dhpID = dhpID
        controller.txs = txs
        controller.tokee = tokee
        controller.tx = vaccinelist[vaccinelist.count-1]
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
    }

    
    
    func postData() {
        txs = []
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(userid)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transaction].self, from: data);
                DispatchQueue.main.async {
                    self.txs = decoded
                    print("**********")
                    var n = self.txs.count-1
                    print("Number ::::::",n)
                    for i  in 0...n{
                        print("***")
                        print(self.txs[i].transaction_id!,"  Created at :",self.txs[i].createdAt!)
                        var spli = self.txs[i].createdAt?.split(separator: "-", maxSplits: 2)
                        var x = ((spli?.removeFirst()) as! NSString).integerValue
                        var y = ((spli?.removeFirst()) as! NSString).integerValue
                        var m = spli?.removeFirst()
                        var m1 = m?.split(separator: "T")
                        var z = (m1?.removeLast() as! NSString).integerValue
                        print("***\(x)***")
                        print("***\(y)***")
                        print("***\(z)***")
                        var da = Date()
                        //var daa = String(da!)
                        print("**\(da)**")

                    }
                    print("**********")
                    
                    self.covid = 1
                    self.cdata()
                    
                    if(self.testlist.count == 0)
                    {
                        let uialert = UIAlertController( title: "", message: "No Record Found", preferredStyle: UIAlertController.Style.alert)
                                    uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(uialert, animated: true, completion: nil)
                    }
                    else{
                    
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
                    controller.links = self.links
                    controller.fname = self.fname
                    controller.lname = self.lname
                    controller.dob = self.dob
                    controller.passNum = self.passNum
                    controller.issuedCountry = self.issuedCountry
                    controller.phNum = self.phNum
                    controller.mailId = self.mailId
                    controller.user = self.user
                    controller.dhpID = self.dhpID
                    controller.tokee = self.tokee
                    controller.str = self.str
                    controller.txs = self.txs
                    controller.testlist = self.testlist

                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                    
                    }
                    
                    
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
    
    func cdata()
    {
        let userid = user?._id ?? ""
        
        //links.append("")
        var n = txs.count-1
        
        
        
        for i in 0...n{

            if(txs[i].info?.report == "covid-report"){
            testlist.append(txs[i])
                print("*****")
                print(txs[i].transaction_id)
            }
            
        }
        
        
    }
    
    
    
    
}

