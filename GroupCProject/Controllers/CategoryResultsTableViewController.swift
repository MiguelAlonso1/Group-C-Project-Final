//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 6
//  DUE: Sunday 07/26/2020

import UIKit

    //This Table View will display the log entries for employees
    // it calls functions on the time log data class to insert and update log entries
class CategoryResultsTableViewController:UITableViewController,UITextFieldDelegate, UINavigationControllerDelegate
{
//    //This variable will hold a reference to the original CoreData array for logs in the database
    var tabBarCopy = BaseTabBarController()
   var categoryType = String()
        override func viewDidLoad() {
           super.viewDidLoad()
            //the local class variable is initialized with a copy of the original CoreData array for log entries
         let tabBar = tabBarController as! BaseTabBarController
         self.tabBarCopy = tabBar

            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 6000

           //set some Table view parameters to improve reading
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 65
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //this will run a fetch to get all data from CoreData; category parameters filters out the other kategories
        self.tabBarCopy.resultsDB.resultsCoreDataRetreival(categoryType: self.categoryType)

        //after a new log entry, sort the array alphabetically by last name
//        self.tabBarCopy.resultsDB.resultsArray.sort {
//            $0.title! < $1.title!
//       }
        //reload table view for possible new log entry
       tableView.reloadData()
   }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //gets length from local class variable
        return self.tabBarCopy.resultsDB.resultsArray.count
        }

    //loads array contact info into the cells
        override func tableView(_ tableView: UITableView,
                                cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            // Create an instance of UITableViewCell, with default appearance
          let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell",for: indexPath) as! ResultsTableViewCell
            
            cell.resultPicture.image = UIImage(data:self.tabBarCopy.resultsDB.resultsArray[indexPath.row].img! as Data)
            cell.resultTitle.text = self.tabBarCopy.resultsDB.resultsArray[indexPath.row].title
            return cell
        }

    //this branches off to either the Employee Edit View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Figure out which row was just tapped
       if let row = tableView.indexPathForSelectedRow?.row {
            // Get the item associated with this row and pass it along
            let item = self.tabBarCopy.resultsDB.resultsArray[row]
            //branch to the Detail View
            let editEmpViewController = segue.destination as! ArtDetailViewController
           //Pass reference to selected contact
            editEmpViewController.localGallery = item//pass gallery object
        }
       else{
         let addRes = segue.destination as! NewResultViewController
         addRes.preSelectedCat = self.categoryType
        }
    }//end prepare

}
