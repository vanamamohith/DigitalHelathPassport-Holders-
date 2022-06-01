//
//  ReportViewController.swift
//  SignupAndLogin
//
//  Created by student on 5/16/22.
//

import UIKit
import PDFKit

import WebKit

struct FileResponse: Codable {
var url: String?
}

class ReportViewController: UIViewController {
    
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
    var othtestlist: [Transaction] = []
    //*********************************
    var LatesttxId: String? = ""
    var txs: [Transaction] = []
    var tokee: String = ""
    
    var user: User? = nil
    var token: String = ""
    var tx: Transaction? = nil
    var num = 0
    var txId: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        postData()
    }
    
    
    @IBAction func qrGenerator(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "each") as! EachFileQRViewController
        
        controller.txId = tx?.transaction_id
        controller.dhpID = dhpID
        controller.tokee = token
        controller.txs = txs
        controller.user = user
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.tx = tx
        controller.LatesttxId = LatesttxId
        controller.othtestlist = othtestlist
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func backpage(_ sender: Any) {
        if(HomeViewController.isCovidTest == 1)
        {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
            controller.user = user
            controller.tokee = token
            controller.dhpID = dhpID
            controller.fname = self.fname
            controller.lname = self.lname
            controller.dob = self.dob
            controller.passNum = self.passNum
            controller.issuedCountry = self.issuedCountry
            controller.phNum = self.phNum
            controller.mailId = self.mailId
            controller.txId = txId
            controller.othtestlist = othtestlist
            controller.LatesttxId = LatesttxId
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
        else if(HomeViewController.isCovidTest == 2){
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
            controller.tokee = token

            controller.user = self.user
            controller.txId = self.txId
            controller.LatesttxId = LatesttxId
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
        else{
            let controller = storyboard?.instantiateViewController(withIdentifier: "other") as! OtherVaccinationViewController
            controller.othtestlist = HomeViewController.othtestlist
            controller.user = user
            controller.tokee  = tokee
            controller.dhpID = dhpID
            controller.txs = txs
            controller.tokee = token
            controller.fname = self.fname
            controller.lname = self.lname
            controller.dob = self.dob
            controller.passNum = self.passNum
            controller.issuedCountry = self.issuedCountry
            controller.phNum = self.phNum
            controller.mailId = self.mailId
            controller.LatesttxId = LatesttxId
            controller.txId = txId
            
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    


    @IBOutlet weak var web: WKWebView!
    func postData() {
        let userid = user?._id ?? ""
        let txId = tx?.transaction_id ?? ""
        let reqURL = "https:dhp-server.herokuapp.com/api/holder/mtransaction/\(txId)/\(userid)"
        print(reqURL)
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode(FileResponse.self, from: data);
                DispatchQueue.main.async {
                    self.loadPDF(rquesturl: decoded.url!)
                }
               
            } catch let error {
                print("Error in JSON parsing", error)
            }
        }
        // 4) make an API call
        dataTask.resume()
        
        
        
 
    }
    func loadPDF(rquesturl: String) {
        print(rquesturl)
        if let url =  URL(string: rquesturl) {
            web?.load(URLRequest(url: url))
        }
    }
    

}
