//
//  HammeringViewController.swift
//  RRSS
//
//  Created by Tim on 10/4/20.
//

import UIKit

class HammerViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeButton.layer.cornerRadius = 10
        homeButton.clipsToBounds = true
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func homePressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
