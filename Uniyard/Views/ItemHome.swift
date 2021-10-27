
import SwiftUI

struct ItemHome: View {
  @Environment(\.presentationMode) var ItemHomePresentation: Binding<PresentationMode>
  var userId:String
    var body: some View {
      ScrollView{
        VStack{
          HStack {
            Button(action: {
              self.ItemHomePresentation.wrappedValue.dismiss()
            }){
              Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            }
            Text("Items")
              .font(.largeTitle)
              .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
              .fontWeight(.heavy)
              .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
          }.padding()
        }
      }
    }
}

struct ItemHome_Previews: PreviewProvider {
    static var previews: some View {
        ItemHome(userId: "U00001")
    }
}
