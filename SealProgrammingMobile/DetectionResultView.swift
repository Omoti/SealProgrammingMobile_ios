import SwiftUI
import TensorFlowLiteTaskVision

struct DetectionResultView: View {
    let detections: [Detection]
    let imageSize: CGSize
    
    var body: some View {
        Canvas { context, size in
            let safeAreaWidth = size.width
            let safeAreaHeght = size.height

            for detection in detections {
                let convertedRect = detection.boundingBox.applying(
                  CGAffineTransform(
                    scaleX: safeAreaWidth / imageSize.width,
                    y: safeAreaHeght / imageSize.height))
                
                let x = convertedRect.origin.x
                let y = convertedRect.origin.y
                let boxWidth = convertedRect.width
                let boxHeight = convertedRect.height
                
                context.stroke(Path(CGRect(x: x,
                                      y: y,
                                      width: boxWidth,
                                      height: boxHeight)),
                               with: .color(.blue))
            }
        }
    }
}
