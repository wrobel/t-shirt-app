//
//  PaymentViewController.swift
//  T-Shirt-App
//
//  Created by Tobias Deekens on 22/04/15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UINavigationControllerDelegate, CardIOPaymentViewControllerDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expirationDate: UITextField!
    @IBOutlet weak var ccv: UITextField!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var performPaymentBtn: UIButton!

    let payMillPublicKey = "913760753501aa5d8da1952ea8ee79a9";
    var userCardNumber: String = "";
    var userCvc: String = "";
    var userExpirationMonth: UInt = 0;
    var userExpirationYear: UInt = 0;
    var fullName = "Tobias Deekens";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardIOUtilities.preload()
        initPayment();

        cardNumber.userInteractionEnabled = false;
        expirationDate.userInteractionEnabled = false;
        ccv.userInteractionEnabled = false;

        performPaymentBtn.enabled = false;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanCard(sender: AnyObject) {
        var cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        statusLabel.text = "Die Zahlungdateneingabe wurde abgebrochen."
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            updatePaymentInfo(info);
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updatePaymentInfo(info:CardIOCreditCardInfo) {
        let paymentReceived = "Ihre Zahlungsdaten zur Überprüfung";

        statusLabel.text = paymentReceived;
        actionBtn.hidden = true;

        cardNumber.text = info.redactedCardNumber;
        expirationDate.text = toString(info.expiryMonth) + "/" + toString(info.expiryYear);
        ccv.text = info.cvv;

        userCardNumber = info.redactedCardNumber;
        userCvc = info.cvv;
        userExpirationMonth = info.expiryMonth;
        userExpirationYear = info.expiryYear;
    };

    func initPayment() {
        PMManager.initWithTestMode(true, merchantPublicKey: payMillPublicKey, newDeviceId: nil)
            { (success, error) -> Void in
                if success{
                    println("successfully initialized PayMillSDK");

                    self.performPaymentBtn.enabled = false;
                }
                else{
                    println("Error during initialization")
                }
        }
    }

    @IBAction func performPayment() {
        var error: NSError?;

        let paymentMethod = PMFactory.genCardPaymentWithAccHolder(
            fullName,
            cardNumber: userCardNumber,
            expiryMonth: toString(userExpirationMonth),
            expiryYear: toString(userExpirationYear),
            verification: userCvc,
            error: &error
        );

        if(error == false) {
            let params = PMFactory.genPaymentParamsWithCurrency(
                "EUR",
                amount:100,
                description:"Description",
                error:&error
            );

            PMManager.transactionWithMethod(
                paymentMethod,
                parameters:params,
                consumable:true,
                success: { (PMTransaction) -> Void in
                    println("payment done");
                },
                failure: { (NSError) -> Void in
                    println("payment failed");
                }
            );
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
