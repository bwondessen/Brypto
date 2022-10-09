//
//  PieChartView.swift
//
//
//  Created by Nazar Ilamanov on 4/23/21.
//

import SwiftUI

@available(OSX 10.15, *)
public struct PieChartView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    public let values: [Double]
    public let names: [String]
    public let formatter: (Double) -> String
    
    public var colors: [Color]
    public var backgroundColor: Color
    
    public var widthFraction: CGFloat
    public var innerRadiusFraction: CGFloat
    
    @State private var activeIndex: Int = -1
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors.randomElement() ?? Color.cyan))
            endDeg += degrees
        }
        return tempSlices
    }
    
    public init(values:[Double], names: [String], formatter: @escaping (Double) -> String, colors: [Color] = [Color.blue, Color.green, Color.orange, Color.cyan, Color.primary, Color.yellow, Color.teal, Color.red, Color.purple, Color.mint, Color.indigo, Color.gray, Color.brown], backgroundColor: Color = Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), widthFraction: CGFloat = 0.75, innerRadiusFraction: CGFloat = 0.60){
        self.values = values
        self.names = names
        self.formatter = formatter
        
        self.colors = colors
        self.backgroundColor = backgroundColor
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
    }
    
    public var body: some View {
        //GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<self.values.count){ i in
                        PieSlice(pieSliceData: self.slices[i])
                            .scaleEffect(self.activeIndex == i ? 1.03 : 1)
                            .animation(Animation.spring())
                    }
                    .frame(width: widthFraction * UIScreen.main.bounds.width, height: widthFraction * UIScreen.main.bounds.width)
//                    .frame(width: widthFraction * geometry.size.width, height: widthFraction * geometry.size.width)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let radius = 0.5 * widthFraction * UIScreen.main.bounds.width
//                                let radius = 0.5 * widthFraction * geometry.size.width
                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                if (dist > radius || dist < radius * innerRadiusFraction) {
                                    self.activeIndex = -1
                                    return
                                }
                                var radians = Double(atan2(diff.x, diff.y))
                                if (radians < 0) {
                                    radians = 2 * Double.pi + radians
                                }
                                
                                for (i, slice) in slices.enumerated() {
                                    if (radians < slice.endAngle.radians) {
                                        self.activeIndex = i
                                        break
                                    }
                                }
                            }
                            .onEnded { value in
                                self.activeIndex = -1
                            }
                    )
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(width: widthFraction * UIScreen.main.bounds.width * innerRadiusFraction, height: widthFraction * UIScreen.main.bounds.width * innerRadiusFraction)
//                        .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)
                    
                    VStack {
                        Text(self.activeIndex == -1 ? "Total" : names[self.activeIndex])
                            .font(.title)
                            .foregroundColor(Color.theme.secondaryText)
                        Text(self.formatter(self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex]))
                            .font(.title.bold())
                            .foregroundColor(Color.theme.accent)
                    }
                    
                }
                PieChartRows(colors: self.colors, names: self.names, values: self.values.map { self.formatter($0) }, percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) }, purchasedCoins: vm.purchasedCoins)
            }
            .background(self.backgroundColor)
            .font(.subheadline)
            .foregroundColor(Color.theme.secondaryText)
        //}
    }
}

@available(OSX 10.15, *)
struct PieChartRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    let purchasedCoins: [CoinModel]
    @State private var showDetailView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    
    var body: some View {
        VStack{
            ForEach(0..<self.values.count){ i in
                HStack {
                    CoinImageView(coin: purchasedCoins[i])
                        .frame(width: 30, height: 30)
//                    RoundedRectangle(cornerRadius: 5.0)
//                        .fill(self.colors[i])
//                        .frame(width: 20, height: 20)
                    Text(self.names[i])
                        .font(.headline)
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(self.values[i])
                            .bold()
                            .foregroundColor(Color.theme.accent)
                        Text(self.percents[i])
                            .font(.headline)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }
                .onTapGesture {
                    segue(coin: purchasedCoins[i])
                }
            }
        }
        .background(
            NavigationLink(
                isActive: $showDetailView,
                destination: { DetailLoadingView(coin: $selectedCoin) },
                label: { EmptyView() })
        )
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
}

@available(OSX 10.15.0, *)
struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(values: [1300, 500, 300], names: ["Rent", "Transport", "Education"], formatter: {value in String(format: "$%.2f", value)})
    }
}


