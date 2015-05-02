//
//  ShippingViewController.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 29.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import UIKit

class ShippingViewController: UIViewController {

    var order: Order!
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var city: UITextField!
    
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
        address.resignFirstResponder()
        postalCode.resignFirstResponder()
        city.resignFirstResponder()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShippingToPayment" {
            let target = segue.destinationViewController as! PaymentViewController
            self.order.address = address.text
            self.order.postalCode = postalCode.text
            self.order.city = city.text
            
            target.order = order
        }
    }

}
