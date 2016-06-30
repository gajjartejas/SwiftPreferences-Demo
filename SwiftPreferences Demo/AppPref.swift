//
//  AppPref.swift
//  Extensions
//
//  Created by tejas on 20/05/16.
//  Copyright © 2016 Credencys. All rights reserved.
//

import UIKit

class AppPref: NSObject,NSCoding {
    
    var filePath:NSURL?
    
    var userId:NSString?
    var userEmail:NSString?
    var username:NSString?
    
    override init() {
        
        super.init()
        
        filePath = nil
        
        userId = nil
        userEmail = ""
        username = ""
    }

    class func loadFrom(fileName:NSString)-> AppPref?  {
        
        // load your custom object from the file
        if let temp = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(fileName).path!) {
            return temp as? AppPref
        } else {
            return nil
        }
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    required convenience init?(coder aDecoder: NSCoder)
    {
        self.init()
        
        userId = aDecoder.decodeObjectForKey("userId") as? String
        userEmail = aDecoder.decodeObjectForKey("userEmail") as? String
        username = aDecoder.decodeObjectForKey("username") as? String
        filePath = aDecoder.decodeObjectForKey("filePath") as? NSURL
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encodeWithCoder(aCoder: NSCoder)
    {
        if userId != nil{
            aCoder.encodeObject(userId, forKey: "userId")
        }
        if userEmail != nil{
            aCoder.encodeObject(userEmail, forKey: "userEmail")
        }
        if username != nil{
            aCoder.encodeObject(username, forKey: "username")
        }
        if filePath != nil{
            aCoder.encodeObject(filePath, forKey: "filePath")
        }
    }
    
   class func filePath(fileName : NSString) -> NSURL {
        
        let paths = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        
        let getImagePath = paths.URLByAppendingPathComponent(fileName as String)
        
        return getImagePath
    }
    
    func save(toFileName:NSString)-> Bool {
        
        let file = AppPref.filePath(toFileName)
        
        filePath = file
        
        // save your custom object in a file
        let isPrefSaved =  NSKeyedArchiver.archiveRootObject(self, toFile: file.path!)
        
        return isPrefSaved
    }
    
    func clear()-> Bool {
        
        if NSFileManager.defaultManager().fileExistsAtPath((self.filePath?.path)!) {
            
            if (try?NSFileManager.defaultManager().removeItemAtURL(self.filePath!)) == nil {
                
                print("failed")
                
                return false
            }
        }
        
        return false
    }
}