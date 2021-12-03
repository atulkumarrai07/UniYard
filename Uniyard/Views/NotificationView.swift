import SwiftUI
import UserNotifications

struct NotificationView: View {
  @StateObject var notificationViewModel = NotificationViewModel()
 var body: some View {
   ZStack{
    VStack{
    HStack {
       Text("Notifications")
       .font(.largeTitle)
       .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
       .fontWeight(.heavy)
       .frame(maxWidth: .infinity, alignment: .center)
      }
     Text("This is the notifications view").bold()
      Button(action: {notificationViewModel.createANotification()}, label: {
        Text("Request Permission") })
        .onAppear(perform: {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
              
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
          UNUserNotificationCenter.current().delegate = notificationViewModel
        })
     Spacer()
    }
   }.navigationBarHidden(true)
 }
}
struct NotificationView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationView()
  }
}
