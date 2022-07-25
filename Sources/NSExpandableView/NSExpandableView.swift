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
            VStack {
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
                        HStack {
                            bottomContent()
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
                .rotation3DEffect(.degrees(isExpanded ? 0 : -90), axis: (x: 1, y: 0, z: 0))
                .scaleEffect(isExpanded ? 1 : 0.4)
                .animation(.spring(), value: isExpanded)
            }
        }
        .contentShape(Rectangle())
        .animation(.spring(), value: isExpanded)
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

