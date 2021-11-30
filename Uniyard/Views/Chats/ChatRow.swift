import SwiftUI

struct ChatRow: View {
  let chat: Chat
    var body: some View {
      HStack(spacing:20)
        {
        if(chat.user2.user_image == ""){
          Image(systemName: "person.crop.circle").resizable().frame(width: 70, height: 70).clipShape(Circle()).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        }
        else{
          Image(chat.user2.user_image).resizable().frame(width: 70, height: 70).clipShape(Circle())
        }
          ZStack{
            VStack(alignment: .leading, spacing: 5){
              HStack{
                Text(chat.user2.first_name).bold()
                Spacer()
                Text(chat.messages.last?.date.descriptiveString() ?? "") 
              }
              HStack{
                Text(chat.messages.last?.text ?? "").foregroundColor(.gray).lineLimit(2).frame(height: 50, alignment: .top).frame(maxWidth: .infinity, alignment: .leading).padding(.trailing,40)
              }
            }
            Circle().foregroundColor(chat.hasUnreadMessage ? .blue:.clear).frame(width: 18, height: 18).frame(maxWidth: .infinity, alignment: .trailing)
          }
        
      }.frame(height: 80, alignment: .center)
      
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
      ChatRow(chat: Chat.sampleChat[0])
    }
}
