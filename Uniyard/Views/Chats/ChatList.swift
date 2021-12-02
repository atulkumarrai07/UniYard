import SwiftUI
struct ChatList: View {
  @Environment(\.presentationMode) var chatPresentation: Binding<PresentationMode>
  
  @StateObject var chatsViewModel = ChatsViewModel()
  @State var isSearching = false
  @State private var query  = ""
  
  var body: some View {
     VStack{
       HStack {
          Text("Chats")
          .font(.largeTitle)
          .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          .fontWeight(.heavy)
          .frame(maxWidth: .infinity, alignment: .center)
       }
        HStack{
          HStack{
            TextField("Search chats here...", text: $query).padding(10)
          }.padding(.leading,40)
          .background(Color(red: 255/255.0, green: 192/255.0, blue: 190/255.0))
          .cornerRadius(10.0)
          .padding(.horizontal)
          .onChange(of: query, perform: {_ in
            isSearching = true
          })
          .overlay(
            HStack{
              Image(systemName: "magnifyingglass").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
              Spacer()
              if(isSearching) //need to change this
              {
                Button(action: {query = "" }, label: {
                  Image(systemName: "xmark.circle.fill").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
                    .padding()
                })
              }
            }.padding(.horizontal,30)
          )
        }
      if(chatsViewModel.getSortedFilteredChats(query: query).count > 0)
      {
        List{
          ForEach(chatsViewModel.getSortedFilteredChats(query: query))
          {chat in
            NavigationLink(
              destination: ChatView(chatsViewModel: chatsViewModel, chat: chat),
              label: {
                ChatRow(chat:chat)
              })
          }
        }.listStyle(PlainListStyle())
        .navigationTitle("Chats")
        .navigationBarItems(trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
          Image(systemName: "square.and.pencil")
        })
        Spacer()
      }
      else{
        Spacer()
        Text("No data available").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        Spacer()
      }
     }.navigationBarHidden(true)
     .onAppear{
      chatsViewModel.refreshChats()
     }
    
  }
}
struct ChatList_Previews: PreviewProvider {
  static var previews: some View {
    ChatList()
  }
}
