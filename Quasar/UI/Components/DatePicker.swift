//
//  DatePicker.swift
//  QuazarV4
//
//  Created by Will on 4/14/21.
//

import SwiftUI

struct DateWheelPicker: View {
    @State private var date = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31)
        return calendar.date(from: startComponents)!
            ...
            calendar.date(from: endComponents)!
    }()
    
    var body: some View {
        DatePicker(
            " ",
            selection: $date,
            in: dateRange,
            displayedComponents: [.date]
        )
        .datePickerStyle(GraphicalDatePickerStyle())
    }
}
