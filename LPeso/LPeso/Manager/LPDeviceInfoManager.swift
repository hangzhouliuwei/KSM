//
//  LPDeviceInfoManager.swift
//  LPeso
//
//  Created by Kiven on 2024/10/30.
//

import UIKit

class LPDeviceInfoManager: NSObject {

    static func uploadDeviceInfo(){
        let deviceInfo:[String:Any] =
        [
            "PTUTransformeri": [
                "PTUDraggletailedi": Device.availableDiskSize,
                "PTUSigurdi": Device.totalDiskSize,
                "PTUCastanetsi": Device.totalMemorySize,
                "PTUThymocytei": Device.availableMemorySize
                               ],
            
            "battery_status": [
                "PTULactescencei": Device.batteryNumber,
                "battery_status": Device.isFull ? 1 : 0,
                "PTUOrthogonalityi": Device.isCharging ? 1 : 0
            ],
            
            "hardware": [
                "PTUThievishlyi": Device.systemVersion,
                "PTULysatei": Device.localizedModel,
                "PTUIsomorphismi": Device.modelName,
                "PTULateenriggedi": Device.screenHeight,
                "PTUHaydni": Device.screenWidth,
                "PTUIsophenei": Device.physicalDimensions,
                "PTUWildlyi": "",
            ],
            
            "PTUMallendersi": [
                //todo
            ],
            
            "PTUNeutralismi": [
                "PTUVittlei": "0",
                "PTUFatefuli":Device.isSimulator ? "1" : "0",
                "PTUPeeviti": Device.isJailbroken ? "1" : "0" 
            ],
            
            "PTUCurrycombi": [
                "PTUSinopisi": Device.timeZone,
                "PTUWiti": Device.isOpenProxy ? "1" : "0",
                "PTUOctroii": Device.isOpenVPN ? "1" : "0",
                "PTUInnominatei": Device.mobileOperator,
                "PTUArchbishopi": Device.IDFV,
                "PTUSlopewashi": Device.language,
                "PTUBywalki": Device.networkType,
                "PTUKutarajai": Device.modeType,
                "PTUUrethritisi": Device.IP,
                "PTUTruncheoni": MarketID.IDFA
            ],
            
            "PTUNeurosisi": [
                "PTUIodizei": [
                    [
                        "PTUPdmi": Device.BSSID,
                        "PTUOfferingi": Device.SSID,
                        "PTUCancelationi": Device.BSSID,
                        "PTUCarmarthenshirei": Device.SSID
                    ]
                              ]
            ]
            
        ]
        
        Request.send(api: .deviceInfo(params: deviceInfo)) { (result:LPEmptyModel?) in
            
        } failure: { error in
            
        }
        
    }
}
