//
//  DetailViewController.swift
//  Die App
//
//  Created by Alberto Galleguillos on 3/21/17.
//  Copyright © 2017 Marcer Spa. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    /*
    @IBOutlet weak var photoUrl: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    */
    
    @IBOutlet weak var photoUrl: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
  

    var authorPassed: String!
    var titlePassed: String!
    var bodyPassed: String!
    var urlPassed: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        authorLabel.text = authorPassed
        titleLabel.text = titlePassed
        bodyTextView.text = bodyPassed
        
        let url = URL(string: urlPassed)
        photoUrl.af_setImage(withURL: url!)
        
        photoUrl.layer.cornerRadius = photoUrl.frame.size.width / 2
        photoUrl.clipsToBounds = true
        
        let iconNumber = UIApplication.shared.applicationIconBadgeNumber
        UIApplication.shared.applicationIconBadgeNumber = iconNumber - 1
    }
}
