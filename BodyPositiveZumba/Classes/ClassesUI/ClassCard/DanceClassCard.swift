//
//  DanceClassCard.swift
//  Classes
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct DanceClassCard: View {
    var danceClass: DanceClass
    @Binding var viewState: ClassesViewState
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var showingInfo: Bool = false
    @State private var isDancing: Bool = false  // state for rotation animation

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }
    
    var body: some View {
        VStack(spacing: 0) {
            cardHeader
            
            HStack {
                Image(systemName: "figure.dance")
                    .font(.system(size: 45))
                    .foregroundColor(danceClass.color)
                    .opacity(0.5)
                    .shadow(color: danceClass.color.opacity(0.5), radius: 3, x: 0, y: 2)
                    .padding(.vertical, 11)
                    .rotationEffect(.degrees(isDancing ? 8 : -4))
                    .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: isDancing)
                    .onAppear {
                        isDancing = true
                    }
                Image(systemName: "figure.dance")
                    .font(.system(size: 65))
                    .foregroundColor(danceClass.color)
                    .opacity(0.5)
                    .shadow(color: danceClass.color.opacity(0.5), radius: 3, x: 0, y: 2)
                    .padding(.vertical, 11)
                    .rotationEffect(.degrees(isDancing ? 8 : -4))
                    .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: isDancing)
                Image(systemName: "figure.dance")
                    .font(.system(size: 45))
                    .foregroundColor(danceClass.color)
                    .opacity(0.5)
                    .shadow(color: danceClass.color.opacity(0.5), radius: 3, x: 0, y: 2)
                    .padding(.vertical, 11)
                    .rotationEffect(.degrees(isDancing ? 8 : -4))
                    .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: isDancing)
            }
            
            headerText
                .offset(y: -10)
            Spacer()
            
            VStack(spacing: 10) { // increased spacing between buttons
                // "Learn More" button with creative gradient look and black text
                Button(action: { showingInfo = true }) {
                    HStack {
                        Text("Learn More")
                            .font(.sfProRoundedTextSemibold(size: 18))
                        Image(systemName: "wand.and.stars")
                            .font(.system(size: 20))
                            .bold()
                    }
                }
                .buttonStyle(CoolGradientButtonStyle(color: danceClass.color, textColor: .black))
                
                Button(action: openJoinURL) {
                    HStack {
                        Text(Constants.Classes.joinNowButtonText)
                            .font(.sfProRoundedTextSemibold(size: 18))
                        Image(systemName: "flame.fill")
                            .foregroundColor(danceClass.color)
                            .bold()
                            .shadow(color: danceClass.color.opacity(0.5), radius: 3, x: 0, y: 2)
                    }
                }
                .buttonStyle(CoolOutlineButtonStyle(color: danceClass.color, adaptiveTextColor: adaptiveTextColor))
            }
            .padding(.bottom, 15)
        }
        .frame(width: 260, height: 400)
        .background(cardBackground)
        .cornerRadius(15)
        .overlay(cardBorder)
        .shadow(color: danceClass.color.opacity(0.3), radius: 8, x: 0, y: 4)
        .sheet(item: $viewState.joinNowURL) { joinNow in
            WebViewContainer(url: joinNow.url, title: joinNow.title)
        }
        .sheet(isPresented: $showingInfo) {
            infoSheet
        }
    }
    
    private var cardHeader: some View {
        Rectangle()
            .fill(danceClass.color.opacity(0.65))
            .frame(height: 70)
            .overlay(
                Image(systemName: "sparkles")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            )
            .mask(
                RoundedRectangle(cornerRadius: 15)
                    .padding(.bottom, -15)
            )
    }
    
    private var headerText: some View {
        Text(danceClass.rawValue)
            .font(.sfProDisplayBold(size: 26))
            .fontWeight(.bold)
            .foregroundColor(adaptiveTextColor)
            .multilineTextAlignment(.center)
            .shadow(color: Color.white.opacity(0.5), radius: 1, x: 0, y: 1)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 15)
    }
    
    private var cardBackground: some View {
        RadialGradient(
            gradient: Gradient(colors: [
                danceClass.color.opacity(0.05),
                danceClass.color.opacity(0.38)
            ]),
            center: .center,
            startRadius: 50,
            endRadius: 250
        )
    }
    
    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: 15)
            .strokeBorder(danceClass.color, lineWidth: 2.2)
    }
    
    private var infoSheet: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [danceClass.color.opacity(0.01), danceClass.color.opacity(0.28)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    Image(systemName: "music.quarternote.3")
                        .font(.system(size: 40))
                        .foregroundColor(danceClass.color)
                        .padding(.top, 15)
                    
                    Text(danceClass.rawValue)
                        .font(.sfProDisplayBold(size: 32))
                        .foregroundColor(danceClass.color)
                }
                
                Rectangle()
                    .fill(danceClass.color)
                    .frame(height: 3)
                    .frame(width: 344)
                    .cornerRadius(1.5)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("About This Class")
                            .font(.sfProRoundedTextSemibold(size: 20))
                            .foregroundColor(danceClass.color)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .underline()
                        
                        Text(danceClass.description)
                            .font(.sfProBodyTextRegular(size: 18))
                            .foregroundColor(adaptiveTextColor)
                            .lineSpacing(5)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.7))
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 2)
                )
                .padding(.horizontal, 20)
                
                Spacer()
                
                HStack(spacing: 15) {
                    Button(action: {
                        showingInfo = false
                    }) {
                        Text("Close")
                            .font(.sfProRoundedTextSemibold(size: 18))
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .fill(Color.gray)
                            )
                    }
                    
                    Button(action: {
                        showingInfo = false
                        openJoinURL()
                    }) {
                        Text("Join Now")
                            .font(.sfProRoundedTextSemibold(size: 18))
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .fill(danceClass.color)
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
    }
    
    private func openJoinURL() {
        guard let url = URL(string: Constants.JoinNow.joinNowUrl) else { return }
        viewState.joinNowURL = WebViewURL(
            title: Constants.Classes.joinNowButtonText,
            url: url
        )
    }
}

// MARK: - Custom Button Styles

struct CoolGradientButtonStyle: ButtonStyle {
    var color: Color
    var textColor: Color = .white  // default text color is white, overridable
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 222, height: 44)  // bigger button
            .foregroundColor(textColor)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [color, color.opacity(0.65)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(55)
            .overlay(
                RoundedRectangle(cornerRadius: 55)
                    .stroke(Color.white.opacity(0.8), lineWidth: 1)
                    .blur(radius: 2)
            )
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct CoolOutlineButtonStyle: ButtonStyle {
    var color: Color
    var adaptiveTextColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 222, height: 44)  // bigger button
            .foregroundColor(adaptiveTextColor)
            .background(.ultraThinMaterial) // frosted glass effect
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 55)
                    .stroke(LinearGradient(
                        gradient: Gradient(colors: [color, color.opacity(0.65)]),
                        startPoint: .leading,
                        endPoint: .trailing),
                            lineWidth: 2.5)
            )
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}



