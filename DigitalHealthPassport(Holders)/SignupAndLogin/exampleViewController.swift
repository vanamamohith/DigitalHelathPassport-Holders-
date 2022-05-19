//
//  exampleViewController.swift
//  SignupAndLogin
//
//  Created by student on 4/20/22.
//

import UIKit
import Foundation


struct Transactions: Codable {
    let _id, transaction_id, issuer_id, holder_id: String?
    let createdAt, updatedAt: String?
    let __v: Int?
    var info: Info?
}

struct Info: Codable {
    let reportType, name, report, by, fullname, serviceType, serviceName, contact, eligibleToFly: String?

}

class exampleViewController: UIViewController {
    
    
    var str : String?
    var tokee : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clicked(_ sender: Any) {
        postData()
        //ddata()
    }
    
    @IBAction func view(_ sender: Any) {
        
        ddata()
    }
    
    @IBAction func qrClicked(_ sender: Any) {
        
        qrData()
    }
    
    var user: User? = nil
    var token: String = ""
    
    
    var txs: [Transactions] = []
    
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
                    for i  in 0...n{
                        print("***")
                        print(self.txs[i].transaction_id!,"  Created at :",self.txs[i].createdAt!,"Report Type:", self.txs[i].info!.report!)
                    }
                    print("**********")
                    self.ddata()
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
    
    
    func qrData()
    {
                            let controller = self.storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
                            controller.text1 = "https://dhp-server.herokuapp.com/api/verifier/transaction/\(txs[0].transaction_id!)/\(txs[0].holder_id!)"
        
                             //https://arxiv.org/pdf/2005.08922.pdf
        
                            controller.modalPresentationStyle = .fullScreen
                            self.present(controller, animated: true, completion: nil)
        
    }

}
