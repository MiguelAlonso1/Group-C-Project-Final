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

//This Table View will display categories by default on a Table View
class CategoriesTableViewController: UITableViewController,UITextFieldDelegate, UINavigationControllerDelegate {
    
    //This variable holds reference to class with original Employess CoreData array
    var tabBarCopy = BaseTabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //holds reference to CoreData array
        let tabBar = tabBarController as! BaseTabBarController
        self.tabBarCopy = tabBar

        //set some Table view parameters to improve reading
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //this reload will display any new contact created by user from CoreData
        self.tabBarCopy.categoriesDB.categoriesCoreDataRetreival()
        
        tableView.reloadData()
    }
    
    // set process to segue to Category Results Table View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Set back button
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        // Figure out which row was just tapped
        if let row = tableView.indexPathForSelectedRow?.row {
        
        // Get the item associated with this row and pass it along
        let item = self.tabBarCopy.categoriesDB.categoriesArray[row]
        
        //branch to the Detail View
        let catResViewController = segue.destination as! CategoryResultsTableViewController
        
        //Pass reference to selected contact
        catResViewController.categoryType = item.categoryType!//pass gallery object
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
