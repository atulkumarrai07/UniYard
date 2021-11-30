
import Foundation
import FirebaseFirestore
import FirebaseAuth

class ChatsViewModel: ObservableObject {
  @Published var chats:[Chat] = []
  var viewModel:ViewModel = ViewModel()
  init() {
    let auth = Auth.auth()
    viewModel.fetchChats(currentUserID: auth.currentUser!.uid){results in
      self.chats = results
    }
  }
  
  func getSortedFilteredChats(query: String) -> [Chat] {
    let sortedChats = chats.sorted {
      guard let date1 = $0.messages.last?.date else{
        return false
      }
      guard let date2 = $1.messages.last?.date else{
        return false
      }
      return date1 > date2
    }
    if query == ""{
      return sortedChats
    }
    return sortedChats.filter{ $0.user2.first_name.lowercased().contains(query.lowercased())}
  }
  
  func getSectionMessages(for chat: Chat) -> [[Message]] {
    var res = [[Message]]()
    var tmp = [Message]()
    for message in chat.messages{
      if let firstMessage = tmp.first{
        let daysBetween = firstMessage.date.daysBetween(date: message.date)
        if daysBetween >= 1{
          res.append(tmp)
          tmp.removeAll()
          tmp.append(message)
        }
        else{
          tmp.append(message)
        }
      }
      else{
        tmp.append(message)
      }
    }
    res.append(tmp)
//    print(res)
    return res
  }
  
  func markAsRead(_ newValue: Bool, chat:Chat) {
    if let index = chats.firstIndex(where: {$0.id == chat.id}){
      if(chats[index].hasUnreadMessage == true){
        viewModel.updateHasUnreadMessagesStatus(chatId: chats[index].id){
          self.chats[index].hasUnreadMessage = newValue
        }
      }
    }
  }
  
  func sendMessage(_ text:String, in chat:Chat) -> Message?
  {
    let auth = Auth.auth()
    var flagDone = false
    if let index = chats.firstIndex(where: {$0.id == chat.id})
    {
//      let message = Message(text,type: .Sent, from_user: "5XxxXKcFt9Vpr1eK2tjV9y0B7Fg1")
      let message = Message(date: Date(), from_user_id: auth.currentUser!.uid, text: text, type: .Sent)
      viewModel.UpdateChatWithNewMessage(chat: chats[index], message: message){newMessage in
        self.chats[index].messages.append(newMessage)
        self.viewModel.fetchChats(currentUserID: auth.currentUser!.uid){results in
          self.chats = results
        }
        flagDone = true
      }
      if(flagDone)
      {
        return message
      }
    }
    return nil
  }
  
}
extension Chat{
  static let sampleChat:[Chat] = [
    Chat(user1: MessageUser(id: "U00001", user_image: "", first_name: "Aaratrika", last_name: "Chakraborty", user_status: true),  user2: MessageUser(id: "5XxxXKcFt9Vpr1eK2tjV9y0B7Fg1", user_image: "", first_name: "Atul Kumar", last_name: "Rai", user_status: true), messages: [Message(date: Date(), from_user_id: "U00001", text: "Hi, How are you?", type: .Sent), Message(date: Date(), from_user_id: "5XxxXKcFt9Vpr1eK2tjV9y0B7Fg1", text: "I am good. What about you?", type: .Received)],hasUnreadMessage:true),
    Chat(user1: MessageUser(id: "UQ1Sr9RAuAaN4MWAKt9n01Kj0kt2", user_image: "", first_name: "Iris", last_name: "Hao", user_status: true), user2: MessageUser(id: "5XxxXKcFt9Vpr1eK2tjV9y0B7Fg1", user_image: "", first_name: "Atul Kumar", last_name: "Rai", user_status: true), messages: [Message(date: Date(), from_user_id: "UQ1Sr9RAuAaN4MWAKt9n01Kj0kt2", text: "Hi I am interested in the item you posted", type: .Sent)])
  ]
}
