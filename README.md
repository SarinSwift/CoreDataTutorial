# Core Data 

## Steps to CRUD in Core Data

## Build out the core data model 
1. Add a new data model file  
And name it whatever model we would want to save in our database  
2. Create an entity  
Entity is mapping between a database table and a Swift type(class)  
3. Add attributes to the entity  
All data models make all the added attributes optional by default. But we can set this to non optional in the DataModelInspector.
Declaring attributes in the entity to be transformable will allow Core data to convert the objects into a type it can store. BUT be sure to let our transformable to conform to NSCoding protocol 

## Create the Managed Object
1. Let core data auto generate the managed object subclass  
- Selecting the entity and changing codegen under class  
- Then create an NSManagedObject subclass  
Our properties in here can be optional but then we must initialize our attributes in awakeFromInsert()

## Build the core data stack!
Let’t talk about the core data models and stack vocabulary:  
**NSPersistentContainer** - all objects needed to represent a functioning core data stack  
**ManagedObjectModel** - Describes the entities in the stores  
**PersistentStoreCoordinator** - Aggregates all the stores  
**ManagedObjectContext** - Object to create and fetch all managed objects and to manage undo and redo operations  

[image of diagram of core data stack relating to each other]

1. Create the NSPersistentContainer  
	Let persistentContainer  = NSPersistentContainer(name: “LoanedItems”)  
Must notice that the name is the same as our data model  
2. Instantiate an ItemStore object  
We should do this in appDelegate to ensure that our corer data stack is accessible from the moment the app launches! AND we have only 1 instance of the NSPersistentContainer, the ManagedObjectContext, etc.  

## Implement saving data
Most interactions will happen through an instance of NSManagedObjectContext  
To save any changes in memory back to the database we’ll have to call the save method on the viewContext property.  
Steps to save:  
- create the viewContext from calling persistentContainer.viewConext  
- go in a do try catch and try viewContext.save() 

## Implement fetching data
1. Create our NSFetchRequest on out Item model saved in core data  
2. Then we can call viewContext.fetch(our fetch request we just created) in the do try catch block  
This fetching is crucial if we want to see the items that we saved show up because we have to have a way of showing the data once we have saved to core data  

## Implement deleting data
1. Delete from our context by calling viewContext.delete(item)  
2. Delete from the data source (array of our saved items that are populated in a collection view/table view)  
3. Save the context after deleting it.  


