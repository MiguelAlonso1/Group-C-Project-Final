//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment #4
//  DUE: Sunday 07/05/2020


import UIKit
import MessageUI

class CommissionViewController: UIViewController,UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }
    //this variable will hold a reference to the class that contains the original Contacts array.
    //It's passed down by the segue. It'll be used to add new contacts
   // var store:ItemStore?
    
    
    @IBOutlet var myPicture: UIImageView!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var txtField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //below statements needed to dismiss keyboard when return key is pressed
        fullNameField.delegate = self
        phoneField.delegate = self
        emailField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //This function will allow the user to take a picture or browse a picture stored
    //in their device
    @IBAction func pressedCamera(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    } // end pressedCamera
    
    
    //This function will save the values entered (if any) in the text fields into a new contact
    //reference. They are required so an error message will be shown to the user if any of those
    //fields are missing
    @IBAction func saveButtonPressed(_ sender: Any) {
    
        if self.emailField.text == "" || self.fullNameField.text == "" || self.phoneField.text == "" || self.txtField.text == ""
        {
            let alertController = UIAlertController(title: "Try Again", message: "Full Name, Phone#, email, and job description cannot be blank", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            // delays execution of code to dismiss
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                alertController.dismiss(animated: false, completion: nil)
            })
        }
        else
        {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.recipients = ["13055608045"]//Miguel's cell
            composeVC.body = "\(self.fullNameField!) can be reached at:\n \(self.emailField!)\n\(self.phoneField!)\nIquiry:\n\(self.txtField!)\nThis is the picture:\n\(self.myPicture.image!)"
            
            // Present the view controller modally.
            if MFMessageComposeViewController.canSendText() {
                self.present(composeVC, animated: true, completion: nil)
            }
            
            let alertController = UIAlertController(title: "It's Done!", message: "Inquiry has been sent!", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                alertController.dismiss(animated: false, completion: nil)
                self.myPicture.image = UIImage()
                self.fullNameField.text = ""
                self.emailField.text = ""
                self.phoneField.text = ""
                self.txtField.text = ""
            })
        }
        
        //dismiss keyboard if it's showing when the botton was pressed
        view.endEditing(true)
    }
    
    //This function will add a new picture to the new contact being created
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //copy new picture into new contact
        myPicture.image = image
        
        dismiss(animated: true, completion: nil)
        
    } // end imagePickerController (_:didFinish)
    
    //This function hides the keyboard when done or the return key are pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //This will hide the keyboard when the user clicks away on any part in the view on the app
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //dismiss keyboard when the user touches outside of the fields
        view.endEditing(true)
    }
    
} //NewContactViewController Class. This is the end of this file

