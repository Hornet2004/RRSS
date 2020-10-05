//
//  MessageDetailViewController.swift
//  RRSS
//
//  Created by Apipon Siripaisan on 10/4/20.
//

import UIKit

class MessageDetailViewController: UIViewController {

    @IBOutlet weak var repeaterButton: UIButton!
    @IBOutlet weak var clarifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make the buttons rounded
        repeaterButton.layer.cornerRadius = 10
        repeaterButton.clipsToBounds = true
        clarifyButton.layer.cornerRadius = 10
        clarifyButton.clipsToBounds = true
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func useRepeater(_ sender: Any) {
        performSegue(withIdentifier: "repeaterSegue", sender: nil)
    }
    
    @IBAction func sendClarification(_ sender: Any) {
        performSegue(withIdentifier: "sendSegue", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
