import SwiftUI

public struct NSExpandableView<TopContent: View, BottomContent: View>: View {
    private let topContent: () -> TopContent
    private let bottomContent: () -> BottomContent
    private let cornerRadius: CGFloat
    private let roundedCornerStyle: RoundedCornerStyle
    private let shouldCollapseOnBottomTap: Bool
    private let backgroundColor: Color
    @State private var isExpanded = false

    #if os(iOS)
    public static var defaultBackgroundColor: Color { Color(.secondarySystemBackground) }
    #else
    public static var defaultBackgroundColor: Color { Color.gray.opacity(0.16) }
    #endif

    #if os(iOS)
    public static var defaultCornerRadius: CGFloat {
        if #available(iOS 26.0, *) { return 30 } else { return 10 }
    }
    #else
    public static var defaultCornerRadius: CGFloat { 10 }
    #endif

    public init(
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder bottomContent: @escaping () -> BottomContent,
        cornerRadius: CGFloat = Self.defaultCornerRadius,
        roundedCornerStyle: RoundedCornerStyle = .continuous,
        shouldCollapseOnBottomTap: Bool = true,
        backgroundColor: Color = Self.defaultBackgroundColor
    ) {
        self.topContent = topContent
        self.bottomContent = bottomContent
        self.cornerRadius = cornerRadius
        self.roundedCornerStyle = roundedCornerStyle
        self.shouldCollapseOnBottomTap = shouldCollapseOnBottomTap
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: roundedCornerStyle)
                .foregroundColor(backgroundColor)
                .accessibilityHidden(true)
            VStack {
                HStack {
                    topContent()
                        .accessibilityHint(
                            isExpanded ? String(localized: "Double-tap to collapse section", bundle: .module) :
                                String(localized: "Double-tap to expand section", bundle: .module)
                        )
                    Spacer()
                    Image(systemName: "chevron.down")
                        .imageScale(.large)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .padding(.trailing)
                        .accessibilityHidden(true)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }

                VStack {
                    if isExpanded {
                        HStack {
                            bottomContent()
                                .accessibilityHint(String(localized: "Double-tap to collapse section", bundle: .module))
                            Spacer(minLength: 0)
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if shouldCollapseOnBottomTap {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .rotation3DEffect(.degrees(isExpanded ? 0 : -89), axis: (x: 1, y: 0, z: 0)) // 90 produces warning logs
                .scaleEffect(isExpanded ? 1 : 0.4)
                .animation(.spring(), value: isExpanded)
                .accessibilityAddTraits(isExpanded ? [.isSelected, .isButton] : .isButton)
            }
        }
        .contentShape(Rectangle())
        .animation(.spring(), value: isExpanded)
        .accessibilityElement(children: .contain)
    }
}

struct NSExpandableView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 10) {
                NSExpandableView {
                    Text("Test test test test test")
                        .padding()
                } bottomContent: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Test test test test test")
                        Text("Test test test test test")
                        Text("Test test test test test Test test test fffftest test Test test test f test test")
                        Button {
                            
                        } label: {
                            Label {
                                Text("FOoobar")
                            } icon: {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .padding()
                }
                
                NSExpandableView {
                    Text("Test test test test test")
                        .padding()
                } bottomContent: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test")
                        Text("Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test ")
                        Text("Test test test test test")
                        Text("Test test test test test")
                        Text("Test test test test test")
                        Button {
                            
                        } label: {
                            Label {
                                Text("FOoobar")
                            } icon: {
                                Image(systemName: "checkmark")
                            }
                        }
                        Image(systemName: "bolt")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    .padding()
                }
            }
        }
        .padding()
    }
}
