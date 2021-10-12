import SwiftUI


@available(iOS 13.0, tvOS 13.0, *)
public struct VRViewControllerRepresentable<Controller, Coordinator>: UIViewControllerRepresentable where Controller: UIViewController {

    private let coordinator: () -> Coordinator
    private let onMake: (Context) -> Controller
    private let onUpdate: (Controller, Context) -> Void
    
    public init(
        coordinator: @escaping () -> Coordinator,
        onMake: @escaping (Context) -> Controller,
        onUpdate: @escaping (Controller, Context) -> Void = { _,_ in }
    ) {
        self.coordinator = coordinator
        self.onMake = onMake
        self.onUpdate = onUpdate
    }
    
    public init(
        coordinator: Coordinator,
        onMake: @escaping (Context) -> Controller,
        onUpdate: @escaping (Controller, Context) -> Void = { _,_ in }
    ) {
        self.coordinator = { coordinator }
        self.onMake = onMake
        self.onUpdate = onUpdate
    }
    
    public func makeCoordinator() -> Coordinator {
        coordinator()
    }
 
    public func makeUIViewController(context: Context) -> Controller {
        onMake(context)
    }
    
    public func updateUIViewController(_ uiViewController: Controller, context: Context) {
        onUpdate(uiViewController, context)
    }
}


@available(iOS 13.0, tvOS 13.0, *)
extension VRViewControllerRepresentable where Coordinator == Void {

    public init(
        onMake: @escaping (Context) -> Controller,
        onUpdate: @escaping (Controller, Context) -> Void = { _,_ in }
    ) {
        self.coordinator = {}
        self.onMake = onMake
        self.onUpdate = onUpdate
    }

    public init(
        onMake: @escaping () -> Controller,
        onUpdate: @escaping (Controller) -> Void = { _ in }
    ) {
        self.coordinator = {}
        self.onMake = { _ in onMake() }
        self.onUpdate = { controller, context in onUpdate(controller) }
    }
}

