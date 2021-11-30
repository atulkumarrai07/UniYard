import SwiftUI
struct ProfileView: View {
	@EnvironmentObject var loginModel:LoginModel
	@Environment(\.presentationMode) var profilePresentation: Binding< PresentationMode>
	
	var body: some View {
		ZStack{
			Color(red: 255/255.0, green: 192/255.0, blue: 190/255.0)
				//			Color(red: 214/255.0, green: 158/255.0, blue: 158/255.0, opacity: 1.0)
				.ignoresSafeArea(.all)
			VStack{
				HStack {
					Button(action: {
						self.profilePresentation.wrappedValue.dismiss()
					}){
						Image(systemName: "chevron.backward").resizable()
							.frame(width: 15, height: 20, alignment: .center)
							.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
					}
					Text("John Doe")
						.font(.system(size: 25, weight: .heavy))
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
				}.padding()
				
				//image
				Image(uiImage: #imageLiteral(resourceName: "Login_logo"))
					.resizable()
					.clipShape(Circle()) // Clip the image to a circle
					.frame(height: 150)
					.padding(.vertical, 10)
				
				ProfileBox()
			}//zstack
			
		}.navigationBarHidden(true)
	}
}

struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileView()
	}
}

struct ProfileBox: View {
	@EnvironmentObject var loginModel:LoginModel
	let profileLinkNames: [String] = ["Personal", "My Posts", "Settings"]
	
	var body: some View {
		VStack {
			
			//Personal
			NavigationLink(destination: PersonalView()){
				HStack {
					Image(systemName: "person.crop.rectangle")
						.frame(width: 40)
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.font(.system(size: 30))
					
					Text(profileLinkNames[0]).font(.title3)
					Spacer() // Spread the Text and Image views apart
					Image(systemName: "chevron.right")
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.font(.system(size: 20))
				}.contentShape(Rectangle())
				.padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
				Divider()
			}.buttonStyle(PlainButtonStyle())
			
			//My Posts
			NavigationLink(destination: MyPostsView()){
				HStack {
					Image(systemName: "list.bullet.rectangle")
						.frame(width: 40)
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.font(.system(size: 30))
					
					Text(profileLinkNames[1]).font(.title3)
					Spacer() // Spread the Text and Image views apart
					Image(systemName: "chevron.right") // Add symbol
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.font(.system(size: 20))
				}.contentShape(Rectangle())
				.padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
				Divider()
			}.buttonStyle(PlainButtonStyle())
			
			//Settings
		NavigationLink(destination: SettingsView()){
			HStack {
				Image(systemName: "gearshape")
					.frame(width: 40)
					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
					.font(.system(size: 30))
				
				Text(profileLinkNames[2]).font(.title3)
				Spacer() // Spread the Text and Image views apart
				Image(systemName: "chevron.right") // Add symbol
					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
					.font(.system(size: 20))
			}.contentShape(Rectangle())
			.padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
			Divider()
		}.buttonStyle(PlainButtonStyle())
			
			//Sign out button
			Button(action: {loginModel.signOut()},
						 label: {
							Text("Sign Out").font(.system(size: 20, weight: .medium))
							Image(systemName: "chevron.right.circle")
								.foregroundColor(.white)
								.font(.system(size: 22))
							
						 })
				.frame(width: 200, height: 40, alignment: .center)
				.foregroundColor(.white)
				.background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
				.cornerRadius(15)
				.padding(.vertical, 20)
				.padding(.horizontal, 50)
			
			Spacer()
			
	}.background(Color(.systemBackground))
		.cornerRadius(20)
		.padding()
		
	}
}


struct PersonalView: View {
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text("Personal")
					.font(.body)
			}
		}
	}
}

struct MyPostsView: View {
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text("My Posts")
					.font(.body)
			}
		}
	}
}


struct SettingsView: View {
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text("Settings")
					.font(.body)
			}
		}
	}
}

