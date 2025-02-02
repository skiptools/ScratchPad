// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct TimerPlayground: View {
    @State var count = 0

    var body: some View {
        VStack(spacing: 16) {
            TimerPlaygroundTimerView(message: "Tap count: \(count)")
            Button("Tap to recompose in 1 sec") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    count += 1
                }
            }
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "TimerPlayground.swift")
        }
    }
}

private struct TimerPlaygroundTimerView: View {
    let message: String
    let timer = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()
    @State var timerDate: Date?
    @State var ticks = 0

    var body: some View {
        VStack {
            Text(message)
            Text("Time: \(timerDate == nil ? "nil" : timerDate!.formatted(date: .omitted, time: .standard))")
            Text("Ticks: \(ticks)")
        }
        .font(.largeTitle)
        .onReceive(timer) { date in
            timerDate = date
            ticks += 1
        }
    }
}
