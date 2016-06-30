//
//  ViewController.swift
//  SwiftPreferences Demo
//
//  Created by ithelp on 30/06/16.
//  Copyright © 2016 Credencys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!

    @IBOutlet weak var txtUserEmail: UITextField!

    @IBOutlet weak var lblMessage: UILabel!

    let appDelelegate : AppDelegate =  UIApplication.sharedApplication().delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func onSave(sender: AnyObject) {

        //Get user Name
         appDelelegate.pref?.username = self.txtUsername.text;

        //Get user Email
         appDelelegate.pref?.userEmail = self.txtUserEmail.text;

        //Generate random user id
        let userid: Int = Int(rand())
        appDelelegate.pref?.userId = String(format:"%d",userid);

        //Save pref to disk
        appDelelegate.pref?.save("pref");

        self.lblMessage.text = "Your pref has been saved to disk now you can kill app and reopen app to view saved pref."

    }

    @IBAction func onClear(sender: AnyObject) {

        //Clear pref from disk
        appDelelegate.pref?.clear()

        appDelelegate.pref = nil;

        //Clear UI
        self.clearUI()

    }

    @IBAction func onLoadPref(sender: AnyObject) {

        //Load pref from disk if exists
        self.txtUsername.text =  appDelelegate.pref?.username as? String;
        self.txtUserEmail.text =  appDelelegate.pref?.userEmail as? String;
    }

    func clearUI() {
        self.txtUsername.text = nil;
        self.txtUserEmail.text = nil;
        self.lblMessage.text = "Prefrences removed!"
    }

}

