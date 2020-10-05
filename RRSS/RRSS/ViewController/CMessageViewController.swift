//
//  CompleteMessageViewController.swift
//  RRSS
//
//  Created by Tim on 10/4/20.
//

import UIKit

class CMessageViewController: UIViewController {

    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButton.layer.cornerRadius = 10
        doneButton.clipsToBounds = true
        navigationItem.hidesBackButton = true
    }

}
