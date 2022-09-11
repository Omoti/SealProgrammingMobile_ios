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
                HStack{
                    Text(peripheral.name)
                    Button(action: {
                        deviceManger.connect(peripheral: peripheral)
                    }) {
                        Text("Connect")
                    }
                }
            }
            Button(action: {
                deviceManger.write(data: "hoge")
            }) {
                Text("Write")
            }
        }
    }
}
