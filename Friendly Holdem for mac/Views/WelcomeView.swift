//
//  WelcomeView.swift
//  CardPlay
//
//  Created by Ionut on 20.09.2021.
//

import SwiftUI
#if os(iOS)
import CoreMotion
#endif

struct WelcomeView: View {
    @ObservedObject private var glop = GlobalPreferences2.global
#if os(iOS)
    @StateObject private var motion = MotionManager.getInstance
#endif

    var whenClickedContinue: (() -> Void)?
    //static let bg1: Color = Color.systemBackground.blendMed( with: .gray)
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            GeometryReader {geo in
                VStack(alignment: .center, spacing: 12) {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Welcome to")
                        Text("Friendly Hold'em.")
                    }
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .padding()
                    Text("Your very accessible game of Texas Hold'em")
                        .font(.title.bold())
                        .multilineTextAlignment(.center)
                        .padding()
                } //vs
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .accessibilityElement(children: .combine)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.secondary, lineWidth: 5)
                })
#if os(iOS)
                .rotation3DEffect(.radians(motion.pitch_x), axis: (x: 1.0, y: 0.0, z: 0.0))
                #endif
            } //geo
            .padding(.vertical)
            Toggle("Skip this intro from now on", isOn: self.$glop.skipWelcome)
                .font(.title)
                .padding(.horizontal)
            Button {
                self.whenClickedContinue?()
            } label: {
                Text("Next")
                    .font(.largeTitle)
                    .padding()
            } //btn
        } //vs
        .onAppear {
#if os(iOS)
            motion.registerView()
            #endif
        } //onapp
        .onDisappear {
#if os(iOS)
            motion.unregisterView()
            #endif
        }
    } //body
} //str

#if os(iOS)
class MotionManager: ObservableObject {
    static let getInstance = MotionManager()
    
    private let motionManager = CMMotionManager()
    private var registeredViewCount = 0
    @Published var roll_z = 0.0
    @Published var pitch_x = 0.0
    @Published var yaw_y = 0.0
    
    private init () {
        motionManager.deviceMotionUpdateInterval = 1 / 25
    } //init
    func unregisterView() -> Void {
        registeredViewCount -= 1
        print("unreg \(registeredViewCount)")
        guard registeredViewCount == 0 else {
            return
        } //gua
        motionManager.stopDeviceMotionUpdates()
    } //func
    func registerView() -> Void {
        registeredViewCount += 1
        print("reg \(registeredViewCount)")
        guard registeredViewCount == 1 else {
            return
        } //gua
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else {
                return
            } //gua
            self?.roll_z = motion.roll
            self?.pitch_x = motion.pitch
            self?.yaw_y = motion.yaw
        } //clo
    } //func
} //cl
#endif


