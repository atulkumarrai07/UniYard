import SwiftUI
struct ChatList: View {
  @Environment(\.presentationMode) var chatPresentation: Binding<PresentationMode>
  var body: some View {
     VStack{
     HStack {
        Text("Chats")
        .font(.largeTitle)
        .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        .fontWeight(.heavy)
        .frame(maxWidth: .infinity, alignment: .center).padding(.leading)
      
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
        Image(systemName: "square.and.pencil")
      })
     }.padding()
      
      List{
        ForEach(0..<10)
        {i in
          ChatRow()
        }
      }
      .listStyle(PlainListStyle())
      Spacer()
     }.navigationBarHidden(true)
    
  }
}
struct ChatList_Previews: PreviewProvider {
  static var previews: some View {
    ChatList()
  }
}
