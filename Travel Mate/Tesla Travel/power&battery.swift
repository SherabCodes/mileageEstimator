//
//  power&battery.swift
//  Tesla Travel
//
//  Created by Sherab on 5/9/25.
//

import SwiftUI

struct PowerBatteryView: View {
    @State private var selectedTab = 0
    let tabs = ["Last 24 hours", "Last 3 days", "Last 7 days"]

    //power usage data
    let dataSets: [[CGFloat]] = [
        [22, 25, 24, 26, 25, 23, 22, 24],               //  24 hours
        [28, 23, 25, 20, 24],                           //  3 days
        [30, 28, 14, 13, 26, 30, 12]                    //  7 days
    ]

    let history = [
        ("Downtown → Uptown", "12.0%", "15.4 km", "May 5, 2025"),
        ("Home → Work", "18.0%", "20.1 km", "May 4, 2025"),
        ("Mall → Gym", "7.0%", "5.5 km", "May 3, 2025"),
        ("Work → Cafe", "5.0%", "2.1 km", "May 3, 2025"),
        ("Gym → Home", "6.5%", "3.4 km", "May 2, 2025"),
        ("Grocery → Home", "8.0%", "4.7 km", "May 1, 2025"),
        ("Park → Downtown", "10.0%", "6.3 km", "Apr 30, 2025")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Power & Battery")
                .font(.title)
                .bold()

            // Segmented Control
            HStack {
                ForEach(0..<tabs.count) { index in
                    Button(action: {
                        selectedTab = index
                    }) {
                        Text(tabs[index])
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(selectedTab == index ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedTab == index ? .white : .black)
                            .cornerRadius(10)
                    }
                }
            }

            Text("Power Usage (kWh)")
                .font(.headline)

         
            LineChart(data: dataSets[selectedTab])
                .frame(height: 200)

            Text("Battery Usage History")
                .font(.headline)

            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(history, id: \.0) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.0).bold()
                            Text("Battery: \(item.1) | Distance: \(item.2)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Date: \(item.3)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Divider()
                    }
                }
            }

            Spacer()
        }
        .padding()
    }
}

struct LineChart: View {
    let data: [CGFloat]

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height

            let maxVal = (data.max() ?? 1)
            let minVal = (data.min() ?? 0)
            let stepX = width / CGFloat(data.count - 1)

            let points = data.enumerated().map { index, value in
                CGPoint(
                    x: CGFloat(index) * stepX,
                    y: height - (value - minVal) / (maxVal - minVal) * height
                )
            }

            Path { path in
                guard points.count > 1 else { return }
                path.move(to: points[0])

                for i in 1..<points.count {
                    path.addLine(to: points[i])
                }
            }
            .stroke(Color.blue, lineWidth: 2)
            .overlay(
                ForEach(points, id: \.self) { point in
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 6, height: 6)
                        .position(point)
                }
            )
        }
    }
}
