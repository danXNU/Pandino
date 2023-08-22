//
//  RangeSlider.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 31/01/21.
//

import SwiftUI

struct RangeSlider: View {
    @Binding var startValue: Int
    @Binding var endValue: Int
    var range: ClosedRange<Int> = 0...100
    
    @State private var offsetStart: CGFloat = 0
    @State private var offsetEnd: CGFloat = 0
    
    @State private var _newStartPosition: CGFloat = 0
    @State private var _newEndPosition: CGFloat = 0
    
    private let paddingOffset: CGFloat = 20
    
    @State var selection: Selection?
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.primary.opacity(0.15))
                    .frame(maxWidth: .infinity)
                    .frame(height: 20.5)
                
                Capsule()
                    .fill(Color.green)
                    .frame(width: (offsetEnd - offsetStart) + paddingOffset, height: 20.5, alignment: .center)
                    .offset(x: offsetStart)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .fill(selection == .minSlider ? Color.yellow : Color.clear)
                    )
                    .offset(x: offsetStart)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let translation = gesture.translation.width
                                
                                var newValue = translation + self._newStartPosition
                                newValue = max(newValue, 0)
                                newValue = min(newValue, offsetEnd - paddingOffset)
                                
                                self.offsetStart = newValue
                                self.selection = .minSlider
                            }
                            .onEnded { value in
                                var newValue = value.translation.width + _newStartPosition
                                
                                newValue = max(newValue, 0)
                                newValue = min(newValue, offsetEnd - paddingOffset)
                                                                
                                self.offsetStart = newValue
                                self._newStartPosition = self.offsetStart
                                self.selection = nil
                            }
                    )
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .fill(selection == .maxSlider ? Color.yellow : Color.clear)
                    )
                    .offset(x: offsetEnd)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let translation = gesture.translation.width
                                
                                var newValue = translation + _newEndPosition
                                newValue = min(newValue, geo.size.width - paddingOffset)
                                newValue = max(newValue, offsetStart + paddingOffset)
                                
                                
                                offsetEnd = newValue
                                self.selection = .maxSlider
                            }
                            .onEnded { value in
                                var newValue = value.translation.width + _newEndPosition
                                newValue = max(newValue, offsetStart + paddingOffset)
                                newValue = min(newValue, geo.size.width - paddingOffset)
                                
                                offsetEnd = newValue
                                _newEndPosition = offsetEnd
                                
                                self.selection = nil
                            }
                    )
            }
            .onAppear {
                let start = getOffset(raw: startValue, maxWidth: geo.size.width)
                self.offsetStart = start
                self._newStartPosition = start
                
                let end = getOffset(raw: endValue, maxWidth: geo.size.width)
                self.offsetEnd = end
                self._newEndPosition = end
            }
            .onChange(of: self.offsetStart) { newValue in
                //  X : maxValue = currentOffset : maxWidth
                let maxBound = CGFloat(self.range.upperBound)
                let newOffsetValue = newValue //+ paddingOffset
                
                self.startValue = Int(maxBound * newOffsetValue / geo.size.width)
                
                print("Offset start: \(newValue)")
            }
            .onChange(of: self.offsetEnd) { newValue in
                let maxBound = CGFloat(self.range.upperBound)
                let newOffsetValue = newValue + paddingOffset
                
                self.endValue = Int(maxBound * newOffsetValue / geo.size.width)
            }
        }
    }
    
    func getOffset(raw: Int, maxWidth: CGFloat) -> CGFloat {
        var offset = maxWidth / CGFloat(range.upperBound - range.lowerBound) * CGFloat(raw)
        offset = offset - paddingOffset
        
        offset = min(offset, maxWidth)
        offset = max(offset, 0)
        
        print(offset)
        return  offset
    }
    
    enum Selection {
        case minSlider
        case maxSlider
    }
}
