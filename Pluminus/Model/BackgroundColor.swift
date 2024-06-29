//
//  BackgroundColorDB.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/18.
//

import SwiftUI

struct Gradient0001: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G0001_Top,
                    Color.G0001_Center,
                    Color.G0001_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient0203: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G0203_Top,
                    Color.G0203_Center,
                    Color.G0203_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient0405: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G0405_Top,
                    Color.G0405_Center,
                    Color.G0405_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient0607: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G0607_Top,
                    Color.G0607_Center,
                    Color.G0607_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient0809: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G0809_Top,
                    Color.G0809_Center,
                    Color.G0809_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient1011: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G1011_Top,
                    Color.G1011_Center,
                    Color.G1011_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient1213: View {
    @State private var randomPoints: [SIMD2<Float>] = [
        SIMD2<Float>(0.0, 0.7), SIMD2<Float>(0.33, 0.7), SIMD2<Float>(0.66, 0.7), SIMD2<Float>(1.0, 0.7)
    ]
    
    var body: some View {
        if #available(iOS 18.0, *) {
            MeshGradient(
                width: 4,
                height: 3,
                points: [
                    [0.0, 0.0], [0.33, 0.0], [0.66, 0.0], [1.0, 0.0],
                    randomPoints[0], randomPoints[1], randomPoints[2], randomPoints[3],
                    [0.0, 1.0], [0.33, 1.0], [0.66, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color.bg1415Atmosphere, Color.bg1415Atmosphere, Color.bg1415Atmosphere, Color.bg1415Atmosphere,
                    Color.bg1415Sky, Color.bg1415Sky, Color.bg1415Sky, Color.bg1415Sky,
                    Color.bg1415Ground, Color.bg1415Ground, Color.bg1415Ground, Color.bg1415Ground
                ]
            )
            .onAppear {
                startTimer0()
                startTimer1()
                startTimer2()
                startTimer3()
            }
        } else {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.bg1415Atmosphere,
                        Color.bg1415Sky,
                        Color.bg1415Ground
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
    func startTimer0() {
        let randomTimeInterval = Double(Float.random(in: 3.0...6.0))

        Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: randomTimeInterval)) {
                randomPoints[0] = SIMD2<Float>(0.0, Float.random(in: 0.3...0.8))
            }
        }
    }
    func startTimer1() {
        let randomTimeInterval = Double(Float.random(in: 2.0...4.0))

        Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: randomTimeInterval)) {
                randomPoints[1] = SIMD2<Float>(Float.random(in: 0.0...0.5), Float.random(in: 0.3...0.8))
            }
        }
    }
    func startTimer2() {
        let randomTimeInterval = Double(Float.random(in: 2.0...4.0))

        Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: randomTimeInterval)) {
                randomPoints[2] = SIMD2<Float>(Float.random(in: 0.5...1.0), Float.random(in: 0.3...0.8))
            }
        }
    }
    func startTimer3() {
        let randomTimeInterval = Double(Float.random(in: 3.0...6.0))

        Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: randomTimeInterval)) {
                randomPoints[3] = SIMD2<Float>(1.0, Float.random(in: 0.3...0.8))
            }
        }
    }
}


struct Gradient1415: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G1415_Top,
                    Color.G1415_Center,
                    Color.G1415_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient1617: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G1617_Top,
                    Color.G1617_Center,
                    Color.G1617_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient1819: View {
    @State private var randomPoints: [SIMD2<Float>] = [
        SIMD2<Float>(0.0, 0.7), SIMD2<Float>(0.33, 0.7), SIMD2<Float>(0.66, 0.7), SIMD2<Float>(1.0, 0.7)
    ]
    
    var body: some View {
        if #available(iOS 18.0, *) {
            MeshGradient(
                width: 4,
                height: 4,
                points: [
                    [0.0, 0.0], [0.33, 0.0], [0.66, 0.0], [1.0, 0.0],
                    [0.0, 0.2], [0.33, 0.2], [0.66, 0.2], [1.0, 0.2],
                    randomPoints[0], randomPoints[1], randomPoints[2], randomPoints[3],
                    [0.0, 1.0], [0.33, 1.0], [0.66, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color.bg1819Atmosphere, Color.bg1819Atmosphere, Color.bg1819Atmosphere, Color.bg1819Atmosphere,
                    Color.bg1819Atmosphere, Color.bg1819Atmosphere, Color.bg1819Atmosphere, Color.bg1819Atmosphere,
                    Color.bg1819Sky, Color.bg1819Sky, Color.bg1819Sky, Color.bg1819Sky,
                    Color.bg1819Ground, Color.bg1819Ground, Color.bg1819Ground, Color.bg1819Ground
                ]
            )
            .onAppear {
                startTimer0()
                startTimer1()
                startTimer2()
                startTimer3()
            }
        } else {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.bg1819Atmosphere,
                        Color.bg1819Sky,
                        Color.bg1819Ground
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
    func startTimer0() {
        let randomTimeInterval = Double(Float.random(in: 3.0...6.0))

        Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: randomTimeInterval)) {
                randomPoints[0] = SIMD2<Float>(0.0, Float.random(in: 0.3...0.8))
            }
        }
    }
    func startTimer1() {
        let randomTimeInterval = Double(Float.random(in: 2.0...4.0))

        Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: randomTimeInterval)) {
                randomPoints[1] = SIMD2<Float>(Float.random(in: 0.0...0.5), Float.random(in: 0.3...0.8))
            }
        }
    }
    func startTimer2() {
        let randomTimeInterval = Double(Float.random(in: 2.0...4.0))

        Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: randomTimeInterval)) {
                randomPoints[2] = SIMD2<Float>(Float.random(in: 0.5...1.0), Float.random(in: 0.3...0.8))
            }
        }
    }
    func startTimer3() {
        let randomTimeInterval = Double(Float.random(in: 3.0...6.0))

        Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: randomTimeInterval)) {
                randomPoints[3] = SIMD2<Float>(1.0, Float.random(in: 0.3...0.8))
            }
        }
    }
}


struct Gradient2021: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G2021_Top,
                    Color.G2021_Center,
                    Color.G2021_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct Gradient2223: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.G2223_Top,
                    Color.G2223_Center,
                    Color.G2223_Bottom
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct GradientNone: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.primary,
                    Color.primary,
                    Color.primary,
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
