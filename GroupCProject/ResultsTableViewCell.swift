//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 6
//  DUE: Sunday 07/26/2020
//********************************************
// *********ADMIN PIN: 2077*******************
//********************************************

//this is the class for the cell use in time log entries
import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resultPicture: UIImageView!
    @IBOutlet weak var resultTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
