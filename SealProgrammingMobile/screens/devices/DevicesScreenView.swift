import SwiftUI

struct DeviceScanView: View {
    @StateObject var deviceManger: DeviceManager = DeviceManager()
    
    var body: some View {
        List(){
            if(!deviceManger.isSearching){
                Button(action: {
                    deviceManger.startScan()
                }){
                    Text("Scan")
                        .font(.largeTitle)
                }
            }else{
                Button(action: {
                    deviceManger.stopScan()
                }){
                    Text("Stop")
                        .font(.largeTitle)
                }
            }
            ForEach(deviceManger.foundPeripherals, id: \.self) { peripheral in
                FoundDeviceItem(
                    name:peripheral.name,
                    action: {
                        deviceManger.connect(peripheral: peripheral)
                    }
                )
            }
            Button(action: {
                deviceManger.write(data: "hoge")
            }) {
                Text("Write")
            }
        }
    }
}
