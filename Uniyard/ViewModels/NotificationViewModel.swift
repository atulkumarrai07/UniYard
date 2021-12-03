import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class NotificationViewModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
  
  func createANotification(){
    let content = UNMutableNotificationContent()
    content.title = "New Notification!"
    content.subtitle = "Atul messaged you regarding Lamp"
    content.sound = UNNotificationSound.default
    content.categoryIdentifier = "ACTIONS"

    // show this notification five seconds from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    let close = UNNotificationAction(identifier: "CLOSE", title:"Close", options: .destructive)
    let category = UNNotificationCategory(identifier: "ACTIONS", actions: [close], intentIdentifiers: [], options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])
    // add our notification request
    UNUserNotificationCenter.current().add(request)
  }
  
//  func fetchNotificationSettings() {
//    // 1
//    UNUserNotificationCenter.current().getNotificationSettings { settings in
//      // 2
//      DispatchQueue.main.async {
//        self.settings = settings
//      }
//    }
//  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.badge,.banner,.sound])
  }
}
