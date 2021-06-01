//
//  Model.swift
//  ToDoList
//
//  Created by Стас Чебыкин on 18.02.2020.
//  Copyright © 2020 Стас Чебыкин. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

var ToDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
        sendBadge()
    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false){
    ToDoItems.append(["Name": nameItem, "isCompleted": isCompleted])
    sendBadge()
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
    sendBadge()
}

func changeState(at item: Int) -> Bool{
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    sendBadge()
    return ToDoItems[item]["isCompleted"] as! Bool
}

func moveItemFrom(fromIndex: Int, toIndex: Int){
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}

func requestForNotification(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
      
    }
}

func sendBadge(){
    var totalBadgeNumber = 0
    for item in ToDoItems{
        if item["isCompleted"] as? Bool == false{
            totalBadgeNumber+=1
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
    
}
