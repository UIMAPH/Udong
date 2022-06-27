//
//import Foundation
//
//class imageUpload {
//    static let shared = imageUpload()
//    
//    func uploadToS3(url: URL) {
//        let fileArr = url.path.components(separatedBy: "/") // Path will be too long, so you have to separate the elements by / and store in an array
//        let key = fileArr.last // We get the last element of the array which in our case will be the image (my-image.jpg)
//        let localImageUrl = url
//        
//        let request = AWSS3TransferManagerUploadRequest()!
//        request.bucket = bucketName
//        request.key = key
//        request.body = localImageUrl
//        request.acl = .publicReadWrite
//        
//        let transferManager = AWSS3TransferManager.default()
//        transferManager.upload(request).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
//            if let error = task.error {
//                print(error)
//            }
//            if task.result != nil {
//                print("Uploaded \(key)")
//                let contentUrl = self.s3Url.appendingPathComponent(bucketName).appendingPathComponent(key!)
//                self.contentUrl = contentUrl
//            }
//            return nil
//        }
//    }
//    func upload(pickedimage: UIImage){
//        takenPhoto.contentMode = .scaleToFill
//        takenPhoto.image = pickedImage
//        print(takenPhoto.image = pickedImage)
//        // Add here:
//        let url = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
//            .appendingPathComponent("my-image", isDirectory: false)
//            .appendingPathExtension("jpg") /* here we are naming the image 'my-image' and it will be 'jpg', if you want you can add a counter to increase the number each time you upload an image, and you make something like this: "my-image-\(counter)"*/
//        
//        // Then write to disk
//        if let data = pickedImage.jpegData(compressionQuality: 0.8) {
//            do {
//                try data.write(to: url)
//                uploadToS3(url: url) //Call the updated function to store to AWS bucket
//            } catch {
//                print("Handle the error, i.e. disk can be full")
//            }
//        }
//    }
//}
