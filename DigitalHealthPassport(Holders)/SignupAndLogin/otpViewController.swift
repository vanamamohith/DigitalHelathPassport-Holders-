//
//  otpViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/17/22.
//

import UIKit

class otpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitbutton(_ sender: Any) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegistrationSuccessful")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
