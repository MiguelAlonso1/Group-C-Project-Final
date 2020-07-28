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

//This Table View will display 4 contacts by default on a Table View
class CategoriesTableViewController: UITableViewController,UITextFieldDelegate, UINavigationControllerDelegate {
    
    //This variable holds reference to class with original Employess CoreData array
    var tabBarCopy = BaseTabBarController()

    //set some Table view parameters to improve reading
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //holds reference to CoreData array
        let tabBar = tabBarController as! BaseTabBarController
        self.tabBarCopy = tabBar

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //this reload will display any new contact created by user from CoreData
        self.tabBarCopy.categoriesDB.categoriesCoreDataRetreival()
        
        //sort array alphabetically
      //  self.tabBarCopy.employeeList.employeeCoreDataArray.sort {
        //      $0.lastName! < $1.lastName!
        //}
         //load local array from CoreData
         tableView.reloadData()
    }
    
    //this branches off to either the Employee Edit View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        // Figure out which row was just tapped
        if let row = tableView.indexPathForSelectedRow?.row {
            // Get the item associated with this row and pass it along
        let item = self.tabBarCopy.categoriesDB.categoriesArray[row]
            //branch to the Detail View
            let editEmpViewController = segue.destination as! CategoryResultsTableViewController
            //Pass reference to selected contact
            editEmpViewController.categoryType = item.categoryType!//pass gallery object
        }
    }//end prepare

    
    //Tells the Table View how many rows to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tabBarCopy.categoriesDB.categoriesArray.count
    }
    
    //loads array contact info into the cells
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCategoriesCell",
                                                 for: indexPath) as! GalleryCategoriesCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = self.tabBarCopy.categoriesDB.categoriesArray[indexPath.row]
        
        //Load cell
        cell.GalleryType.text = item.categoryType
        cell.GalleryTypePic.image = UIImage(data:item.img! as Data)
        
        return cell
    }
}
