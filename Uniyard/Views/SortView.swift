
import SwiftUI

struct SortView: View {
	@StateObject var itemViewModel:ItemsViewModel
  @Environment(\.presentationMode) var itemSortPicker: Binding< PresentationMode>
  
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
					Picker("", selection: $itemViewModel.sortOption) {
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
