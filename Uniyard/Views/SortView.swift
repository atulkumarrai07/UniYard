import SwiftUI

struct SortView: View {
  @State var sortOption:Binding<String>
  @Environment(\.presentationMode) var itemSortPicker: Binding< PresentationMode>
  
  @StateObject var itemViewModel = ItemsViewModel()
  
  var body: some View {
        VStack{
          HStack{
            Spacer()
            Button("Done"){
              if (itemViewModel.renderSell){
                itemViewModel.sortItems(true)
              } else{
                itemViewModel.sortItems(false)
              }
              
              self.itemSortPicker.wrappedValue.dismiss()
              
            }
          }.padding()
          Picker("", selection: sortOption) {
                     ForEach(["Newest Date First",
                              "Oldest Date First",
                              "Lowest Price First",
                              "Highest Price First",], id: \.self) {
                         Text("\($0)")
                     }
                 }
          Spacer()
        }
    
  }
  
}
