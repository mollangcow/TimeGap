
import Foundation
import Combine

class TimeViewModel: ObservableObject {
    @Published var currentTimeAString: String = ""
    @Published var currentTimeHMMSSString: String = ""
    @Published var currentDateString: String = ""
    
    private var timer: AnyCancellable?
    
    init() {
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTime()
            }
    }
    
    func updateTime(tzOffset: Int = 0) {
        let now = Date()
        currentTimeAString = formatTime(date: now, format: "a", tzOffset: tzOffset)
        currentTimeHMMSSString = formatTime(date: now, format: "h:mm:ss", tzOffset: tzOffset)
        currentDateString = formatDate(date: now, format: "E dd, MMM yyyy", tzOffset: tzOffset)
    }
    
    private func formatTime(date: Date, format: String, tzOffset: Int) -> String {
        let fmt = DateFormatter()
        let offsetInSeconds = tzOffset * 3600
        let targetTimeZone = TimeZone(secondsFromGMT: offsetInSeconds)
        
        fmt.timeZone = targetTimeZone
        fmt.dateFormat = format
        fmt.locale = Locale(identifier: "en_US")
        
        return fmt.string(from: date)
    }
    
    private func formatDate(date: Date, format: String, tzOffset: Int) -> String {
        let fmt = DateFormatter()
        let offsetInSeconds = tzOffset * 3600
        let targetTimeZone = TimeZone(secondsFromGMT: offsetInSeconds)
        
        fmt.timeZone = targetTimeZone
        fmt.dateFormat = format
        fmt.locale = Locale(identifier: "en_US")
        
        return fmt.string(from: date)
    }
}
