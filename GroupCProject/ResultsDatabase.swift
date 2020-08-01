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

//This class stores a CoreData array for Results and fuctions to process data
class ResultsDatabase: NSObject {
    
    public var resultsArray = [Results]()
    public var faveResultsArray = [Results]()
    
    //this removes dups
    public func removeFromCoreDataArray (title: String) -> Void {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Results")
        
        deleteFetch.predicate = NSPredicate.init( format: "title=='\(title)'")
  
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print (title + " successfully deleted from CoreData")
        } catch {
            print ("There was an error deleting the Results object from CoreData")
        }
    }
    
    // gets result from array and sets temp title
    public func getResult (title: String) -> Results? {
        for temp in self.resultsArray{
            if temp.title == title {
                return temp// probably returning a copy; not a reference to the original object
            }
        }
        return nil
    }
    
    //insert to CoreData
    func coreDataResultInsert(img:UIImage, desc:String, title:String, categoryType: String)-> Void{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let temRes = NSEntityDescription.insertNewObject(forEntityName: "Results", into: managedContext)
        
        let imgData = UIImagePNGRepresentation(img)
        temRes.setValue(imgData, forKey: "img")
        temRes.setValue(desc, forKey: "desc")
        temRes.setValue(title, forKey: "title")
        temRes.setValue(categoryType, forKey: "categoryType")
        
        do {
            try managedContext.save()
            print("Saved sucessfully")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }//end CoreDataInsert function
    
    //load records from CoreData to  local array
    func resultsCoreDataRetreival(categoryType:String)->Void{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        print("SQLite location: \(String(describing: appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url))")
        
        let entity = NSEntityDescription.entity(forEntityName: "Results", in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        
        let predicate = NSPredicate(format: "categoryType==%@", categoryType)
        
        request.predicate = predicate
        
        do {
            self.resultsArray = try managedContext.fetch(request) as! [Results]//update results in memory array
            print("Retreival from CoreData successfull")
        } catch let error as NSError {
            print("Could retreive. \(error), \(error.userInfo)")
        }
        
    }//end CoreDataRetreival func
    
    
    //insert fave to CoreData
    func faveResultInsert(title:String,favorited: Bool)->Void{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Results", in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        
        let predicate = NSPredicate.init(format: "title == '\(title)'")
        
        request.predicate = predicate
        
        do{
            var results = try managedContext.fetch(request)
            
            let objectUpdate = results[0] as! NSManagedObject
            
            objectUpdate.setValue(favorited, forKey: "favorited")
            try managedContext.save()
            print("added to favorites")
        }catch let error as NSError {
            print("error updating Favorites \(error)")
        }
        
    }//end CoreDataInsert function
    
    //load records from CoreData to  local array
    func faveResultsCoreDataRetreival()->Void{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        print("SQLite location: \(String(describing: appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url))")
        
        let entity = NSEntityDescription.entity(forEntityName: "Results", in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        
        // let predicate = NSPredicate(format: "favorited==%@", true)
        let predicate = NSPredicate(format: "favorited == %d", true)
        request.predicate = predicate
        
        do {
            self.faveResultsArray = try managedContext.fetch(request) as! [Results]//update results in memory array
            print("Fave Retreival from CoreData successfull")
            print(self.faveResultsArray)
        } catch let error as NSError {
            print("Could retreive. \(error), \(error.userInfo)")
        }
        
    }//end CoreDataRetreival func
    
    //load dummy records for testing app
    func insertDummyResult(img:UIImage, desc:String, title:String, categoryType:String)-> Void{
        var tempArray  = [Results]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Results>(entityName: "Results")
        
        do {
            tempArray = try managedContext.fetch(fetchRequest)//update emp array
            //print("Retreival from CoreData successfull")
        } catch let error as NSError {
            print("Could retreive. \(error), \(error.userInfo)")
        }
        for item in tempArray{
            if item.title == title{//if this dummy data is already in CoreData, don't insert it again
                return
            }
        }//end for
        
        //not in CoreData, insert it
        let temRes = NSEntityDescription.insertNewObject(forEntityName: "Results", into: managedContext)
        
        let imgData = UIImagePNGRepresentation(img)
        temRes.setValue(imgData, forKey: "img")
        temRes.setValue(desc, forKey: "desc")
        temRes.setValue(title, forKey: "title")
        temRes.setValue(categoryType, forKey: "categoryType")
        
        do {
            try managedContext.save()
            
            print("Saved sucessfully")
            return } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                return
        }
    }
    
    
    //find and update record in CoreData
    public func updateResult(oldTitle:String,oldCat:String,img:UIImage,title:String,desc: String,categoryType: String)-> Void{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Results", in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        
        //let predicate = NSPredicate(format: "categoryType=='%@' AND title=='%@'", oldCat, oldTitle)
        let predicate = NSPredicate.init( format: "categoryType=='\(oldCat)' AND title=='\(oldTitle)'")
        
        request.predicate = predicate
        
        do{
            var results = try managedContext.fetch(request)
            
            let objectUpdate = results[0] as! NSManagedObject
            
            let imgData = UIImagePNGRepresentation(img)
            objectUpdate.setValue(imgData, forKey: "img")
            // objectUpdate.setValue(categoryType, forKey: "categoryType")//Cat should remain the same;no update allowed
            
            objectUpdate.setValue(title, forKey: "title")
            objectUpdate.setValue(desc, forKey: "desc")
            
            try managedContext.save()
            
        }catch let error as NSError {
            print("error updating Categories \(error)")
        }
    }
}
