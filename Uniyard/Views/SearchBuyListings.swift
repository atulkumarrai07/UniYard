import SwiftUI

struct SearchBuyListings: View {
  @StateObject var itemViewModel:ItemsViewModel
    var body: some View {
        VStack{
          
          NavigationLink(
            destination: CreateBuyView(),
            label: {
              Text("Post to Buy")
            }).frame(width: 350, height: 40, alignment: .center).foregroundColor(.white).background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).font(.title).cornerRadius(15.0).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
          if(itemViewModel.filteredPosts.count < 1){
            VStack{
          Spacer()
            Text("No search results found!").font(.headline).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          }
          }
          List(itemViewModel.filteredPosts, id: \.itemId){itemPostAvailable in
            NavigationLink(
              destination: ItemDetailsBuy(itemDetails: itemPostAvailable),
              label: {
								HStack{
									VStack (alignment: .leading){
										HStack {
											Text(String(itemPostAvailable.item_title)).font(.headline).foregroundColor(.black)
										}
										HStack{
											Text("Category: " + String(itemPostAvailable.item_category)).font(.subheadline).foregroundColor(.black).opacity(0.8)
										}
										Spacer()
										HStack{
											Text("$ " + String(itemPostAvailable.price)).font(.subheadline).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
											Spacer()
											Text(convertTimestamp(serverTimestamp: itemPostAvailable.last_modified_timestamp))
												.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).font(.subheadline)
										}
										
									}.padding()
									
								}.frame(width: 350, height: 110, alignment: .center)
								.overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
              })
          }
          
          

          Spacer()
        }.navigationBarHidden(true)
    }
}

struct SearchBuyListings_Previews: PreviewProvider {
  
    static var previews: some View {
      let itemViewModel = ItemsViewModel()
      SearchBuyListings(itemViewModel: itemViewModel)
    }
}
