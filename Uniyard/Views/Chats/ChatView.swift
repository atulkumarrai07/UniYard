
import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI
import FirebaseAuth

struct ChatView: View {
  
  @StateObject var chatsViewModel: ChatsViewModel
  @State var chat:Chat
  @State private var text = ""
//  @FocusState private var isFocused
  
  @Environment(\.presentationMode) var chatPresentation: Binding<PresentationMode>
  
  @State private var messageIdToScroll: String?                     // modified datatype to string
  
    var body: some View {
      VStack(spacing:0){
        HStack{
          Button(action: {
           self.chatPresentation.wrappedValue.dismiss()
          }){
           Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          }
          if(chat.user2.user_image == ""){
            Image(systemName: "person.crop.circle").resizable().frame(width: 40, height: 40).clipShape(Circle()).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          }
          else{
            WebImage(url: URL(string: chat.user2.user_image)).resizable().frame(width: 40, height: 40).clipShape(Circle())
          }
          Text(chat.user2.first_name + " " + chat.user2.last_name)
            .bold()
            .foregroundColor(.black)
          .fontWeight(.heavy)
          .frame(maxWidth: .infinity, alignment: .center)
        }.padding(.horizontal) // HStack
        if(chat.messages.count != 0){
          GeometryReader{reader in
            ScrollView{
              ScrollViewReader{scrollReader in
                getMessagesView(viewWidth: reader.size.width)
                  .padding(.horizontal)
                  .onChange(of: messageIdToScroll) { _ in
                    if let messageID = messageIdToScroll{
                      scrollTo(messageId: messageID, shouldAnimate: true, scrollReader: scrollReader)
                    }
                  }
                  .onAppear{
                    if let messageId = chat.messages.last?.id{
                      scrollTo(messageId: messageId, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                    }
                  }
              }
            }
          }.padding(.bottom, 5)
        }
        else{
          Spacer()
          Text("Start a new conversation!").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          Spacer()
        }
        Spacer()
        toolbarView()
      }.padding(.top, 1) //VStack
      .onAppear{
        chatsViewModel.markAsRead(false, chat: chat)
        let viewModel = ViewModel()
        let auth = Auth.auth()
        viewModel.fetchChats(currentUserID: auth.currentUser!.uid){results in
          let chats = results
          if(chats.filter({existingChat in return existingChat.id == chat.id}).count > 0){
            let indexOfCurrentChat = chats.firstIndex(where: { $0.id == chat.id })
            self.chat.messages = chats[indexOfCurrentChat!].messages
            messageIdToScroll = self.chat.messages.last?.id
          }
        }
//        viewModel.fetchMessagesForChatView(chatId: chat.id){messages in
//          chat.messages = messages
//        }
        
//        chatsViewModel.refreshChats()
//        let index = chatsViewModel.chats.firstIndex(where: { $0.id == chat.id })
//        chat = chatsViewModel.chats[index!]
      }
    }
  
  func scrollTo(messageId: String, anchor: UnitPoint? = nil, shouldAnimate:Bool, scrollReader: ScrollViewProxy) {     // modified message id data type
    DispatchQueue.main.async {
      withAnimation(shouldAnimate ? Animation.easeIn:nil){
        scrollReader.scrollTo(messageId,anchor: anchor)
      }
    }
  }
  
  func toolbarView() -> some View {
    VStack{
      let height: CGFloat = 37
      HStack{
        TextField("Message...", text: $text)
          .padding(.horizontal)
          .frame(height: height)
          .background(Color.white)
          .clipShape(RoundedRectangle(cornerRadius: 13))
//          .focused($isFocused)
        Button(action:{sendMessage()}){
          Image(systemName: "paperplane.fill")
            .foregroundColor(.white)
            .frame(width: height, height: height)
            .background(
              Circle()
                .foregroundColor(text.isEmpty ? .gray: .blue))
        }
        .disabled(text.isEmpty )
      }
      .frame(height: height)
    }.padding(.vertical)
    .padding(.horizontal)
    .background(Color.black.opacity(0.1))
    
  }
  
  func sendMessage() {
//    let countBefore = chat.messages.count
    chatsViewModel.sendMessage(text, in: chat){message in
      text = ""
      chatsViewModel.refreshChats()
      if(chatsViewModel.chats.filter({existingChat in return existingChat.id == chat.id}).count > 0){
        let indexCheck = chatsViewModel.chats.firstIndex(where: {$0.id == chat.id})
  //      print(chatsViewModel.chats[indexCheck!])
        self.chat = chatsViewModel.chats[indexCheck!]
        messageIdToScroll = message.id
      }
    }
  }
  
  let columns = [GridItem(.flexible(minimum: 10))]
  
  func getMessagesView(viewWidth: CGFloat) -> some View {
    LazyVGrid(columns: columns, spacing: 0, pinnedViews: [.sectionHeaders]){
      let sectionMessages = chatsViewModel.getSectionMessages(for: chat)
      ForEach(sectionMessages.indices, id: \.self) { sectionIndex in
        let messages = sectionMessages[sectionIndex]
        Section(header: sectionHeader(firstMessage: messages.first!)){
          ForEach(messages){message in
            let isReceived = message.type == .Received
            HStack{
              ZStack{
                Text(message.text)
                  .padding(.horizontal)
                  .padding(.vertical, 12)
                  .foregroundColor(isReceived ? .black : .white)
                  .background(isReceived ? Color.black.opacity(0.2):Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 0.9))
                  .cornerRadius(13)
              }
              .frame(width:viewWidth * 0.7, alignment: isReceived ? .leading:.trailing)
              .padding(.vertical,7)
    //          .background(Color.blue)
            }
            .frame(maxWidth:.infinity,alignment: isReceived ? .leading:.trailing)
            .id(message.id)
          } // forEach
        }
      } // forEach
    }
  }
  
  func sectionHeader(firstMessage message: Message) -> some View {
    ZStack{
      Text(message.date.descriptiveString(dateStyle: .medium))
        .foregroundColor(.white)
        .font(.system(size: 14, weight: .regular))
        .frame(width: 120)
        .padding(.vertical, 5)
        .background(Capsule().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/))
    }
    .padding(.vertical, 5)
    .frame(maxWidth: .infinity)
  }
  
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
      ChatView(chatsViewModel: ChatsViewModel(), chat:Chat(user1: MessageUser(id: "", user_image: "", first_name: "Aaratrika", last_name: "Chakraborty", user_status: true), user2: MessageUser(id: "", user_image: "", first_name: "Atul Kumar", last_name: "Rai", user_status: true), messages: [Message(date: Date(), from_user_id: "U00001", text: "Hi, How are you?", type: .Sent),Message(date: Date(), from_user_id: "U00001", text: "Hi, How are you?", type: .Sent)], hasUnreadMessage:true)).environmentObject(ChatsViewModel())
    }
}


//HStack {
//   Text("Chats")
//   .font(.largeTitle)
//   .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
//   .fontWeight(.heavy)
//   .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
//  }
