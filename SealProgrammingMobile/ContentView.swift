//
//  ContentView.swift
//  SealProgrammingMobile
//
//  Created by 坂口智典 on 2022/08/11.
//

import SwiftUI

struct ContentView: View {
    @State var showingImagePicker = false
    @State var showingCameraPicker = false
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            }
            Text("Image")
                .onTapGesture {
                    showingImagePicker.toggle()
                }
            Text("Camera")
                .onTapGesture {
                    showingCameraPicker.toggle()
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
