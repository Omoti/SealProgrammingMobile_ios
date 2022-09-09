import SwiftUI


struct DeviceScanView: View {
    @StateObject var deviceManger: DeviceManager = DeviceManager()
    
    var body: some View {
        ZStack {
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
        }
    }
}
