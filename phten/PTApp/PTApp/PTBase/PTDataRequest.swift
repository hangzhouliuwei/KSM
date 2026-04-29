//
//  PTDataRequest.swift
//  PTApp
//
//  Created by Codex on 2026/4/28.
//

import AFNetworking
import UIKit
import YTKNetwork

enum PTAPIEndpoint {
    static let googleMarket = "tencr/market"
    static let uploadAdid = "tencr/aio"
    static let updateLocation = "tencr/location"
    static let updateDevice = "tencr/device"

    static let loginCode = "tencp/get_code"
    static let login = "tencp/login"
    static let logout = "tencp/logout"

    static let homeIndex = "tench/index"
    static let homePopup = "tench/pop-up"
    static let mineIndex = "tench/home"
    static let orderList = "tenco/list"

    static let gceApply = "tennv2/gce/apply"
    static let gceDetail = "tennv2/gce/detail"
    static let gcePush = "tennv2/gce/push"

    static let basicInfo = "tenca/person"
    static let saveBasicInfo = "tenca/person_next"
    static let contactInfo = "tenca/contact"
    static let saveContactInfo = "tenca/contact_next"
    static let identifyInfo = "tenca/photo"
    static let uploadOCR = "tenca/ocr"
    static let saveIdentifyInfo = "tenca/photo_next"
    static let liveInit = "tenca/auth"
    static let liveLimit = "tenca/limit"
    static let liveLicense = "tenca/license"
    static let liveDetection = "tenca/detection"
    static let saveLive = "tenca/saveauth"
    static let liveError = "tenca/auth_err"
    static let bankInfo = "tenca/card"
    static let saveBankInfo = "tenca/card_next"
}

enum PTAPIParameterKey {
    static let phoneNumber = "chtenreographyNc"
    static let smsType = "betentyNc"
    static let productId = "litenetusNc"
    static let applySource = "futenhamNc"
    static let orderId = "sptensmogenicNc"
    static let pushQueue = "qutennquevalentNc"
    static let pushScene = "ditentomeNc"
    static let orderStatus = "hatenfbackNc"
    static let page = "letenitimismNc"
    static let pageSize = "catentonizationNc"
    static let basicFlag = "butennableNc"
    static let contactFlag = "setenisacredNc"
    static let livenessId = "gytenoseNc"
    static let liveError = "datenrymanNc"
}

enum PTAPIParameterValue {
    static let smsType = "juyttrr"
    static let applySource = "cakestand"
    static let pushQueue = "dddd"
    static let pushScene = "houijhyus"
    static let basicFlag = "stauistill"
    static let contactFlag = "blaalleynk"
}

enum PTRequestParameters {
    static let empty: NSDictionary = PTRequestValue.emptyDictionary

    static func dictionary(_ dictionary: NSDictionary?) -> NSDictionary {
        PTRequestValue.dictionary(dictionary)
    }

    static func product(_ productId: String?, extra: [String: Any] = [:]) -> NSDictionary {
        var data = extra
        data[PTAPIParameterKey.productId] = PTRequestValue.string(productId)
        return data as NSDictionary
    }
}

enum PTRequestValue {
    static let emptyDictionary: NSDictionary = [:]

    static func string(_ value: String?) -> String {
        value ?? ""
    }

    static func dictionary(_ value: NSDictionary?) -> NSDictionary {
        value ?? emptyDictionary
    }
}

func ptValue(_ value: String?) -> String {
    PTRequestValue.string(value)
}

@objc(PTDictionaryRequest)
class PTDictionaryRequest: PTBaseRequest {
    typealias Payload = [String: Any]

    struct Endpoint {
        let path: String
        let method: YTKRequestMethod

        init(_ path: String, method: YTKRequestMethod = .POST) {
            self.path = path
            self.method = method
        }
    }

    private let payload: NSDictionary
    private let endpoint: Endpoint

    @objc(initWithData:path:)
    init(data: NSDictionary, path: String) {
        self.payload = data
        self.endpoint = Endpoint(path)
        super.init()
    }

    init(data: NSDictionary = PTRequestParameters.empty, path: String, method: YTKRequestMethod = .POST, showLoading: Bool = false) {
        self.payload = data
        self.endpoint = Endpoint(path, method: method)
        super.init()
        isShowLoading = showLoading
    }

    init(data: NSDictionary = PTRequestParameters.empty, endpoint: Endpoint, showLoading: Bool = false) {
        self.payload = data
        self.endpoint = endpoint
        super.init()
        isShowLoading = showLoading
    }

    init(payload: Payload = [:], endpoint: Endpoint, showLoading: Bool = false) {
        self.payload = payload as NSDictionary
        self.endpoint = endpoint
        super.init()
        isShowLoading = showLoading
    }

    override func requestUrl() -> String {
        endpoint.path
    }

    override func requestTimeoutInterval() -> TimeInterval {
        30
    }

    override func requestMethod() -> YTKRequestMethod {
        endpoint.method
    }

    override func requestArgument() -> Any {
        payload
    }
}

@objc(PTImageUploadRequest)
class PTImageUploadRequest: PTBaseRequest {
    private let image: UIImage
    private let params: NSDictionary
    private let path: String
    private let fileFieldName: String
    private let fileName: String
    private let mimeType: String
    private let maxKilobytes: Int

    init(
        image: UIImage,
        params: NSDictionary?,
        path: String,
        fileFieldName: String,
        fileName: String,
        mimeType: String = "image/jpeg",
        maxKilobytes: Int = 1024,
        showLoading: Bool = false
    ) {
        self.image = image
        self.params = PTRequestValue.dictionary(params)
        self.path = path
        self.fileFieldName = fileFieldName
        self.fileName = fileName
        self.mimeType = mimeType
        self.maxKilobytes = maxKilobytes
        super.init()
        isShowLoading = showLoading
    }

    override func requestMethod() -> YTKRequestMethod {
        .POST
    }

    override func requestUrl() -> String {
        path
    }

    override var constructingBodyBlock: AFConstructingBlock? {
        get {
            { [weak self] formData in
                guard let self,
                      let data = Self.jpegData(for: self.image, maxKilobytes: self.maxKilobytes) else {
                    return
                }

                formData.appendPart(
                    withFileData: data,
                    name: self.fileFieldName,
                    fileName: self.fileName,
                    mimeType: self.mimeType
                )
            }
        }
        set {}
    }

    override func requestArgument() -> Any {
        params
    }

    private static func jpegData(for image: UIImage, maxKilobytes: Int) -> Data? {
        let maxBytes = maxKilobytes * 1024
        var quality: CGFloat = 0.9
        let minQuality: CGFloat = 0.1
        var data = image.jpegData(compressionQuality: quality)

        while let currentData = data, currentData.count > maxBytes, quality > minQuality {
            quality -= 0.1
            data = image.jpegData(compressionQuality: quality)
        }

        return data
    }
}
