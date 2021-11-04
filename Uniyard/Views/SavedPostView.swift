import SwiftUI
struct SavedPostView: View {
  var body: some View {
    ZStack{
     VStack{
     HStack {
        Text("Saved Posts")
        .font(.largeTitle)
        .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        .fontWeight(.heavy)
        .frame(maxWidth: .infinity, alignment: .center)
       }
      Text("This is the saved posts view").bold()
      Spacer()
     }
    }.navigationBarHidden(true)
  }
}
struct SavedPost_Previews: PreviewProvider {
  static var previews: some View {
   SavedPostView()
  }
}
