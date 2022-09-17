import SwiftUI

struct DeviceScanView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var deviceModel :DeviceModel
    
    var onConnect: () -> Void
    
    var body: some View {
        VStack(alignment: .center){
            HStack(alignment: .bottom){
                Spacer()
                CloseButton(action: {
                    close()
                })
            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 3, trailing: 10))
                .background(Color("PrimaryColor"))
            List(){
                ForEach(deviceModel.foundPeripherals, id: \.self) { peripheral in
                    FoundDeviceItem(
                        name:peripheral.name,
                        action: {
                            deviceModel.connect(peripheral: peripheral)
                            onConnect()
                        }
                    )
                }
                HStack(alignment: .center){
                    Spacer()
                    ProgressView("")
                    Spacer()
                }.padding(10)
            }
        }.onAppear(){
            deviceModel.startScan()
        }.onDisappear(){
            deviceModel.stopScan()
        }.background(Color("PrimaryColor"))
    }
    
    func close(){
        dismiss()
    }
}
