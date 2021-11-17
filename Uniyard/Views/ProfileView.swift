import SwiftUI
struct ProfileView: View {
	@EnvironmentObject var loginModel:LoginModel
	@Environment(\.presentationMode) var profilePresentation: Binding< PresentationMode>
	
	var body: some View {
		ZStack{
			Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
			VStack{
				HStack {
					Text("John Doe")
						.font(.largeTitle).fontWeight(.heavy)
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
				}.padding()
				
				//image
				Image("JohnDoe").resizable().frame(width: 90, height: 90).clipShape(Circle())
				
				Text("Member since Oct, 2021")
				
				ProfileBox()
			}//zstack
			
		}.navigationBarHidden(true)
	}
}

struct ProfileBox: View {
	@EnvironmentObject var loginModel:LoginModel
	let profileLinkNames: [String] = ["Personal", "My Posts", "Settings"]
	
	var body: some View {
			VStack{
				NavigationLink(destination: PersonalView()){
					VStack(spacing: 0) {
						//Personal
						HStack {
							Image(systemName: "person.crop.rectangle")
								.frame(width: 40)
								.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
								.font(.system(size: 30))
							
							Text(profileLinkNames[0]).font(.title3)
							Spacer() // Spread the Text and Image apart
							Image(systemName: "chevron.right")
								.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
								.font(.system(size: 20))
						}.contentShape(Rectangle())
						.padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
						Divider()
					}
				}.buttonStyle(PlainButtonStyle())
				
				//MyPosts
				NavigationLink(destination: MyPostsView()){
					VStack(spacing: 0) {
						//Personal
						HStack {
							Image(systemName: "list.bullet.rectangle")
								.frame(width: 40)
								.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
								.font(.system(size: 30))
							
							Text(profileLinkNames[1]).font(.title3)
							Spacer() // Spread the Text and Image apart
							Image(systemName: "chevron.right")
								.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
								.font(.system(size: 20))
						}.contentShape(Rectangle())
						.padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
						Divider()
					}
				}.buttonStyle(PlainButtonStyle())
				
				//Settings
				NavigationLink(destination: SettingsView()){
					VStack(spacing: 0) {
						//Personal
						HStack {
							Image(systemName: "gearshape")
								.frame(width: 40)
								.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
								.font(.system(size: 30))
							
							Text(profileLinkNames[2]).font(.title3)
							Spacer() // Spread the Text and Image apart
							Image(systemName: "chevron.right")
								.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
								.font(.system(size: 20))
						}.contentShape(Rectangle())
						.padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
						Divider()
					}
				}.buttonStyle(PlainButtonStyle())
				
				Spacer()
				
				//Sign out button
				Button(action: {loginModel.signOut()},
							 label: {
								Text("Sign Out").font(.system(size: 20, weight: .medium))
								Image(systemName: "chevron.right.circle")
									.foregroundColor(.white)
									.font(.system(size: 22))
							 })
					.frame(width: 300, height: 40, alignment: .center)
					.foregroundColor(.white)
					.background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
					.cornerRadius(15)
					.padding(.vertical, 20)
					.padding(.horizontal, 50)
			}
			.background(Color(.systemBackground))

	}
}


struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileView()
	}
}
