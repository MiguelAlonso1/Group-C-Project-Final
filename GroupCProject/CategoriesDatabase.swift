//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 6
//  DUE: Sunday 07/26/2020


import UIKit
import CoreData

//This class stores a CoreData array for TimeLog entries and fuctions to process data

class CategoriesDatabase: NSObject {
    
    public var categoriesArray  = [Categories]()
    
    //insert in CoreData
    func coreDataCategoryInsert(img:UIImage,categoryType: String)-> Void{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let temCat = NSEntityDescription.insertNewObject(forEntityName: "Categories", into: managedContext)
        let imgData = UIImagePNGRepresentation(img)
        temCat.setValue(imgData, forKey: "img")
        temCat.setValue(categoryType, forKey: "categoryType")
    
        do {
            try managedContext.save()
            print("Saved sucessfully")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }//end CoreDataInsert function
    
 //load records from CoreData to  local array
    func categoriesCoreDataRetreival()->Void{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        print("SQLite location: \(String(describing: appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url))")
        
        let fetchRequest = NSFetchRequest<Categories>(entityName: "Categories")
        
        do {
            self.categoriesArray = try managedContext.fetch(fetchRequest)//update emp array
            print("Retreival from KoreData successfull")
        } catch let error as NSError {
            print("Could retreive. \(error), \(error.userInfo)")
        }
        
    }//end categoriesCoreDataRetreival func
    
    //load dummy records for testing app
    func insertDummyCategory(img:UIImage,categoryType: String)-> Void{
        var tempArray  = [Categories]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Categories>(entityName: "Categories")
        
        do {
            tempArray = try managedContext.fetch(fetchRequest)//update emp array
            print("Retreival from KoreData successfull")
        } catch let error as NSError {
            print("Could retreive. \(error), \(error.userInfo)")
        }
        for item in tempArray{
            if item.categoryType == categoryType {//if this dummy data is already in KoreData, don't insert it again
                return
            }
        }//end for
        
        //not in KoreData, insert it
        let temCat = NSEntityDescription.insertNewObject(forEntityName: "Categories", into: managedContext)
        
        let imgData = UIImagePNGRepresentation(img)
        temCat.setValue(imgData, forKey: "img")
        temCat.setValue(categoryType, forKey: "categoryType")
        
        do {
            try managedContext.save()
            
            print("Saved sucessfully")
            return} catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                return
        }
    }//end testCoreDataInsert function
    
    
    //find and update record in CoreData
    public func updateCategory(img:UIImage,categoryType: String)-> Void{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Categories", in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
       
        let predicate = NSPredicate(format: "categoryType==%@", categoryType)
 
        request.predicate = predicate
       
        do{
            var results = try managedContext.fetch(request)
        
            let objectUpdate = results[0] as! NSManagedObject
            
            let imgData = UIImagePNGRepresentation(img)
            objectUpdate.setValue(imgData, forKey: "img")
            objectUpdate.setValue(categoryType, forKey: "categoryType")

            try managedContext.save()
               
            }catch let error as NSError {
        print("error updating Categories \(error)")
            }
        }
}//end class
