import SwiftUI

@available(iOS 13.0, *)
public struct NSExpandableView<TopContent: View, BottomContent: View>: View {
    private let topContent: () -> TopContent
    private let bottomContent: () -> BottomContent
    private let cornerRadius: CGFloat
    private let roundedCornerStyle: RoundedCornerStyle
    private let shouldCollapseOnBottomTap: Bool
    private let backgroundColor: Color
    @State private var isExpanded = false
    
    public init(@ViewBuilder topContent: @escaping () -> TopContent,
                @ViewBuilder bottomContent: @escaping () -> BottomContent,
                cornerRadius: CGFloat = 10,
                roundedCornerStyle: RoundedCornerStyle = .continuous,
                shouldCollapseOnBottomTap: Bool = true,
                backgroundColor: Color = Color(.secondarySystemBackground)) {
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
            VStack(alignment: .leading) {
                HStack {
                    topContent()
                    Spacer()
                    Image(systemName: "chevron.down")
                        .imageScale(.large)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .padding(.trailing)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }

                VStack {
                    if isExpanded {
                        bottomContent()
                    }
                }
                .onTapGesture {
                    if shouldCollapseOnBottomTap {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .rotation3DEffect(.degrees(isExpanded ? 0 : -90), axis: (x: 1, y: 0, z: 0))
                .scaleEffect(isExpanded ? 1 : 0.4)
                .animation(.spring(), value: isExpanded)
            }
        }
        .contentShape(Rectangle())
        .animation(.spring(), value: isExpanded)
    }
}
