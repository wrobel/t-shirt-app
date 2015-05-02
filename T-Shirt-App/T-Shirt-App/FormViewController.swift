//
//  FormViewController.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 01.05.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var formSelection: UISegmentedControl!
    @IBOutlet weak var sizeSelection: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FormToName" {
            let target = segue.destinationViewController as! NameViewController
            target.order = Order(
                form: ShirtForm(rawValue: formSelection.selectedSegmentIndex)!,
                size: ShirtSize(rawValue: sizeSelection.selectedSegmentIndex)!,
                firstName: "",
                lastName: "",
                email: "",
                address: "",
                postalCode: "",
                city: ""
            )
        }
    }

}
