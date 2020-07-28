//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 6
//  DUE: Sunday 07/26/2020
//********************************************
// *********ADMIN PIN: 2077*******************
//********************************************

import UIKit

//this class controls the PINs entered by users. It determines if a PIN is correct or not
//and display the proper messages to user based on that
//it control access to log and employee edit tabBars
class FavoritesViewController: UIViewController {
//   
//    //set up local variables
//    @IBOutlet weak var clockLabel: UILabel!
//    @IBOutlet var PinNumberLabels: [UILabel]!
//    @IBOutlet var KeypadButtons: [UIButton]!
//    
//    @IBOutlet weak var InLabel: UILabel!
//    @IBOutlet weak var outLabel: UILabel!
//    var pinString = ""
//    var isAdminModeEnable = false
//    var PINCounter = 1
//    
//    //this variable holds reference to CoreData arrays for both, Employees and Time logs
//    var tabBarCopy = BaseTabBarController()
//    
//    //timer for clock on PIN screen
//    var timer = Timer()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //default colors for IN or OUT labels
//        self.InLabel.backgroundColor = UIColor.white
//        self.outLabel.backgroundColor = UIColor.white
//        
//        self.InLabel.textColor = UIColor.lightGray
//        self.outLabel.textColor = UIColor.lightGray
//        
//        //update local variable to reference to CoreData arrays
//        let tabBar = tabBarController as! BaseTabBarController
//        self.tabBarCopy = tabBar
//        
//        //make pin fields blank
//        for i in 0...self.PinNumberLabels.count - 1 {
//            self.PinNumberLabels[i].text = ""
//            }
//        //set clock
//        timer = Timer.scheduledTimer(timeInterval: 1.0,
//            target: self,
//            selector: #selector(tick),
//            userInfo: nil,
//            repeats: true)
//        
//        //insert dummy data to test the app and CoreData
//         self.tabBarCopy.employeeList.insertDummyEmps(empID: 1234, firstName: "Miguel", lastName: "Alonso")
//         self.tabBarCopy.employeeList.insertDummyEmps(empID: 4321, firstName: "Felipe", lastName: "Beltran")
//         self.tabBarCopy.employeeList.insertDummyEmps(empID: 1001, firstName: "Claire", lastName: "Redfield")
//         self.tabBarCopy.employeeList.insertDummyEmps(empID: 2077, firstName: "Super", lastName: "Admin")
//    }
//    
//    //start clock so it ticks every second
//    @objc func tick() {
//        self.clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
//    }
//    
//    //this function handles the logic for the keypad the user uses to enter the PINs
//    @IBAction func buttonPressed(_ sender: AnyObject) {
//      var pinNum = 0
//       var isPinCorrect = false
//      var alertController = UIAlertController()
//        
//        //set screen pin digit
//      self.PinNumberLabels[self.PINCounter - 1].text = sender.titleLabel!.text
//       //concatenate current digit to string that will get parsed to an Integer later
//        pinString += sender.titleLabel!.text!
//        
//      self.PINCounter += 1
//        
//      if self.PINCounter > 4
//      {
//        pinNum = Int (pinString)!
//    
//        //check if pin is correct
//        isPinCorrect = self.tabBarCopy.employeeList.isPINCorrect(PIN: pinNum)
//
//        if isPinCorrect == false {
//            alertController = UIAlertController(title: "ID number is incorrect", message:
//            "Please try again", preferredStyle: .alert)
//        }
//        else{
//            //update PIN Number on the main tab bar controller so every view can see it
//            let tempEmp = self.tabBarCopy.employeeList.getEmployee(PIN: pinNum)
//            
//            /***********procesess ADMIN mode; it re-enables tabbar so log and edit tabs are visible
//            ****************************************************************************************/
//            if tempEmp?.firstName == "Super" && tempEmp?.lastName == "Admin"{
//                if self.isAdminModeEnable == false{
//                    self.tabBarCopy.enableTabBar()
//                    self.isAdminModeEnable = true
//                    
//                    alertController = UIAlertController(title: "Admin Mode Enabled", message:
//                        "Tab Bar is now visible \n***To disable, enter ADMIN PIN again***", preferredStyle: .alert)
//                }
//                else{//disable admin mode
//                    self.tabBarCopy.disableTabBar()
//                    self.isAdminModeEnable = false
//                    
//                    alertController = UIAlertController(title: "Admin Mode Disabled", message:
//                        "***To enable, enter ADMIN PIN again***", preferredStyle: .alert)
//                }
//              //show alert message
//                self.present(alertController, animated: true, completion: nil)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                    alertController.dismiss(animated: false, completion: nil)
//                })
//                
//                //this second dispatcher is needed to show the 4th PIN entered;otherwise,it processes so fast is not visible
//                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
//                    alertController.dismiss(animated: false, completion: nil)
//                    
//                    //reset pin pad for next user
//                    for i in 0...self.PinNumberLabels.count - 1 {
//                        
//                        self.PinNumberLabels[i].text = ""
//                    }
//                    self.PINCounter = 1
//                    self.pinString = ""
//                }
//               return
//            }
//            let isClockingIn = self.isClockingIN(emp: tempEmp!)
//            //employee is clocking in
//            if isClockingIn == -35{//employee is clocking in
//                
//                self.InLabel.backgroundColor = UIColor.orange
//                self.InLabel.textColor = UIColor.black
//                self.tabBarCopy.log.coreDataLogInsert(firstName: tempEmp!.firstName!, lastName: tempEmp!.lastName!, timeIn:Date() , timeOut: nil)
//          
//            
//            alertController = UIAlertController(title: "PIN is correct!", message:
//                "Welcome \(tempEmp!.firstName ?? "Unknown")! You're clocking in", preferredStyle: .alert)
//               
//            }//end if clocking if = true
//            else{//employee is clocking out
//                
//                //ilimunate IN label
//                self.outLabel.backgroundColor = UIColor.orange
//                self.outLabel.textColor = UIColor.black
//                
//                //update time out entry for employee in CoreData
//                self.tabBarCopy.log.updateLogTimeOut(firstName: tempEmp!.firstName!, lastName: tempEmp!.lastName!)
//            
//                alertController = UIAlertController(title: "PIN is correct!", message:
//                    "Goodbye  \(tempEmp!.firstName ?? "Unknown")! You're clocking out", preferredStyle: .alert)
//            }
//        }
//        self.present(alertController, animated: true, completion: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//            alertController.dismiss(animated: false, completion: nil)
//             })
//      
//        //this second dispatcher is needed to show the 4th PIN entered;otherwise,it processes so fast is not visible
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
//            alertController.dismiss(animated: false, completion: nil)
//
//           //reset pad for next user
//            for i in 0...self.PinNumberLabels.count - 1 {
//
//            self.PinNumberLabels[i].text = ""
//        }
//        self.PINCounter = 1
//        self.pinString = ""
//            
//            //reset IN or OUT labels
//                    self.InLabel.backgroundColor = UIColor.white
//                    self.outLabel.backgroundColor = UIColor.white
//            
//                    self.InLabel.textColor = UIColor.lightGray
//                    self.outLabel.textColor = UIColor.lightGray
//     }
//
//      }//end if PIN > 4
//      
//      
//    }//end buttonpressed
//    
//    //handles logic for clocking in
//    func isClockingIN(emp: Employee)-> Int{
//        //update array from CoreData
//        self.tabBarCopy.log.logCoreDataRetreival()
//        for temp in 0 ..< self.tabBarCopy.log.logList.count{
//            if self.tabBarCopy.log.logList[temp].firstName == emp.firstName &&
//                self.tabBarCopy.log.logList[temp].lastName == emp.lastName &&
//                self.tabBarCopy.log.logList[temp].timeOut == nil{
//                return temp//employee is clocking out
//            }
//        }//end for loop
//        //employee is clocking in
//      return -35
//    }
//    //the funcions below handle delegation to hide key board when the user changes
//    //fields or touches the screen outside of them
//    func applicationWillEnterForeground(notification:NSNotification) {
//        let defaults = UserDefaults.standard
//        defaults.synchronize()
//       
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        //load local array from CoreData
//        self.tabBarCopy.employeeList.empCoreDataRetreival()
//        
//        let app = UIApplication.shared
//        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(notification:)), name: Notification.Name.UIApplicationWillEnterForeground, object: app)
//        
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//        //self.PINCounter = 1
//        NotificationCenter.default.removeObserver(self)
//    }
}

