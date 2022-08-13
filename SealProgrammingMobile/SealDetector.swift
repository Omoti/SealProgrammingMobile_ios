// https://www.tensorflow.org/lite/inference_with_metadata/task_library/object_detector

// Imports
import TensorFlowLiteTaskVision

struct SealDetector{
    static func detect(image: UIImage) -> DetectionResult? {
        // Initialization
        guard let modelPath = Bundle.main.path(forResource: "seals_model",
                                                    ofType: "tflite") else { return nil }

        let options = ObjectDetectorOptions(modelPath: modelPath)

        do{
            // Configure any additional options:
            // options.classificationOptions.maxResults = 3

            let detector = try ObjectDetector.detector(options: options)

            // Convert the input image to MLImage.
            // There are other sources for MLImage. For more details, please see:
            // https://developers.google.com/ml-kit/reference/ios/mlimage/api/reference/Classes/GMLImage
            guard let mlImage = MLImage(image: image) else { return nil }

            // Run inference
            let detectionResult = try detector.detect(mlImage: mlImage)
            
            print(detectionResult)
            
            return detectionResult
        }catch{
            return nil
        }
    }
}
