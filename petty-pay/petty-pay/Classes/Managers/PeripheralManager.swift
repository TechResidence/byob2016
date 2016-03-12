import CoreBluetooth
import CoreLocation

class PeripheralManager: CBPeripheralManager {

    private static let sharedInstance = PeripheralManager()
    private let beaconIdentifier = "pettypay"
    private let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"

    /**
     ペリフェラルとしてアドバタイジングを開始する
     */
    static func checkStateOfAdvertising() {
        // delegateに代入すると CBPeripheralManagerDelegate のメソッドが呼び出される
        sharedInstance.delegate = sharedInstance
    }

    static func startAdvertising() {
		sharedInstance.startAdvertisingWithPeripheralManager(sharedInstance)
    }
	
	static func stopAdvertising() {
		sharedInstance.stopAdvertising()
    }
	
	static func isAdvertising() -> Bool {
		return sharedInstance.isAdvertising
	}

}


// MARK: - CBPeripheralManagerDelegate

extension PeripheralManager: CBPeripheralManagerDelegate {

    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .Unknown:
            print("Unknown")
        case .Resetting:
            print("Resetting")
        case .Unsupported:
            print("Unsupported")
        case .Unauthorized:
            print("Unauthorized")
        case .PoweredOff:
            print("PoweredOff")
        case .PoweredOn:
            print("PoweredOn")
        }
		
    }

    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        if let error = error {
            print("Failed to start advertising with error:\(error)")
        } else {
            print("Start advertising")
        }
    }

    /**
     ペリフェラルとしてアドバタイジングを開始する
     - parameter manager: CBPeripheralManagerDelegate から受け取れる CBPeripheralManager
     */
    private func startAdvertisingWithPeripheralManager(manager: CBPeripheralManager) {
        guard let proximityUUID = NSUUID(UUIDString: uuidString) else {
            return
        }

        let beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID, identifier: beaconIdentifier)
        let beaconPeripheralData: NSDictionary = beaconRegion.peripheralDataWithMeasuredPower(nil)
        manager.startAdvertising(beaconPeripheralData as? [String: AnyObject])
    }
}