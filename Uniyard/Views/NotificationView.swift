import SwiftUI
struct NotificationView: View {
 var body: some View {
  NavigationView {
   ZStack{
    VStack{
    HStack {
       Button(action: {})
       {
       Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
       }
       Text("Notifications")
       .font(.largeTitle)
       .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
       .fontWeight(.heavy)
       .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
      }
     Text("This is the notifications view").bold()
     Spacer()
    }
   }.navigationBarHidden(true)
  }
 }
}
struct NotificationView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationView()
  }
}
