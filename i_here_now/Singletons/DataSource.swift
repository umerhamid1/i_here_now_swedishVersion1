

import Foundation

final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var tasks: [Task] = []
    
    var intervalCount = 0
    
    var userIsOnBreak = false
    
    let manager = FileManager.default //FileManager manages file and folders in your app
    //documentDirectory is the recommended place to store things
    
    //creates a path to where we are storing our data
    var filePath: String {
        
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first //this returns an array of urls and we get the first url
        return url!.appendingPathComponent("TasksData").path //this returns a url path component (create a new path component and put our data on this path)
    }
    
    func addAndSaveTaskData(task: Task) {
        self.tasks.append(task)
        //this finds our encode (saves) function, passes this to our goals class and finds the "encode" function, then encodes the values for the keys and it will save it to our filepath
        saveTaskData()
    }
    
    func saveTaskData() {
        NSKeyedArchiver.archiveRootObject(self.tasks, toFile: filePath)
    }
    
    func loadTaskData() {
        //check if we can get our data as a Task array and if so, we assign it to our tasks array
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Task] {
            self.tasks = ourData
        }
    }
    
    func deleteAndSaveTaskData(at index: Int) {
        self.tasks.remove(at: index)
        NSKeyedArchiver.archiveRootObject(self.tasks, toFile: filePath)
    }
    
}



























