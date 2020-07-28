//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 5
//  DUE: Sunday 07/12/2020

import UIKit

//This class stores a dictionary with the PINs and URLs

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

struct CategoryResult{
    var img = UIImage()
    var desc = String()
    var title = String()
    init (img: UIImage, desc: String, title: String){
        self.img = img
        self.desc = desc
        self.title = title
    }
    init(){
        self.desc = "No description"
        self.img = UIImage()
        self.title = "Title"
    }
}

class AppInMemoryDB {
    
    public var categoryTypesArray  = [CategoryType]()
    
    public var resultsCategoryArray  = [CategoryResult]()
    
     init() {
        self.categoryTypesArray.append(CategoryType(img:#imageLiteral(resourceName: "AndresMartinez"), desc: "Color Images"))
        
        self.resultsCategoryArray.append(CategoryResult(img:#imageLiteral(resourceName: "girl-leaves"), desc: "Oil Painting 1" ,title:"oil painting example 1"))
    }
    //add new object to dictionary
//    public func add (PIN: String, URL: String) -> Void {
//        self.PinBrowserDictionary [Int(PIN)!] = URL
//
//    }
//
//    public func getLength () -> Int {
//        return self.PinBrowserDictionary.count
//    }
//
//    public func isPINCorect (PIN: Int) -> Bool {
//        if self.PinBrowserDictionary [PIN] == nil{
//            return false
//        }
//        else{
//            return true
//        }
//
//    }
//
//    public func getURL (PIN: Int) -> String {
//        if self.PinBrowserDictionary [PIN] == nil{
//            return ""
//        }
//        else{
//            return self.PinBrowserDictionary [PIN]!
//        }
//
//    }
    
}
