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
    @State var image: UIImage?
    @State var detectionResult: DetectionResult?
    
    var body: some View {
        VStack {
            ZStack{
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                if let detectionResult = detectionResult {
                    DetectionResultView(detections: detectionResult.detections)
                }
            }
            Text("Image")
                .onTapGesture {
                    showingImagePicker.toggle()
                }
            Text("Camera")
                .onTapGesture {
                    showingCameraPicker.toggle()
                }
            Text("Detect")
                .onTapGesture {
                    if(image != nil) {
                        detectionResult = SealDetector.detect(image: image!)
                    }
                }
        }.sheet(isPresented:$showingImagePicker) {
            ImagePickerView(image: $image, sourceType: .library)
        }.sheet(isPresented:$showingCameraPicker) {
            ImagePickerView(image: $image, sourceType: .camera)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
