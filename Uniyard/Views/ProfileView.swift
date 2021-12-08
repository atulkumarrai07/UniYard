import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import SDWebImageSwiftUI

struct ProfileView: View {
  @EnvironmentObject var loginModel:LoginModel
  @Environment(\.presentationMode) var profilePresentation: Binding< PresentationMode>

  @StateObject var curUserVm: CurUserViewModel
  @State var shouldShowImagePicker = false
  @State var upload_image: UIImage?

  var body: some View {
    //    NavigationView {
    ZStack{
      Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
      VStack{
        HStack {
          Text(curUserVm.first_name)
            .font(.largeTitle).fontWeight(.heavy)
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            .frame(maxWidth: .infinity, alignment: .center)
        }.padding()

        VStack {//User profile image
          if let image = self.upload_image {
            Image(uiImage: image)
              .resizable()
              .scaledToFill()
              .frame(width: 128, height: 128)
              .cornerRadius(64)
          } else {
            if (curUserVm.user_image != ""){
              WebImage(url: URL(string: curUserVm.user_image))
                .resizable()
                .scaledToFill()
                .frame(width: 128, height: 128)
                .cornerRadius(64)
            } else{
              Image(systemName: "person.fill")
                .font(.system(size: 64))
                .padding()
                .foregroundColor(Color(.label))
            }
          }
        }.overlay(RoundedRectangle(cornerRadius: 64).stroke(Color.gray, lineWidth: 0))

        HStack{
          Button(action: {
            shouldShowImagePicker.toggle()
          }){Text("Edit Image")
          }.sheet(isPresented: $shouldShowImagePicker) {
            ImagePicker(image: $upload_image)
          }
          
          Button(action: {
            if let thisImage = self.upload_image {
              uploadImage(image: thisImage)
            } else{
              print("could not upload image - not present")
            }
          }){Text("Save")}
        }.padding(.trailing).padding(.leading)

        Text("Member since " + convertTimestamp(serverTimestamp: curUserVm.date_joined))
        
        ProfileBox(curUserVm: curUserVm).environmentObject(loginModel)
      }//vstcak
    }

    .navigationBarHidden(true)
  }


  func uploadImage(image: UIImage){
    if let imageData = image.jpegData(compressionQuality: 0.5){
      let storage = Storage.storage()
      let ref = storage.reference(withPath: curUserVm.user_id + ".jpg")
      ref.putData(imageData, metadata: nil){
        (data, err) in
        if let err = err {
          print("an error has occured - \(err.localizedDescription)")
          return
        } else{
          ref.downloadURL { url, err in
            if let err = err {
              print("Fail to retrive image url - \(err.localizedDescription)")
              return
            }
            print("Succeed in getting image url!")
            curUserVm.updateUserImage(url?.absoluteString ?? "")
          }
        }
      }
    } else{
      print("couldn't unwrap/cast image to data")
    }
  }
}

struct ProfileBox: View {
  @EnvironmentObject var loginModel:LoginModel
  let profileLinkNames: [String] = ["Personal", "My Posts", "Settings"]
  @StateObject var curUserVm : CurUserViewModel
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
      NavigationLink(destination: MyPostView()){
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
      NavigationLink(destination: SettingsView(curUserViewModel: curUserVm)){
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
      Button(action: {
        loginModel.signOut()
      },
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

func convertTimestamp(serverTimestamp: Date) -> String {
  //  let x = serverTimestamp
  let date = serverTimestamp
  let formatter = DateFormatter()
  formatter.dateStyle = .medium
  formatter.timeStyle = .none

  return formatter.string(from: date as Date)
}
