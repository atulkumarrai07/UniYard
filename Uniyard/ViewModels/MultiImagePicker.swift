import SwiftUI
import PhotosUI

struct MultiImagePicker: UIViewControllerRepresentable{
	@Binding var photos: [UIImage]
	@Binding var photosURL: [String]
	@Binding var showPicker: Bool
	
	func  makeCoordinator() -> Coordinator {
		return MultiImagePicker.Coordinator(photo1: self)
	}
	
	func makeUIViewController(context: Context) -> PHPickerViewController {
		var configu = PHPickerConfiguration()
//		configu.filter = any
		configu.selectionLimit = 0
		
		let picker = PHPickerViewController(configuration: configu)
		picker.delegate = context.coordinator
		return picker
	}
	
	func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
		//
	}
	
	class  Coordinator: NSObject, PHPickerViewControllerDelegate {
		var photo:MultiImagePicker
		
		init(photo1: MultiImagePicker) {
			photo = photo1
		}
		
		func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
			self.photo.showPicker.toggle()
			self.photo.photos = [UIImage]()
			
			for photo in results{
				if photo.itemProvider.canLoadObject(ofClass: UIImage.self){
					photo.itemProvider.loadObject(ofClass: UIImage.self){(image, err) in
						guard let photo1 = image else {
							print("\(String(describing: err?.localizedDescription))")
							return
						}
						self.photo.photos.append(photo1 as! UIImage)
						self.photo.photosURL.append(UUID().uuidString)

					}
				} else{
					print("No photos were loaded")
				}
			}
		}
		
	}
	
	
}





//import SwiftUI
//import PhotosUI
//
//struct MultiImagePicker: UIViewControllerRepresentable{
//	@Binding var photos: [UIImage]
//	@Binding var showPicker: Bool
//	var any = PHPickerConfiguration(photoLibrary: .shared())
//
//	func  makeCoordinator() -> Coordinator {
//		return MultiImagePicker.Coordinator(photo1: self)
//	}
//
//	func makeUIViewController(context: Context) -> PHPickerViewController {
//		var configu = PHPickerConfiguration()
//		configu.filter = any.filter
//		configu.selectionLimit = 0
//
//		let picker = PHPickerViewController(configuration: configu)
//		picker.delegate = context.coordinator
//		return picker
//	}
//
//	func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//		//
//	}
//
//	class  Coordinator: NSObject, PHPickerViewControllerDelegate {
//		var photo:MultiImagePicker
//
//		init(photo1: MultiImagePicker) {
//			photo = photo1
//		}
//
//		func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//			self.photo.showPicker.toggle()
//			for photo in results{
//				if photo.itemProvider.canLoadObject(ofClass: UIImage.self){
//					photo.itemProvider.loadObject(ofClass: UIImage.self){(imagen, err) in
//						guard let photo1 = imagen else {
//							print("\(String(describing: err?.localizedDescription))")
//							return
//						}
//						self.photo.photos.append(photo1 as! UIImage)
//
//					}
//				} else{
//					print("No photos were loaded")
//				}
//			}
//		}
//
//	}
//
//
//}
