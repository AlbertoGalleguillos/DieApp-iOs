//
//  SignInViewController.swift
//  Die App
//
//  Created by Alberto Galleguillos on 3/27/17.
//  Copyright © 2017 Marcer Spa. All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    var handle: FIRAuthStateDidChangeListenerHandle?
    let segueIdentifier = "SignInToList"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently() 
        handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
            }
        }
    }
    
    deinit {
        if let handle = handle {
            FIRAuth.auth()?.removeStateDidChangeListener(handle)
        }
    }
}
