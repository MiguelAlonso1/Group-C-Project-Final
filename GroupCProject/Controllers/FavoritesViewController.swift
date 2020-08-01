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
import CoreData

// Displays table view of favorite artwork
class FavoritesViewController: UITableViewController, UINavigationControllerDelegate,UISearchDisplayDelegate, UISearchBarDelegate
{
    
    @IBOutlet var tblview: UITableView!
    
    //initialize search bar
    @IBOutlet weak var searchBar: UISearchBar!

    // create array for filtered results
    var filteredResults : [Results]!
    
    //This variable will hold a reference to the original CoreData array for logs in the database
    var tabBarCopy = BaseTabBarController()
    var categoryType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //Retrieve fave results array self.tabBarCopy.resultsDB.faveResultsCoreDataRetreival()
        
        //Search bar connected to delegate
        searchBar.delegate = self
        filteredResults = self.tabBarCopy.resultsDB.faveResultsArray

        //the local class variable is initialized with a copy of the original CoreData array for log entries
        let tabBar = tabBarController as! BaseTabBarController
        self.tabBarCopy = tabBar
        
        //set some Table view parameters to improve reading
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //this will run a fetch to get all data from CoreData; category parameters filters out the other categories
        self.tabBarCopy.resultsDB.faveResultsCoreDataRetreival()

        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //gets length from local class variable
        
        return filteredResults.count;
    }
    
    //loads array contact info into the cells
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaveResultsTableViewCell",for: indexPath) as! FaveResultsTableViewCell
        
        // set picture and title in cell
        cell.faveResultPicture.image = UIImage(data:filteredResults[indexPath.row].img! as Data)
        cell.faveResultTitle.text = filteredResults[indexPath.row].title
        
        return cell
    }
    
    //this branches off to either the Employee Edit View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Figure out which row was just tapped
        if let row = tableView.indexPathForSelectedRow?.row {
            // Get the item associated with this row and pass it along
            let item = self.tabBarCopy.resultsDB.faveResultsArray[row]
            //branch to the Detail View
            let artDetailViewController = segue.destination as! ArtDetailViewController
            //Pass reference to selected contact
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
            filteredResults = self.tabBarCopy.resultsDB.faveResultsArray
        } else {
             //filter items to display results associated with search text
            for item in self.tabBarCopy.resultsDB.faveResultsArray{
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

