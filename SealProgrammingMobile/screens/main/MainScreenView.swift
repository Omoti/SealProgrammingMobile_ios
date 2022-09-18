import Foundation
import SwiftUI
import TensorFlowLiteTaskVision

struct MainScreenView: View{
    @EnvironmentObject private var deviceModel :DeviceModel
    @EnvironmentObject private var detectionResultModel :DetectionResultModel
    
    @State var showingImagePicker = false
    @State var showingCameraPicker = false
    @State var showingCaptureScreenView = false
    @State var showingDeviceScreenView = false
    
    //@State var pickedImage: UIImage?
    
    @State private var selection = 0
    var body:some View{
        NavigationView{
            VStack(alignment: .center) {
                Picker("", selection: $selection) {
                    Text("シール").tag(0)
                    Text("リスト").tag(1)
                }.pickerStyle(.segmented)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                    .opacity(detectionResultModel.image != nil ? 1.0 : 0.0)
                ZStack{
                    if let image = detectionResultModel.image {
                        if selection == 0 {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .background(Color.white)
                                .frame(maxHeight: .infinity)
                            
                            if let detections = detectionResultModel.detections {
                                DetectionResultView(detections: detections, imageSize: image.size)
                            }
                        }else{
                            let seals = detectionResultModel.detections?.map({ detection in
                                SealConverter.labelToSeal(label: detection.categories.first?.label ?? "")
                            })
                            SealsScreenView(seals: seals!)
                        }
                    }else{
                        VStack{
                            Spacer()
                            Text("シールプログラミングへようこそ")
                            Spacer()
                        }.background(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    }
                }.aspectRatio(3/4, contentMode: ContentMode.fit)
                    .background(Color.white)
                Spacer()
                HStack(alignment: .center){
                    Spacer()
                    CircleButton(
                        image: Image(systemName: "camera.fill"),
                        label: "とる",
                        color: Color("PrimaryColor"),
                        action: {
                            // showingCameraPicker.toggle()
                            showingCaptureScreenView = true
                        }
                    )
                    Spacer()
                        CircleButton(
                            image: Image(deviceModel.connectedPeripheral == nil ? "BluetoothIconDefault": "BluetoothIconConnected"),
                            label: "つなぐ",
                            color: Color("PrimaryColor"),
                            action: {
                                showingDeviceScreenView = true
                            }
                        )
                    Spacer()
                    CircleButton(
                        image:Image(systemName: "car.fill"),
                        label: "おくる",
                        color: Color("SecondaryColor"),
                        action: {
                            if let detections = detectionResultModel.detections {
                                deviceModel.write(data: SealConverter.detectionsToCommands(detactions: detections))
                            }
                        }
                    ).disabled(
                        detectionResultModel.detections == nil || deviceModel.connectedPeripheral == nil
                    )
                    Spacer()
                }
                HStack{
                    Spacer()
                    if let device = deviceModel.connectedPeripheral {
                        Text(device.name + ": OK").foregroundColor(.black)
                    }else{
                        Text("つながってません").foregroundColor(.black)
                    }
                    Spacer()
                }
            }.fullScreenCover(isPresented:$showingCaptureScreenView) {
                CaptureScreenView()
                    .environmentObject(detectionResultModel)
            }.sheet(isPresented: $showingDeviceScreenView) {
                DeviceScanView(onConnect: {
                    showingDeviceScreenView = false
                }).environmentObject(deviceModel)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .background(Color("ControlBackgroundColor"))
                .navigationBarTitle("シールプログラミング")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
