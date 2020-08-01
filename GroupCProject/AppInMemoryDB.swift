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

//initialize category sections
struct CategoryType{
    var img = UIImage()
    var desc = String()
    init (img: UIImage, desc: String){
        self.img = img
        self.desc = desc
    }
    init(){
    self.desc = "No description"
        self.img = UIImage()
    }
}

//initialize variable for result displayed after category
struct CategoryResult{
    var img = UIImage()
    var desc = String()
    var title = String()
   var favorited = Bool()
    init (img: UIImage, desc: String, title: String){
        self.img = img
        self.desc = desc
        self.title = title
        self.favorited = false
    }
    init(){
        self.desc = "No description"
        self.img = UIImage()
        self.title = "Title"
        self.favorited = false
    }
}

// initialize arrays
class AppInMemoryDB {
    
    public var categoryTypesArray  = [CategoryType]()
    
    public var resultsCategoryArray  = [CategoryResult]()
    
    public var faveResultsArray = [CategoryResult]()
    
     init() {
        self.categoryTypesArray.append(CategoryType(img:#imageLiteral(resourceName: "AndresMartinez"), desc: "Color Images"))
        
        self.resultsCategoryArray.append(CategoryResult(img:#imageLiteral(resourceName: "girl-leaves"), desc: "Oil Painting 1" ,title:"oil painting example 1"))
        
        self.faveResultsArray.append(CategoryResult(img:#imageLiteral(resourceName: "girl-leaves"), desc: "Oil Painting 1" ,title:"oil painting example 1"))
    }

    
}
