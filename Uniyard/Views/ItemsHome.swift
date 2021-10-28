
import SwiftUI

struct ItemsHome: View {
  @Environment(\.presentationMode) var ItemHomePresentation: Binding<PresentationMode>
  var userId:String
  @StateObject var itemViewModel = ItemsViewModel()
    var body: some View {
      VStack{
        HStack {
          Button(action: {
            self.ItemHomePresentation.wrappedValue.dismiss()
          }){
            Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          }
          
          Text("Items")
            .font(.largeTitle)
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            .fontWeight(.heavy)
            .frame(maxWidth: .infinity, alignment: .center).padding(.leading,10)
          
          Button(action: {
            self.ItemHomePresentation.wrappedValue.dismiss()
          }){
            Image(systemName: "magnifyingglass").resizable().frame(width: 30, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          }
        }.padding()
        
        HStack{
          Button("Sell", action: {
            itemViewModel.renderSell.toggle()
            itemViewModel.viewBuySell()
          }).frame(width: 175, height: 40, alignment: .center).foregroundColor(itemViewModel.sellButtonForegroundColor).background(itemViewModel.sellButtonBackgroundColor).font(.title).cornerRadius(15.0).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))).disabled(itemViewModel.renderSell)
          
          Button("Buy", action: {
            itemViewModel.renderSell.toggle()
            itemViewModel.viewBuySell()
          }).frame(width: 175, height: 40, alignment: .center).foregroundColor(itemViewModel.buyButtonForegroundColor).background(itemViewModel.buyButtonBackgroundColor).font(.title).cornerRadius(15.0).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))).disabled(!itemViewModel.renderSell)
        }.padding(.bottom,1)
        
        HStack{
          Text("Current Location:").font(.body).opacity(0.8)
          
          Button(itemViewModel.location) {
            itemViewModel.showingLocations.toggle()
          }.sheet(isPresented: $itemViewModel.showingLocations){
            CampusLocationPicker2(location: $itemViewModel.location)
          }
          Spacer()
          Image("filter_icon").resizable().frame(width: 30, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          
          Image("sort_icon").resizable().frame(width: 45, height: 50, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        }.padding(.horizontal)
        
        Spacer()
      }.navigationBarHidden(true)
      
    }
}

struct ItemsHome_Previews: PreviewProvider {
    static var previews: some View {
        ItemsHome(userId: "U00001")
    }
}
