import SwiftUI


@available(iOS 13.0, tvOS 13.0, *)
public struct VRViewRepresentable<View, Coordinator>: UIViewRepresentable where View: UIView {

    private let coordinator: () -> Coordinator
    private let onMake: (Context) -> View
    private let onUpdate: (View, Context) -> Void
    
    public init(
        coordinator: @escaping () -> Coordinator,
        onMake: @escaping (Context) -> View,
        onUpdate: ((View, Context) -> Void)? = nil
    ) {
        self.coordinator = coordinator
        self.onMake = onMake
        self.onUpdate = onUpdate ?? { _,_ in }
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
extension VRViewRepresentable where Coordinator == Void {

    public init(onMake: @escaping (Context) -> View, onUpdate: ((View, Context) -> Void)? = nil) {
        self.coordinator = {}
        self.onMake = onMake
        self.onUpdate = onUpdate ?? { _,_ in }
    }

    public init(onMake: @escaping () -> View, onUpdate: ((View) -> Void)? = nil) {
        self.coordinator = {}
        self.onMake = { _ in onMake() }
        self.onUpdate = { view, context in onUpdate?(view) }
    }
}
