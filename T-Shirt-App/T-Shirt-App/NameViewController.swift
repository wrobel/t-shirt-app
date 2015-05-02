//
//  NameViewController.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 01.05.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    var order: Order!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }

    @IBAction func backgroundTap(sender: UIControl) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        email.resignFirstResponder()
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NameToShipping" {
            let target = segue.destinationViewController as! ShippingViewController
            self.order.firstName = firstName.text
            self.order.lastName = lastName.text
            self.order.email = email.text
            
            target.order = order
        }
    }

}
