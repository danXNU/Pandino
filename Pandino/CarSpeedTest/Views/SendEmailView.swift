//
//  SendEmailView.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 11/02/21.
//

import SwiftUI
import MessageUI

struct SendEmailView: UIViewControllerRepresentable {
    
    var subject: String
    var attachments: [MailAttachment]
    var completion: (Error?) -> Void
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(["danxnu-apps-support@protonmail.com"])
        mail.setSubject(subject)
        
        for attachment in attachments {
            mail.addAttachmentData(attachment.data, mimeType: attachment.type, fileName: attachment.fileName)
        }
        return mail
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        var completion: (Error?) -> Void
        
        init(completion: @escaping (Error?) -> Void) {
            self.completion = completion
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            completion(error)
        }
    }
        
    
    struct MailAttachment {
        var data: Data
        var type: String
        var fileName: String
    }
}
