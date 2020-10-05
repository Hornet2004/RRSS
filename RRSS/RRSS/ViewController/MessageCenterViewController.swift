//
//  MessageCenterViewController.swift
//  RRSS
//
//  Created by Tim on 10/4/20.
//

import UIKit

class MessageCenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create a notification to segue
        NotificationCenter.default.addObserver(self, selector: #selector(self.messageDetailSegue), name: NSNotification.Name(rawValue: "showMessageDetail"), object: nil)
        
    }
    
    @objc func messageDetailSegue() {
        // Segue to the message detail
        performSegue(withIdentifier: "messageDetailSegue", sender: nil)
    }

}
