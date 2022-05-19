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
    //*********************************
    
    var txs: [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        postData()
    }
    
    
    @IBAction func qrGenerator(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
        
        controller.txId = tx?.transaction_id ?? ""
        controller.dhpID = dhpID
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func backpage(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
        controller.txs = txs
        controller.user = user
        controller.tokee = token
        controller.dhpID = dhpID
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    var user: User? = nil
    var token: String = ""
    var tx: Transaction? = nil
    var num = 0

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
