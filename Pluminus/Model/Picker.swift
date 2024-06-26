//
//  CustomPicker.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/01.
//

import Foundation
import SwiftUI

struct CustomPicker: UIViewRepresentable {
    
    typealias UIViewType = UIPickerView
    
    @Binding var dataSource: [[String]]
    @Binding var selectedPicker: [Int]
    
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth/2, height: 50))
        
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        
        return pickerView
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        for i in 0..<selectedPicker.count {
            uiView.selectRow(selectedPicker[i], inComponent: i, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, dataSource: $dataSource, selectedPicker: $selectedPicker)
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var parent: CustomPicker
        @Binding var dataSource: [[String]]
        @Binding var selectedPicker: [Int]
        
        init(parent: CustomPicker, dataSource: Binding<[[String]]>, selectedPicker: Binding<[Int]>) {
            self.parent = parent
            self._dataSource = dataSource
            self._selectedPicker = selectedPicker
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return dataSource.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            guard component < dataSource.count, row < dataSource[component].count else {
                print("Error: Trying to access invalid index component: \(component), row: \(row)")
                return nil
            }
            return dataSource[component][row]
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            guard component < dataSource.count else {
                print("Error: Trying to access invalid component index: \(component)")
                return 0
            }
            return dataSource[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            guard component < selectedPicker.count else {
                print("Error: Trying to access invalid selectedPicker index: \(component)")
                return
            }
            $selectedPicker.wrappedValue[component] = row
            switch $selectedPicker.wrappedValue[0] {
            case 0:
                print("----- Main Picker case0 : \(row)")
            case 1:
                print("----- Main Picker case1 : \(-row)")
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
