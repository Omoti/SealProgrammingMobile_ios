import SwiftUI

struct DeviceScanView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var deviceModel :DeviceModel
    
    var onConnect: () -> Void
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                List(){
                    let connectedDevice = deviceModel.connectedPeripheral
                    
                    if connectedDevice != nil  {
                        ConnectedDeviceItem(name: connectedDevice!.name, action: {
                            deviceModel.disconnect()
                        })
                    }
                    ForEach(deviceModel.foundPeripherals, id: \.self) { peripheral in
                        if peripheral.uuid != connectedDevice?.uuid {
                            FoundDeviceItem(
                                name:peripheral.name,
                                action: {
                                    deviceModel.connect(peripheral: peripheral)
                                    onConnect()
                                }
                            )
                        }
                    }
                    HStack(alignment: .center){
                        Spacer()
                        if deviceModel.isSearching {
                            ProgressView()
                        } else {
                            VStack(alignment: .center){
                                if deviceModel.foundPeripherals.count == 0 && deviceModel.connectedPeripheral == nil {
                                    Text("みつかりませんでした")
                                        .padding(10)
                                }
                                Button {
                                    deviceModel.startScan(autoConnect: false)
                                } label: {
                                    Text("もういちどさがす")
                                }.padding(10)
                            }
                        }
                        Spacer()
                    }.padding(10)
                }.onAppear(){
                    deviceModel.startScan(autoConnect: false)
                }.onDisappear(){
                    deviceModel.stopScan()
                }.navigationBarTitle("つなぐ")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: CloseButton(action: {
                        close()
                    }))
            }
        }
    }
    
    func close(){
        dismiss()
    }
}
