import SwiftUI
struct NotificationView: View {
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
