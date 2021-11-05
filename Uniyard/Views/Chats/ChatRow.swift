import SwiftUI

struct ChatRow: View {
    var body: some View {
      HStack(spacing:20)
        {
          Image("JohnDoe").resizable().frame(width: 70, height: 70).clipShape(Circle())
          
          ZStack{
            VStack(alignment: .leading, spacing: 5){
              HStack{
                Text("Andrew").bold()
                Spacer()
                Text("11/01/2021")
              }
              HStack{
                Text("Hey! How are you. I am interested in the chair you posted.").foregroundColor(.gray).lineLimit(2).frame(height: 50, alignment: .top).frame(maxWidth: .infinity, alignment: .leading).padding(.trailing,40)
              }
            }
          }
        
      }.frame(height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow()
    }
}
