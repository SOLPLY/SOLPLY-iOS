//
//  OnboardingView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @State private var selectedTab: Int = 0
    @State private var progress: CGFloat = 0
    
    let icons: [String] = ["집애", "가고", "싶어요"]
    
    var body: some View {
        
        VStack {
            
            Spacer()
                
            ProgressBar(progress: $progress)
            
            
            TabView(selection: $selectedTab) {
                ForEach(icons.indices, id: \.self) { index in
                    ZStack {
                        Text(icons[index])
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .tag(index)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.7)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onAppear {
                progress = CGFloat(selectedTab + 1) / CGFloat(icons.count)
            }
            .onChange(of: selectedTab) { _, newValue in
                withAnimation(.easeInOut(duration: 0.5)) {
                    progress = CGFloat(newValue + 1) / CGFloat(icons.count)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(.coreBlack)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppCoordinator())
}
