import SwiftUI
import TensorFlowLiteTaskVision

struct DetectionResultView: View {
    let detections: [Detection]
    let imageSize: CGSize
    let showScore: Bool
    
    var body: some View {
        Canvas { context, size in
            let safeAreaWidth = size.width
            let safeAreaHeght = size.height
            
            for (index, detection) in detections.enumerated() {
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
                               with: .color(.yellow))
                
                guard let category = detection.categories.first  else {continue}
                let seal = SealConverter.labelToSeal(label: category.label ?? "")
                let score = String(format: "%.2f", category.score)
                var text: String  = String(index + 1) + "." + seal.text
                if showScore {
                    text += "(" + score + ")"
                }
                context.draw(Text(text)
                    .font(.footnote)
                    .foregroundColor(.yellow)
                , at: CGPoint(x: x  + convertedRect.width / 2, y: y + convertedRect.height /  3))
            }
        }
    }
}
