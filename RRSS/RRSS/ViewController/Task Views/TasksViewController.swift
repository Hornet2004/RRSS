//
//  TasksViewController.swift
//  RRSS
//
//  Created by Tim on 10/4/20.
//

import UIKit

class TasksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create a notification to segue
        NotificationCenter.default.addObserver(self, selector: #selector(self.taskDetailSegue), name: NSNotification.Name(rawValue: "showTaskDetail"), object: nil)
        
    }
    
    @objc func taskDetailSegue() {
        // Segue to the message detail
        performSegue(withIdentifier: "taskDetailSegue", sender: nil)
    }

}
