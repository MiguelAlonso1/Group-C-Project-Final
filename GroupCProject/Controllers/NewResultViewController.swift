//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 6
//  DUE: Sunday 07/26/2020

import UIKit

//this view shows the pin and url fields that the user can use to update the original values
class NewResultViewController:UIViewController,UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var tabBarCopy = BaseTabBarController()
    var preSelectedCat = String()
    var picFlag = false
    
    @IBOutlet weak var resPic: UIImageView!
    @IBOutlet weak var resTitleField: UITextField!
    @IBOutlet weak var preCatLabel: UILabel!
    @IBOutlet weak var resDescText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = tabBarController as! BaseTabBarController
        self.tabBarCopy = tabBar
        self.preCatLabel.text = self.preSelectedCat
        //        artPicture.image = UIImage( data: localGallery.img! as Data)
        //        artDescription.text = localGallery.desc
        //        artTitle.text = localGallery.title
    }
    //this function limits the number of characters in the PIN field to 4
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function will allow the user to take a picture or browse a picture stored
    //in their device
    @IBAction func pressedCamera(_ sender: AnyObject) {
        self.picFlag = true
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
    
    //This function will add a new picture to the new contact being created
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //copy new picture into new contact
        self.resPic.image = image
        
        dismiss(animated: true, completion: nil)
    } // end imagePickerController (_:didFinish)
    
    
    //This function will save the values entered (if any) in the text fields into the selected
    //object. These fields are required so an error message will be shown to the user if any of those
    //fields are missing
    @IBAction func addResButtonPressed(_ sender: Any) {
        
        var alertController = UIAlertController()
        //checks for blank fields
        if self.preSelectedCat == "" || self.picFlag == false || self.resTitleField.text == "" || self.resDescText!.text == ""
        {
            alertController = UIAlertController(title: "Try Again", message: "Artpiece Title, Picture, and descripton cannot be blank", preferredStyle: .alert)
        }
        else//fields have data, process them and udpate CoreData array
        {
            //Used the reference to the class with original contacts array and store new contact
            self.tabBarCopy.resultsDB.insertDummyResult(img:self.resPic.image!, desc: self.resDescText.text, title:self.resTitleField.text!, categoryType:self.preSelectedCat)
            
            alertController = UIAlertController(title: "It's Done!", message:"New Artpiece Added!" , preferredStyle: .alert)
            self.picFlag = false// restore flag
        }
        self.present(alertController, animated: true, completion: nil)
        
        // delays execution of code to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            alertController.dismiss(animated: false, completion: nil)
        })
        
        //dismiss keyboard if it's showing when the botton was pressed
        view.endEditing(true)
    }
    
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
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //
    //    }
    
} //NewContactViewController Klass. This is the end of this file

