//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  PROGRAMMER: Diane Abdullah
//  PANTHERID: 4892489
//  PROGRAMMER: Kenny Gonzalez Mejia
//  PANTHER ID: 3963603
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Deliverable 2
//  DUE: Saturday 08/01/2020

import UIKit

//this view shows the pin and url fields that the user can use to update the original values
class ArtDetailViewController:UIViewController,UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
   
    var localGallery : Results?//table from CoreData
    var tabBarCopy = BaseTabBarController()
    var tableViewController = CategoryResultsTableViewController()
    var picFlag = false
    var favorite = false
    var preSelectedCat = String()

    // set outlets for artwork picture, description and title
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
    
    // set buttons to favorite, delete and update
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = tabBarController as! BaseTabBarController
        self.tabBarCopy = tabBar
        
        //update fields to true
        self.updatePIc.isHidden = true
        self.updateTiitle.isHidden = true
        self.camera.isHidden = true
        self.submit.isHidden = true
        self.updateDesc.isHidden = true
        self.updateTitleLabel.isHidden = true
        
        // set values for image, description and title
        artPicture.image = UIImage( data: localGallery!.img! as Data)
        artDescription.text = localGallery!.desc
        artTitle.text = localGallery!.title
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this function deletes the item from teh array
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        var alertController = UIAlertController()
        
        //Used the reference to the class with array and remove
        self.tabBarCopy.resultsDB.removeFromCoreDataArray(title: self.localGallery!.title!)
            
        //alert user it has been deleted
        alertController = UIAlertController(title: "Artpiece has been deleted!", message:"Redirecting back to Categories..." , preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
        // delays execution of code to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            alertController.dismiss(animated: false, completion: nil)
           self.performSegue(withIdentifier: "resDelete", sender: nil)
        })
    }
    
    
   // Favorite Button Pressed, adds item to Favorites Array
    @IBAction func makeFavoriteButtonPressed(_ sender: Any) {
        
        //alerts user item was favorited
        let falert = UIAlertController(title: "Favorite!", message:"You favorited this item." , preferredStyle: .alert)
        
         //Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
           // inserts new favorite to array
            self.tabBarCopy.resultsDB.faveResultInsert(title: self.artTitle.text!,favorited: true)//"true")
            print(self.artTitle.text!)
        })
        
        //Create cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button pressed")
        }
        
        //Add OK & Cancel to dialog message
        falert.addAction(ok)
        falert.addAction(cancel)
            
        self.present(falert, animated: true, completion: nil)

    }
  
    
    //update result
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
    
    //button for camera has been pressed
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
    
    //submit button has been pressed
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

    //This will hide the keyboard when the user clicks away on any part in the view on the app
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //dismiss keyboard when the user touches outside of the fields
        view.endEditing(true)
    }

}//NewContactViewController Class. This is the end of this file
