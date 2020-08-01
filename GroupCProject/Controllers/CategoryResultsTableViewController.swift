//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  PROGRAMMER: Diane Abdullah
//  PANTHERID: 4892489
//  PROGRAMMER: Kenny Gonzalez Mejia
//  PANTHER ID:3963603
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Deliverable 2
//  DUE: Saturday 08/01/2020

import UIKit
import CoreData

//This Table View will display the artwork by category
class CategoryResultsTableViewController:UITableViewController,UITextFieldDelegate, UINavigationControllerDelegate, UISearchDisplayDelegate, UISearchBarDelegate {
    
    //initialize search bar
    @IBOutlet weak var searchBar: UISearchBar!
    
    //create array for filtered results
    var filteredResults : [Results]!
    
    //This variable will hold a reference to the original CoreData array for logs in the database
    var tabBarCopy = BaseTabBarController()
    var categoryType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
         //Search bar connected to delegate
        searchBar.delegate = self
        filteredResults = self.tabBarCopy.resultsDB.resultsArray
        
        //the local class variable is initialized with a copy of the original CoreData array for log entries
        let tabBar = tabBarController as! BaseTabBarController
        self.tabBarCopy = tabBar

        //set some Table view parameters to improve reading
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 6000
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //this will run a fetch to get all data from CoreData; category parameters filters out the other categories
        self.tabBarCopy.resultsDB.resultsCoreDataRetreival(categoryType: self.categoryType)

        //reload table view
        tableView.reloadData()
   }

    //displays the correct amount of cells by getting length from local class variable
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return filteredResults.count
        //return self.tabBarCopy.resultsDB.resultsArray.count
    }

    //loads array contact info into the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell",for: indexPath) as! ResultsTableViewCell
        
        //set picture and title in each cell
        cell.resultPicture.image = UIImage(data:filteredResults[indexPath.row].img! as Data)
        cell.resultTitle.text = filteredResults[indexPath.row].title
        //cell.resultPicture.image = UIImage(data:self.tabBarCopy.resultsDB.resultsArray[indexPath.row].img! as Data)
        //cell.resultTitle.text = self.tabBarCopy.resultsDB.resultsArray[indexPath.row].title
        
        return cell
    }

    //this branches off to the Art Detail View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Figure out which row was just tapped
       if let row = tableView.indexPathForSelectedRow?.row {
            // Get the item associated with this row and pass it along
            let item = self.tabBarCopy.resultsDB.resultsArray[row]
        
            //branch to the Detail View
            let artDetailViewController = segue.destination as! ArtDetailViewController
        
            //Pass reference to selected item
            artDetailViewController.localGallery = item//pass gallery object
       }
       else{
         let addRes = segue.destination as! NewResultViewController
         addRes.preSelectedCat = self.categoryType
        }
    }//end prepare

    
    //MARK: Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        filteredResults = []
        
        if searchText == "" {
                //while no text in search bar, display all items
                filteredResults = self.tabBarCopy.resultsDB.resultsArray
        } else {
                //filter items to display results associated with search text
                for item in self.tabBarCopy.resultsDB.resultsArray{
                    if item.title!.lowercased().contains(searchText.lowercased()){
                        filteredResults.append(item)
                    }
                }
            }
        // reload data
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

