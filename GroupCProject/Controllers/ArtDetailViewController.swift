//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 6
//  DUE: Sunday 07/26/2020

import UIKit

//this view shows the pin and url fields that the user can use to update the original values
class ArtDetailViewController:UIViewController,UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
   
    var localGallery : Results?//table from KoreData
    var tabBarCopy = BaseTabBarController()
    var tableViewController = CategoryResultsTableViewController()
    var picFlag = false
    var preSelectedCat = String()
    
    @IBOutlet weak var artPicture: UIImageView!
    @IBOutlet weak var artDescription: UITextView!
    @IBOutlet weak var artTitle: UILabel!
    
    //udpate fields;hidden by default
    @IBOutlet weak var updatePIc: UIImageView!
    @IBOutlet weak var updateTiitle: UITextField!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var updateDesc: UITextView!
    @IBOutlet weak var updateTitleLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = tabBarController as! BaseTabBarController
        self.tabBarCopy = tabBar
        
        self.updatePIc.isHidden = true
        self.updateTiitle.isHidden = true
        self.camera.isHidden = true
        self.submit.isHidden = true
        self.updateDesc.isHidden = true
        self.updateTitleLabel.isHidden = true
        
        artPicture.image = UIImage( data: localGallery!.img! as Data)
        artDescription.text = localGallery!.desc
        artTitle.text = localGallery!.title
    }
    
    //this function limits the number of characters in the PIN field to 4
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        var alertController = UIAlertController()
        
            //Used the reference to the class with original contacts array and store new contact
        self.tabBarCopy.resultsDB.removeFromCoreDataArray(title: self.localGallery!.title!)
            
        alertController = UIAlertController(title: "Artpiece has been deleted!", message:"Redirecting back to Categories..." , preferredStyle: .alert)
        
       self.present(alertController, animated: true, completion: nil)
        
        // delays execution of code to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            alertController.dismiss(animated: false, completion: nil)
           self.performSegue(withIdentifier: "resDelete", sender: nil)
        })
    }
    
    //This function will save the values entered (if any) in the text fields into the selected
    //object. These fields are required so an error message will be shown to the user if any of those
    //fields are missing
    @IBAction func makeFavoriteButtonPressed(_ sender: Any) {
//
//        var alertController = UIAlertController()
//
//        //checks for blank fields
//        if self.firstField.text == "" || self.lastField.text == "" || self.pinField.text == ""
//        {
//            alertController = UIAlertController(title: "Try Again", message: "PIN, First Name, and Last Name cannot be blank", preferredStyle: .alert)
//        }
//        else//fields have data, process them and udpate CoreData array
//        {
//            self.tabBarCopy.employeeList.removeFromCoreDataArray(PIN: self.PIN)
//            //Used the reference to the class with original contacts array and store new contact
//            self.tabBarCopy.employeeList.coreDataEmpInsert(empID: Int(self.pinField.text!)!, firstName: self.firstField.text!, lastName: self.lastField.text!)
//
//            alertController = UIAlertController(title: "It's Done!", message: "Changes Saved!", preferredStyle: .alert)
//        }
//        self.present(alertController, animated: true, completion: nil)
//
//        // delays execution of code to dismiss
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//            alertController.dismiss(animated: false, completion: nil)
//        })
//
//        //dismiss keyboard if it's showing when the botton was pressed
//        view.endEditing(true)
  }
    
    
    @IBAction func updateResultButton(_ sender: Any) {
        
        self.artDescription.isHidden = true
        self.artPicture.isHidden = true
        self.artTitle.isHidden = true
        self.favButton.isHidden = true
        self.updateButton.isHidden = true
        self.deleteButton.isHidden = true
        
        self.updatePIc.isHidden = false
        self.updateTiitle.isHidden = false
        self.camera.isHidden = false
        self.submit.isHidden = false
        self.updateDesc.isHidden = false
        self.updateTitleLabel.isHidden = false
    }
    
    @IBAction func pressedCamera(_ sender: Any) {
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
    }
    

    @IBAction func pressedSubmit(_ sender: Any) {
        
        var alertController = UIAlertController()
        //checks for blank fields
        if self.updateDesc.text == "" || self.picFlag == false || self.updateTiitle.text == ""
        {
            alertController = UIAlertController(title: "Try Again", message: "Artpiece Title, Picture, and Descripton cannot be blank", preferredStyle: .alert)
        }
        else//fields have data, process them and udpate CoreData array
        {
            //Used the reference to the class with original contacts array and store new contact
            self.tabBarCopy.resultsDB.updateResult(oldTitle: self.localGallery!.title!,oldCat: self.localGallery!.categoryType!, img:self.updatePIc.image!, title:self.updateTiitle.text!, desc: self.updateDesc.text, categoryType:self.localGallery!.categoryType!)
            
            alertController = UIAlertController(title: "It's Done!", message:"Artpiece has been updated!" , preferredStyle: .alert)
            self.picFlag = false// restore flag
            
            
            
            
            //update fields and pic
            self.artDescription.text = self.updateDesc.text
            self.artPicture.image = self.updatePIc.image
            self.artTitle.text = self.updateTiitle.text
            
            //restore update fields and pic to default
            self.updateDesc.text = ""
            self.updatePIc.image = #imageLiteral(resourceName: "icons8-picture-500")
            self.updateTiitle.text = ""
            
            //restore UI
            self.artDescription.isHidden = false
            self.artPicture.isHidden = false
            self.artTitle.isHidden = false
            self.favButton.isHidden = false
            self.updateButton.isHidden = false
            self.deleteButton.isHidden = false
            
            self.updatePIc.isHidden = true
            self.updateTiitle.isHidden = true
            self.camera.isHidden = true
            self.submit.isHidden = true
            self.updateDesc.isHidden = true
            self.updateTitleLabel.isHidden = true
        }
        self.present(alertController, animated: true, completion: nil)
        
        // delays execution of code to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            alertController.dismiss(animated: false, completion: nil)
            
           
        })
        
        //dismiss keyboard if it's showing when the botton was pressed
        view.endEditing(true)
    }
    
    //This function will add a new picture to the new contact being created
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //copy new picture into new contact
        self.updatePIc.image = image
        
        dismiss(animated: true, completion: nil)
    } // end imagePickerController (_:didFinish)
    
    
//This function hides the keyboard when done or the return key are pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//
    //This will hide the keyboard when the user clicks away on any part in the view on the app
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //dismiss keyboard when the user touches outside of the fields
        view.endEditing(true)
} //NewContactViewController Class. This is the end of this file

}
