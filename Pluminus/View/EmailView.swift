//
//  EmailView.swift
//  Pluminus
//
//  Created by kimsangwoo on 10/17/23.
//

import SwiftUI
import MessageUI

struct EmailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        
        viewController.setToRecipients(["mollangcow@gmail.com"])
        
        viewController.setSubject("[TimeGap] 문의")
        
        let emailBody = "1. 사용 중인 iPhone 기종을 입력해 주세요. \n - \n 2. 오류 문의 내용을 작성해 주세요. \n - \n 3. 오류 발생 화면을 캡쳐해서 넣어주세요. \n -"
        viewController.setMessageBody(emailBody, isHTML: false)
        
        viewController.mailComposeDelegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // Configure the email compose view here if needed
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: EmailView

        init(_ parent: EmailView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if let error = error {
                parent.result = .failure(error)
            } else {
                parent.result = .success(result)
            }
            parent.isShowing = false
        }
    }
}
