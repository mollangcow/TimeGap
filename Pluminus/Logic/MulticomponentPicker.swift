//
//  MulticomponentPicker.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/01.
//

import Foundation
import SwiftUI

struct MulticomponentPicker: UIViewRepresentable {
    
    typealias UIViewType = UIPickerView
    
    @Binding var dataSource: [[String]]
    @Binding var selected: [Int]
    
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 50))
        
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        
        return pickerView
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        for i in 0..<selected.count {
            uiView.selectRow(selected[i], inComponent: i, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, dataSource: $dataSource, selected: $selected)
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var parent: MulticomponentPicker
        @Binding var dataSource: [[String]]
        @Binding var selected: [Int]
        
        init(parent: MulticomponentPicker, dataSource: Binding<[[String]]>, selected: Binding<[Int]>) {
            self.parent = parent
            self._dataSource = dataSource
            self._selected = selected
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return dataSource.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return dataSource[component][row]
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dataSource[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            $selected.wrappedValue[component] = row
            switch $selected.wrappedValue[0] {
            case 0:
                print(row)
            case 1:
                print(-row)
            default:
                fatalError("You Die")
            }
        }
    }
}

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIView.noIntrinsicMetric,
            height: super.intrinsicContentSize.height
        )
    }
}
