import SwiftUI


@available(iOS 13.0, tvOS 13.0, *)
public struct VRViewRepresentation<View, Coordinator>: UIViewRepresentable where View: UIView {

    private let coordinator: () -> Coordinator
    private let onMake: (Context) -> View
    private let onUpdate: (View, Context) -> Void
    
    public init(
        coordinator: @escaping () -> Coordinator,
        onMake: @escaping (Context) -> View,
        onUpdate: @escaping (View, Context) -> Void = { _,_ in }
    ) {
        self.coordinator = coordinator
        self.onMake = onMake
        self.onUpdate = onUpdate
    }
    
    public init(
        coordinator: Coordinator,
        onMake: @escaping (Context) -> View,
        onUpdate: @escaping (View, Context) -> Void = { _,_ in }
    ) {
        self.coordinator = { coordinator }
        self.onMake = onMake
        self.onUpdate = onUpdate
    }
    
    public func makeCoordinator() -> Coordinator {
        coordinator()
    }
 
    public func makeUIView(context: Context) -> View {
        onMake(context)
    }
    
    public func updateUIView(_ uiView: View, context: Context) {
        onUpdate(uiView, context)
    }
}


@available(iOS 13.0, tvOS 13.0, *)
extension VRViewRepresentation where Coordinator == Void {

    public init(
        onMake: @escaping (Context) -> View,
        onUpdate: @escaping (View, Context) -> Void = { _,_ in }
    ) {
        self.coordinator = {}
        self.onMake = onMake
        self.onUpdate = onUpdate
    }

    public init(
        onMake: @escaping () -> View,
        onUpdate: @escaping (View) -> Void = { _ in }
    ) {
        self.coordinator = {}
        self.onMake = { _ in onMake() }
        self.onUpdate = { view, context in onUpdate(view) }
    }
}
