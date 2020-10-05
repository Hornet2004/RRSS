//
//  HomeViewController.swift
//  RRSS
//
//  Created by Apipon Siripaisan on 10/3/20.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var earthDate: UILabel!
    
    @IBOutlet weak var earthTime: UILabel!
    
    @IBOutlet weak var marsDate: UILabel!
    
    @IBOutlet weak var marsTime: UILabel!
    
    
    var timer = Timer()
    
    var sol = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        earthDate.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        earthTime.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        marsDate.text = "Sol " + String(sol)

        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)

        timer = Timer.scheduledTimer(timeInterval: 88620, target: self, selector:#selector(self.solUpdate) , userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool = true) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true;
        
        
        
    }
    
    //Live date and time for Earth
    @objc func tick() {
        earthDate.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        earthTime.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        }

    @objc func solUpdate() {
         
        sol = sol + 1
        marsDate.text = "Sol " + String(sol)
        
        
        // 88620 seconds in 1 Sol
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Sol", in: context)
//        let sol = NSManagedObject(entity: entity!, insertInto: context)
//
//        sol.setValue("1", forKey: "solDate")
//
//        do {
//           try context.save()
//          } catch {
//           print("Failed saving")
//        }
        
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
