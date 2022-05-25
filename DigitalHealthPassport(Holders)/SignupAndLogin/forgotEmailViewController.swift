//
//  forgotEmailViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/18/22.
//

import UIKit

class forgotEmailViewController: UIViewController {
    var arr = ["N11111","09/02/1997"]

    @IBOutlet weak var passport: UITextField!
    
    @IBOutlet weak var dateofbirth: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "emailidORPassword")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    
    @IBAction func submit(_ sender: Any) {
        if(passport.text == "" || dateofbirth.text == "")
        {
            let uialert = UIAlertController( title: "", message: "Fill required fields", preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
        else if(passport.text == arr[0] && dateofbirth.text == arr[1])
        {
            let storyboard = UIStoryboard(name : "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Login")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        }
        else{
        
            let uialert = UIAlertController( title: "", message: "Doesn't Exist", preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
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
