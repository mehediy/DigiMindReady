//
//  PDFUIView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import Foundation

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {

    let pdfDocument: PDFDocument

    init(showing pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }

    //you could also have inits that take a URL or Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}


struct PDFUIView: View {

    let pdfDoc: PDFDocument

    init(fileName: String) {
        //for the sake of example, we're going to assume
        //you have a file Lipsum.pdf in your bundle
        let url = Bundle.main.url(forResource: fileName, withExtension: "pdf")!
        pdfDoc = PDFDocument(url: url)!
    }

    var body: some View {
        PDFKitView(showing: pdfDoc)
    }
}
