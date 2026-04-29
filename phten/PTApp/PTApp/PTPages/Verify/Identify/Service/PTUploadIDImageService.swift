//
//  PTUploadIDImageService.swift
//  PTApp
//

import UIKit

@objc(PTUploadIDImageService)
class PTUploadIDImageService: PTImageUploadRequest {
    @objc(initWithImage:param:)
    init(image: UIImage, param params: NSDictionary?) {
        super.init(
            image: image,
            params: params,
            path: PTAPIEndpoint.uploadOCR,
            fileFieldName: "am",
            fileName: "imageFile.jpg",
            showLoading: true
        )
    }

    @objc var responseFileId: String? {
        guard let json = responseJSONObject as? [String: Any],
              let result = json["resultObject"] as? [String: Any] else {
            return nil
        }
        return result["file_id"] as? String
    }
}
