//
//  MediumsAPI+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/25.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import RxSwift
import Cactacea

extension MediumsAPI {
    
    open class func uploadMedium(data: Data, fileExtension: String, completion: @escaping ((_ data: [MediumCreated]?,_ error: Error?) -> Void)) {
        let pathName = NSTemporaryDirectory()
        let fileName = UUID().uuidString + fileExtension
        let url = URL(fileURLWithPath: pathName)
        let file = url.appendingPathComponent(fileName)
        do {
            try data.write(to: file)
            uploadWithRequestBuilder(file: file).execute { (response, error) -> Void in
                try! FileManager.default.removeItem(at: file)
                completion(response?.body, error);
            }
        } catch let error {
            completion(nil, error);
        }
    }
    
    open class func uploadMedium(data: Data, fileExtension: String) -> Observable<[MediumCreated]> {
        let pathName = NSTemporaryDirectory()
        let fileName = UUID().uuidString + fileExtension
        let file = URL(fileURLWithPath: pathName).appendingPathComponent(fileName)
        do {
            try data.write(to: file)
            return Observable.create { observer -> Disposable in
                upload(file: file) { data, error in
                    try! FileManager.default.removeItem(at: file)
                    if let error = error {
                        observer.on(.error(error))
                    } else {
                        observer.on(.next(data!))
                    }
                    observer.on(.completed)
                }
                return Disposables.create()
            }
        } catch let error {
            return Observable.error(error)
        }
    }
    
}

extension UIImage {
    
    func resizeImage(newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}



