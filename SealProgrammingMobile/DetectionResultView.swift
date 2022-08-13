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
                let scale = safeAreaWidth / imageSize.width // 縦長前提で横幅のスケールに合わせる
                let convertedRect = detection.boundingBox.applying(
                    CGAffineTransform(
                        scaleX: scale,
                        y: scale))
                
                let dy = (safeAreaHeght - imageSize.height * scale) / 2
                
                let x = convertedRect.origin.x
                let y = convertedRect.origin.y + dy
                let boxWidth = convertedRect.width
                let boxHeight = convertedRect.height
                
                context.stroke(Path(CGRect(x: x,
                                           y: y,
                                           width: boxWidth,
                                           height: boxHeight)),
                               with: .color(.blue))
                
                guard let category = detection.categories.first  else {continue}
                let score = String(format: "%.2f", category.score)
                context.draw(Text((category.label ?? "") + "(" + score + ")")
                    .font(.footnote)
                    .foregroundColor(.blue)
                , at: CGPoint(x: x, y: y)
                
                )
            }
        }
    }
}
