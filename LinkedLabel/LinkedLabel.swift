//
//  LinkedLabel.swift
//  LinkedLabel
//
//  Created by Leo Zhou on 2018/5/6.
//  Copyright © 2018年 Wiredcraft. All rights reserved.
//

import UIKit

public class LinkedLabel: UILabel {

    public typealias Link = (string: String, attributes: [NSAttributedStringKey: Any], action: (String) -> Void)

    private var links: [Link] = []

    private var selectedLink: Link?

    public func addLinks(_ links: [Link]) {
        self.links = links

        isUserInteractionEnabled = true

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        let attributedText = NSMutableAttributedString(string: text!, attributes: [.font: font, .foregroundColor: textColor, .paragraphStyle: paragraphStyle])
        self.attributedText = attributedText

        links.forEach { addAttributes(for: $0, isHighlighted: false) }
    }

    private func addAttributes(for link: Link, isHighlighted: Bool) {
        let attributedText = self.attributedText!.mutableCopy() as! NSMutableAttributedString
        let range = (attributedText.string as NSString).range(of: link.string)

        var attributes = link.attributes
        let color = attributes[.foregroundColor] as? UIColor ?? textColor
        attributes[.foregroundColor] = isHighlighted ? color!.withAlphaComponent(0.2) : color

        attributedText.addAttributes(attributes, range: range)
        self.attributedText = attributedText
        layer.add(CATransition(), forKey: nil)
    }

    private func detectLink(_ point: CGPoint) -> Link? {
        let container = NSTextContainer(size: frame.size)
        container.lineFragmentPadding = 0
        let manager = NSLayoutManager()
        manager.addTextContainer(container)
        let store = NSTextStorage(attributedString: attributedText!)
        store.addLayoutManager(manager)

        for link in links {
            var range = (attributedText!.string as NSString).range(of: link.string)
            manager.characterRange(forGlyphRange: range, actualGlyphRange: &range)

            var beginRect = manager.lineFragmentRect(forGlyphAt: range.location, effectiveRange: nil)
            var endRect = manager.lineFragmentRect(forGlyphAt: range.location + range.length, effectiveRange: nil)
            let beginPoint = manager.location(forGlyphAt: range.location)
            let endPoint = manager.location(forGlyphAt: range.location + range.length)

            if beginRect.origin.y == endRect.origin.y {
                beginRect.origin.x = beginPoint.x
                beginRect.size.width = abs(endPoint.x - beginPoint.x)
                if beginRect.contains(point) { return link }
            } else {
                let rect = CGRect(x: 0, y: beginRect.maxY, width: beginRect.width, height: endRect.minY - beginRect.maxY)
                if rect.contains(point) { return link }

                beginRect.origin.x = beginPoint.x
                beginRect.size.width -= beginPoint.x
                if beginRect.contains(point) { return link }

                endRect.size.width = endPoint.x
                if endRect.contains(point) { return link }
            }
        }
        return nil
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        selectedLink = detectLink(point)
        if let link = selectedLink {
            addAttributes(for: link, isHighlighted: true)
        }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let link = selectedLink else { return }
        link.action(link.string)
        addAttributes(for: link, isHighlighted: false)
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }

}
