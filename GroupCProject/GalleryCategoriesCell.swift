//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 6
//  DUE: Sunday 07/26/2020
//********************************************
// *********ADMIN PIN: 2077*******************
//********************************************

//this cell is for the employees list on the edit tab

import UIKit

class GalleryCategoriesCell: UITableViewCell {

    @IBOutlet weak var GalleryType: UILabel!
    @IBOutlet weak var GalleryTypePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()        // Initialization code
    }

   override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)

         //Configure the view for the selected state
    }

}
