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

// This class creates the Gallery Categories Cell for the Table View
class GalleryCategoriesCell: UITableViewCell {

    // set outlets for gallery 
    @IBOutlet weak var GalleryType: UILabel!
    @IBOutlet weak var GalleryTypePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

   override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)

         //Configure the view for the selected state
    }

}
