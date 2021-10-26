import AVFoundation
import UIKit

class CameraPreviewView: UIView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    // convenience property to cast layer as AVCaptureVideoPreviewLayer
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer.")
        }
        return layer
    }

    var session: AVCaptureSession? {
        get {
            videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.session = newValue
        }
    }
}
