//
//  PTLanuchServices.swift
//  PTApp
//

import Foundation

@objc(PTLanuchService)
class PTLanuchService: PTDictionaryRequest {
    @objc(initWithData:)
    init(data: NSDictionary) {
        super.init(data: data, path: PTAPIEndpoint.googleMarket)
    }
}

@objc(PTDeviceService)
class PTDeviceService: PTDictionaryRequest {
    @objc(initWithData:)
    init(data: NSDictionary) {
        super.init(data: data, path: PTAPIEndpoint.updateDevice)
    }
}

@objc(PTLocationService)
class PTLocationService: PTDictionaryRequest {
    @objc(initWithData:)
    init(data: NSDictionary) {
        super.init(data: data, path: PTAPIEndpoint.updateLocation)
    }
}

@objc(PTUploadAdidService)
class PTUploadAdidService: PTDictionaryRequest {
    @objc(initWithData:)
    init(data: NSDictionary) {
        super.init(data: data, path: PTAPIEndpoint.uploadAdid)
    }
}
