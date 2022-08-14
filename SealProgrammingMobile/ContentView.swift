//
//  ContentView.swift
//  SealProgrammingMobile
//
//  Created by 坂口智典 on 2022/08/11.
//

import SwiftUI
import TensorFlowLiteTaskVision

struct ContentView: View {
    @State var showingImagePicker = false
    @State var showingCameraPicker = false
    @State var showingDeviceScanView = false

    @State var pickedImage: UIImage?
    @State var detectionResult: DetectionResult?
    
    var body: some View {
        VStack() {
            ZStack{
                if let image = pickedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.gray)
                        .frame(maxHeight: .infinity)
                }else{
                    Spacer()
                }
                if let detectionResult = detectionResult {
                    DetectionResultView(detections: detectionResult.detections, imageSize: pickedImage!.size)
                }
            }
            Text("Image")
                .onTapGesture {
                    showingImagePicker.toggle()
                }
            Spacer().frame(height: 10)
            Text("Camera")
                .onTapGesture {
                    showingCameraPicker.toggle()
                }
            Spacer().frame(height: 10)
            Text("Detect")
                .onTapGesture {
                    if(pickedImage != nil) {
                        detectionResult = SealDetector.detect(image: pickedImage!)
                    }
                }
            Spacer().frame(height: 10)
            Text("Connect")
                .onTapGesture {
                    showingDeviceScanView = true
                }
        }.sheet(isPresented:$showingImagePicker) {
            ImagePickerView(image: $pickedImage, sourceType: .library)
        }.sheet(isPresented:$showingCameraPicker) {
            ImagePickerView(image: $pickedImage, sourceType: .camera)
        }.sheet(isPresented: $showingDeviceScanView) {
            DeviceScanView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
