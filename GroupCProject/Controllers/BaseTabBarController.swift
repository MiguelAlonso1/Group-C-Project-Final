//  PROGRAMMER: Miguel Alonso
//  PANTHERID: 2693267
//  CLASS: COP 465501 online Summer C
//  INSTRUCTOR: Steve Luis CASE 282
//  ASSIGNMENT: Programming Assignment 6
//  DUE: Sunday 07/26/2020
//********************************************
// *********ADMIN PIN: 2077*******************
//********************************************

import UIKit

//This controller stores references to the original arrays that use CoreData for the Employees list and the Time Log so that the other controllers can read them, write them and update them

class BaseTabBarController: UITabBarController {
//reference to data class that handles the CoreData for the employees
   
    var categoriesDB = CategoriesDatabase()
    var resultsDB = ResultsDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoriesDB.insertDummyCategory(img:#imageLiteral(resourceName: "blue-bjork"), categoryType: "Oil Paintings")
        self.categoriesDB.insertDummyCategory(img:#imageLiteral(resourceName: "img_6268"), categoryType: "Digital Art")
        self.categoriesDB.insertDummyCategory(img:#imageLiteral(resourceName: "gabriel-garcia-marquez"), categoryType: "Color Images")
        self.categoriesDB.insertDummyCategory(img:#imageLiteral(resourceName: "text-love"), categoryType: "Street Photography")
        self.categoriesDB.insertDummyCategory(img:#imageLiteral(resourceName: "tape-deck-geisha"), categoryType: "Drawings")
        
              /***********************************************************
                                    Color Images
              ************************************************************/
        self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "chainsss"), desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus pharetra augue non tempus. Morbi viverra, tortor in interdum porta, augue ex commodo dui, non hendrerit sapien eros quis turpis. Fusce pellentesque justo vitae ex mattis, ac tincidunt diam convallis. Nullam in ante id turpis luctus lacinia ut non ligula. Etiam cursus, ex a pharetra fermentum, velit elit consectetur velit, quis vestibulum tortor tortor maximus ex. Quisque facilisis lacus et ex tincidunt ultrices. Sed facilisis eget odio eget fringilla.", title:"Chainsss", categoryType: "ColorImages")
        
        self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "gabriel-garcia-marquez"), desc: "Maecenas faucibus blandit pulvinar. Donec rutrum dapibus dui sit amet consequat. Donec ut mauris in urna posuere ultricies at quis mi. In pellentesque neque nec est lobortis vulputate. Curabitur sagittis ex neque, at tincidunt tellus sollicitudin vel. Pellentesque sit amet nibh dolor. Phasellus bibendum urna nec mattis commodo. Ut felis nulla, accumsan in malesuada consequat, sagittis ut dolor. Phasellus placerat malesuada mi. Curabitur velit arcu, vulputate vitae urna sit amet, mollis convallis lacus. Nam nec lorem in arcu laoreet iaculis. Nullam suscipit a felis id mollis. Etiam dignissim eros et sodales pulvinar", title:"Gabo", categoryType: "Color Images")
        
        self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "donut-1"), desc: "Nunc aliquam condimentum commodo. In in sem eros. Maecenas malesuada nisl vel orci pulvinar tristique. Nunc sed lacinia magna. Nulla interdum pretium risus, quis condimentum elit faucibus a. Suspendisse lacinia facilisis egestas. In hac habitasse platea dictumst. Donec eu tellus quis leo commodo volutpat. Vestibulum felis nisi, interdum vitae tristique vel, auctor a purus. Nulla non nulla eget dui mattis gravida. Pellentesque mattis pretium metus ac consectetur.", title: "Donut",categoryType: "Color Images")
        
        /***********************************************************
                            Oil Paintings
         ************************************************************/
        
        self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "the-devil-you-know-2020"), desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus pharetra augue non tempus. Morbi viverra, tortor in interdum porta, augue ex commodo dui, non hendrerit sapien eros quis turpis. Fusce pellentesque justo vitae ex mattis, ac tincidunt diam convallis. Nullam in ante id turpis luctus lacinia ut non ligula. Etiam cursus, ex a pharetra fermentum, velit elit consectetur velit, quis vestibulum tortor tortor maximus ex. Quisque facilisis lacus et ex tincidunt ultrices. Sed facilisis eget odio eget fringilla.", title:"The Devil You Know", categoryType: "Oil Paintings")
        
        self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "blue-bjork"), desc: "Maecenas faucibus blandit pulvinar. Donec rutrum dapibus dui sit amet consequat. Donec ut mauris in urna posuere ultricies at quis mi. In pellentesque neque nec est lobortis vulputate. Curabitur sagittis ex neque, at tincidunt tellus sollicitudin vel. Pellentesque sit amet nibh dolor. Phasellus bibendum urna nec mattis commodo. Ut felis nulla, accumsan in malesuada consequat, sagittis ut dolor. Phasellus placerat malesuada mi. Curabitur velit arcu, vulputate vitae urna sit amet, mollis convallis lacus. Nam nec lorem in arcu laoreet iaculis. Nullam suscipit a felis id mollis. Etiam dignissim eros et sodales pulvinar", title:"Blue Bjork", categoryType: "Oil Paintings")
        
        self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "princess-2018"), desc: "Nunc aliquam condimentum commodo. In in sem eros. Maecenas malesuada nisl vel orci pulvinar tristique. Nunc sed lacinia magna. Nulla interdum pretium risus, quis condimentum elit faucibus a. Suspendisse lacinia facilisis egestas. In hac habitasse platea dictumst. Donec eu tellus quis leo commodo volutpat. Vestibulum felis nisi, interdum vitae tristique vel, auctor a purus. Nulla non nulla eget dui mattis gravida. Pellentesque mattis pretium metus ac consectetur.", title: "Princess 2020",categoryType: "Oil Paintings")
    

    /***********************************************************
                        Digital Art
     ************************************************************/
    
    self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "futbol-colombia-copy"), desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus pharetra augue non tempus. Morbi viverra, tortor in interdum porta, augue ex commodo dui, non hendrerit sapien eros quis turpis. Fusce pellentesque justo vitae ex mattis, ac tincidunt diam convallis. Nullam in ante id turpis luctus lacinia ut non ligula. Etiam cursus, ex a pharetra fermentum, velit elit consectetur velit, quis vestibulum tortor tortor maximus ex. Quisque facilisis lacus et ex tincidunt ultrices. Sed facilisis eget odio eget fringilla.", title:"Futbol Colombiano", categoryType: "Digital Art")
    
    self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "img_6268"), desc: "Maecenas faucibus blandit pulvinar. Donec rutrum dapibus dui sit amet consequat. Donec ut mauris in urna posuere ultricies at quis mi. In pellentesque neque nec est lobortis vulputate. Curabitur sagittis ex neque, at tincidunt tellus sollicitudin vel. Pellentesque sit amet nibh dolor. Phasellus bibendum urna nec mattis commodo. Ut felis nulla, accumsan in malesuada consequat, sagittis ut dolor. Phasellus placerat malesuada mi. Curabitur velit arcu, vulputate vitae urna sit amet, mollis convallis lacus. Nam nec lorem in arcu laoreet iaculis. Nullam suscipit a felis id mollis. Etiam dignissim eros et sodales pulvinar", title:"BLM", categoryType: "Digital Art")
    
    self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "madness-bus-"), desc: "Nunc aliquam condimentum commodo. In in sem eros. Maecenas malesuada nisl vel orci pulvinar tristique. Nunc sed lacinia magna. Nulla interdum pretium risus, quis condimentum elit faucibus a. Suspendisse lacinia facilisis egestas. In hac habitasse platea dictumst. Donec eu tellus quis leo commodo volutpat. Vestibulum felis nisi, interdum vitae tristique vel, auctor a purus. Nulla non nulla eget dui mattis gravida. Pellentesque mattis pretium metus ac consectetur.", title: "Madness Bus",categoryType: "Digital Art")

/***********************************************************
                        Drawings
 ************************************************************/

self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "pre-columbian-headphones"), desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus pharetra augue non tempus. Morbi viverra, tortor in interdum porta, augue ex commodo dui, non hendrerit sapien eros quis turpis. Fusce pellentesque justo vitae ex mattis, ac tincidunt diam convallis. Nullam in ante id turpis luctus lacinia ut non ligula. Etiam cursus, ex a pharetra fermentum, velit elit consectetur velit, quis vestibulum tortor tortor maximus ex. Quisque facilisis lacus et ex tincidunt ultrices. Sed facilisis eget odio eget fringilla.", title:"Chainsss", categoryType: "Drawings")

self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "tape-deck-geisha"), desc: "Maecenas faucibus blandit pulvinar. Donec rutrum dapibus dui sit amet consequat. Donec ut mauris in urna posuere ultricies at quis mi. In pellentesque neque nec est lobortis vulputate. Curabitur sagittis ex neque, at tincidunt tellus sollicitudin vel. Pellentesque sit amet nibh dolor. Phasellus bibendum urna nec mattis commodo. Ut felis nulla, accumsan in malesuada consequat, sagittis ut dolor. Phasellus placerat malesuada mi. Curabitur velit arcu, vulputate vitae urna sit amet, mollis convallis lacus. Nam nec lorem in arcu laoreet iaculis. Nullam suscipit a felis id mollis. Etiam dignissim eros et sodales pulvinar", title:"Pre-Colombian Headphones", categoryType: "Drawings")

self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "count-basie2"), desc: "Nunc aliquam condimentum commodo. In in sem eros. Maecenas malesuada nisl vel orci pulvinar tristique. Nunc sed lacinia magna. Nulla interdum pretium risus, quis condimentum elit faucibus a. Suspendisse lacinia facilisis egestas. In hac habitasse platea dictumst. Donec eu tellus quis leo commodo volutpat. Vestibulum felis nisi, interdum vitae tristique vel, auctor a purus. Nulla non nulla eget dui mattis gravida. Pellentesque mattis pretium metus ac consectetur.", title: "Count Basie",categoryType: "Drawings")



/***********************************************************
                Street Photography
 ************************************************************/

self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "text-love"), desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus pharetra augue non tempus. Morbi viverra, tortor in interdum porta, augue ex commodo dui, non hendrerit sapien eros quis turpis. Fusce pellentesque justo vitae ex mattis, ac tincidunt diam convallis. Nullam in ante id turpis luctus lacinia ut non ligula. Etiam cursus, ex a pharetra fermentum, velit elit consectetur velit, quis vestibulum tortor tortor maximus ex. Quisque facilisis lacus et ex tincidunt ultrices. Sed facilisis eget odio eget fringilla.", title:"Text Love", categoryType: "Street Photography")

self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "img_9389-2"), desc: "Maecenas faucibus blandit pulvinar. Donec rutrum dapibus dui sit amet consequat. Donec ut mauris in urna posuere ultricies at quis mi. In pellentesque neque nec est lobortis vulputate. Curabitur sagittis ex neque, at tincidunt tellus sollicitudin vel. Pellentesque sit amet nibh dolor. Phasellus bibendum urna nec mattis commodo. Ut felis nulla, accumsan in malesuada consequat, sagittis ut dolor. Phasellus placerat malesuada mi. Curabitur velit arcu, vulputate vitae urna sit amet, mollis convallis lacus. Nam nec lorem in arcu laoreet iaculis. Nullam suscipit a felis id mollis. Etiam dignissim eros et sodales pulvinar", title:"Outdoors", categoryType: "Street Photography")

self.resultsDB.insertDummyResult(img:#imageLiteral(resourceName: "crossing-ne-3rd-st"), desc: "Nunc aliquam condimentum commodo. In in sem eros. Maecenas malesuada nisl vel orci pulvinar tristique. Nunc sed lacinia magna. Nulla interdum pretium risus, quis condimentum elit faucibus a. Suspendisse lacinia facilisis egestas. In hac habitasse platea dictumst. Donec eu tellus quis leo commodo volutpat. Vestibulum felis nisi, interdum vitae tristique vel, auctor a purus. Nulla non nulla eget dui mattis gravida. Pellentesque mattis pretium metus ac consectetur.", title: "Crossing NE 3rd Street",categoryType: "Street Photography")
}//end viewDidLoad()
}
