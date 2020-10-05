//
//  LatencyViewController.swift
//  RRSS
//
//  Created by Tim on 10/4/20.
//

import UIKit

class LatencyViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sun: UIImageView!
    @IBOutlet weak var earth: UIImageView!
    @IBOutlet weak var mars: UIImageView!
    @IBOutlet weak var solarSystem: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var latencyLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var instructionText: UITextView!
    var orbitalData: [[String]] = [[]]
    var ssWidth: CGFloat = 0
    var ssHeight: CGFloat = 0
    var originX: CGFloat = 0
    var originY: CGFloat = 0
    var xDivisor: CGFloat = 0
    var yDivisor: CGFloat = 0
    var assignment: Int = 1
    var currLatency: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        NotificationCenter.default.addObserver(self, selector: #selector(self.messagesSegue), name: NSNotification.Name(rawValue: "showMessages"), object: nil)
        
        self.navigationController?.navigationBar.isHidden = false
        
        // Format the objects
        sun.layer.cornerRadius = sun.frame.size.width / 2
        sun.clipsToBounds = true
        earth.layer.cornerRadius = earth.frame.size.width / 2
        earth.clipsToBounds = true
        mars.layer.cornerRadius = mars.frame.size.width / 2
        mars.clipsToBounds = true
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
        
        // Get the container width / height - Offset for mars size
        ssWidth = solarSystem.frame.size.width - 16
        ssHeight = solarSystem.frame.size.height - 16
        
        // Get the 0,0 coordinates (Center of sun)
        originX = solarSystem.frame.size.width / 2
        originY = solarSystem.frame.size.height / 2
        
        // Set the sun position
        sun.frame.origin.x = originX + sun.frame.width / 4
        sun.frame.origin.y = originY - sun.frame.height / 2
        
        print("X origin: ", originX)
        print("Y origin: ", originY)
        
        // Create an array of orbital data from the csv file
        // ** Data from JPL Horizons **
        self.csvArray()
        
        // Format the slider
        slider.minimumValue = 1
        slider.maximumValue = Float(orbitalData.count - 1)
        slider.value = 1
        print("Data points: ", orbitalData.count)
        
        // Calculate the x and y divisors
        xDivisor = 208000000 / (solarSystem.frame.size.width - 100)*2
        yDivisor = 236000000 / (solarSystem.frame.size.height - 100)*2
        
        // Set the initial positions of earth and mars
        setPositions(index: 1)
        print("Earth x: ", earth.frame.origin.x)
        print("Earth y: ", earth.frame.origin.y)
        print("Mars x: ", mars.frame.origin.x)
        print("Mars y: ", mars.frame.origin.y)
        
        // Set the labels
        setDate(index: 1)
        setDistance(index: 1)
        
        print("Sun X: ", sun.frame.origin.x)
        print("Sun Y: ", sun.frame.origin.y)
        
        // Create a timer for the alert to appear
//        self.delayAlert()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Explain the controls when loading the screen
        let alert = UIAlertController(title: "Welcome!", message: "Move the slider to see how planetary positions affect communication and complete the assignments.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        // Round the value to the nearest whole number
        let roundedValue = round(slider.value)
        slider.value = roundedValue
        
        // Set the positions
        setPositions(index: Int(slider.value))
        
        // Set the labels
        setDate(index: Int(slider.value))
        setDistance(index: Int(slider.value))
        
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        // Set variables
        var limit: CGFloat = 0
        var limType: String = ""
        // Check the current assignment and set the threshold
        switch assignment {
        case 1:
            limit = 5
            limType = "Max"
        case 2:
            limit = 20
            limType = "Min"
        default:
            limit = 0
            limType = ""
        }
        
        // Check if the answer is correct
        if limType == "Max" {
            if currLatency < limit {
                print("Success")
                // Display alert
                let alert = UIAlertController(title: "Success!", message: "The closer Earth is to Mars the faster the transmission speed. Now for the next task...", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { response in
                    // Update assignment
                    self.assignment = self.assignment + 1
                    self.updateAssignment()
                }))
                
                self.present(alert, animated: true, completion: nil)
                
                
            } else {
                print("Failure")
                let alert = UIAlertController(title: "Incorrect", message: "Hint: Latency is lower when Earth and Mars are closer together. Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if limType == "Min" {
            if currLatency > limit {
                print("Success")
                let alert = UIAlertController(title: "Success!", message: "Note: When the sun is directly between Earth and Mars direct communication is not possible. This is called Solar Conjunction.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { response in
                    // Next assignment
                    self.assignment = self.assignment + 1
                    self.updateAssignment()
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                print("Failure")
                let alert = UIAlertController(title: "Incorrect", message: "Hint: Latency is higher when Earth and Mars are far apart. Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    func updateAssignment() {
        // Change the assingment text based on the value
        var txtString: String = ""
        switch assignment {
        case 1:
            txtString = "Your task is to identify a date in which latency is low, meaning the communication transmission time is less than 5 minutes."
        case 2:
            txtString = "Next identify a date in which the latency is high, meaning the transmission time is greater than 20 minutes."
        default:
            txtString = "Congratulations! Your task for today is complete. Feel free to continue using the tool to explore how planetary positions affect latency."
            
        }
        
        UIView.transition(with: instructionText,
                          duration: 0.5,
                       options: .transitionCrossDissolve,
                    animations: { [weak self] in
                        self?.instructionText.text = txtString
                 }, completion: nil)
//        instructionText.text = txtString
    }
    
    func setDate(index: Int) {
        dateLabel.text = "Earth Date: " + orbitalData[index][0]
    }
    
    func setDistance(index: Int) {
        // Get the x,y,z coordinates
        let earthX = NumberFormatter().number(from: orbitalData[index][1]) as! CGFloat
        let earthY = NumberFormatter().number(from: orbitalData[index][2]) as! CGFloat
        let earthZ = NumberFormatter().number(from: orbitalData[index][3]) as! CGFloat
        let marsX = NumberFormatter().number(from: orbitalData[index][4]) as! CGFloat
        let marsY = NumberFormatter().number(from: orbitalData[index][5]) as! CGFloat
        let marsZ = NumberFormatter().number(from: orbitalData[index][6]) as! CGFloat
        
        // Calculate the distance
        let distance = round(sqrt(pow(earthX - marsX, 2)+pow(earthY-marsY, 2)+pow(earthZ-marsZ, 2)))
        
        // Calculate the latency
        let latency = round(((distance / 299792) / 60) * 10) / 10
        
        // Format the number
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .scientific
        numberFormatter.positiveFormat = "0.###E+0"
        numberFormatter.exponentSymbol = "e"
        let sciDistance = numberFormatter.string(from: NSNumber(value: Float(distance)))
        
        // Set the distance label
        distanceLabel.text = "Distance Earth to Mars: " + sciDistance! + " km"
        
        // Set the latency label and variable
        latencyLabel.text = "Communication Latency: " + "\(latency)" + " mins"
        currLatency = latency
    }
    
    func setPositions(index: Int) {
        // Get the positions from the array
        let earthX = NumberFormatter().number(from: orbitalData[index][1]) as! CGFloat
        let earthY = NumberFormatter().number(from: orbitalData[index][2]) as! CGFloat
        let marsX = NumberFormatter().number(from: orbitalData[index][4]) as! CGFloat
        let marsY = NumberFormatter().number(from: orbitalData[index][5]) as! CGFloat
        
        // Set the relative screen position
        earth.frame.origin.x = (originX + earthX / xDivisor) + earth.frame.size.width / 2
        earth.frame.origin.y = (originY + earthY / yDivisor) - earth.frame.size.height / 2
        mars.frame.origin.x = (originX + marsX / xDivisor) + mars.frame.size.width / 2
        mars.frame.origin.y = (originY + marsY / yDivisor) - mars.frame.size.height / 2
    }
    
    func delayAlert() {
        
        // Set the delay time
        let delay = DispatchTime.now() + 60.0
        
        // Set the action
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
        
            self.performSegue(withIdentifier: "alertSegue", sender: nil)
        
        })
        
    }
    
//    @objc func messagesSegue() {
//        // Modal segue to message alert
//        tabBarController?.selectedIndex = 1
//    }
    
    func csvArray() {
        
        // Create the temp array
        var dataArray : [[String]] = [[]]
        // Get the path to the csv file
        if  let path = Bundle.main.path(forResource: "HorizonsData", ofType: "csv") {
            let url = URL(fileURLWithPath: path)
            // Put the data into the temp array
            do {
                let data = try Data(contentsOf: url)
                let stringData = String(data: data, encoding: .utf8)
                if  let lines = stringData?.components(separatedBy: NSCharacterSet.newlines) {
                    for line in lines {
                        if line != "" {
                            dataArray.append(line.components(separatedBy: ","))
                        }
                    }
                    // Set the array property
                    orbitalData = dataArray
                }
            }
            catch let err {
                    print("\n Error reading CSV file: \n", err)
            }
        }
    }

}
