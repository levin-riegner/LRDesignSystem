//
//  DTTextField.swift
//  Pods
//
//  Created by Dhaval Thanki on 03/04/17.
//
//

import Foundation
import UIKit

public extension String {
    var isEmptyStr: Bool {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
}

public class FieldTextBase: UITextField {


    let imageError = UIImageView(image: #imageLiteral(resourceName: "S_Error"))



    //Active
    @IBInspectable
    public var placeholderActiveColor: UIColor? {
        didSet {
            guard let color = placeholderActiveColor else { return }
            floatPlaceholderActiveColor = color
        }
    }


    //Active
    @IBInspectable
    public var hintActiveColor: UIColor? {
        didSet {
            guard let color = hintActiveColor else { return }
            floatPlaceholderActiveColor = color
        }
    }

    @IBInspectable
    public var borderColorOn: UIColor = UIColor.red {
        didSet
        {
            dtLayer.borderColor = borderColorOn.cgColor
        }
    }


    //Inactive
    @IBInspectable
    public var placeHolderColor: UIColor? {
        didSet {
            guard let color = placeHolderColor else { return }
            attributedPlaceholder = NSAttributedString(string: placeholderFinal.capitalized,
                attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }

    @IBInspectable
    public var borderColorOff: UIColor = UIColor.red {
        didSet
        {
            print("BorderCOLOR OFF")
        }
    }

    public enum FloatingDisplayStatus {
        case always
        case never
        case defaults
    }

    public enum DTBorderStyle {
        case none
        case rounded
        case sqare
    }

    fileprivate var lblFloatPlaceholder: UILabel = UILabel()
    fileprivate var lblError: UILabel = UILabel()
    fileprivate let paddingX: CGFloat = 15.0
    fileprivate let paddingHeight: CGFloat = 0
    public var dtLayer: CALayer = CALayer()
    public var floatplaceHolderColor: CGColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
    public var floatPlaceholderActiveColor: UIColor = UIColor.black
    public var floatingLabelShowAnimationDuration = 0.3
    public var floatingDisplayStatus: FloatingDisplayStatus = .defaults

    public var dtborderStyle: DTBorderStyle = .rounded {
        didSet {
            switch dtborderStyle {
            case .none:
                dtLayer.cornerRadius = 0.0
                dtLayer.borderWidth = 0.0
                dtLayer.borderColor = borderColorOff.cgColor
            case .rounded:
                dtLayer.cornerRadius = 8
                dtLayer.borderWidth = 1.5
                dtLayer.borderColor = borderColorOff.cgColor
            case .sqare:
                dtLayer.cornerRadius = 0.0
                dtLayer.borderWidth = 0.5
                dtLayer.borderColor = borderColorOff.cgColor
            }
        }
    }

    public var errorMessage: String = "" {
        didSet { lblError.text = errorMessage }
    }

    public var animateFloatPlaceholder: Bool = true
    public var hideErrorWhenEditing: Bool = true

    public var errorFont = UIFont.bodySmall {
        didSet { invalidateIntrinsicContentSize() }
    }

    public var floatPlaceholderFont = UIFont.label {
        didSet { invalidateIntrinsicContentSize() }
    }

    public var paddingYFloatLabel: CGFloat = 9.0 {
        didSet { invalidateIntrinsicContentSize() }
    }

    public var paddingYErrorLabel: CGFloat = 5.0 {
        didSet { invalidateIntrinsicContentSize() }
    }

    @IBInspectable
    public var canShowBorder: Bool = true {
        didSet { dtLayer.isHidden = !canShowBorder }
    }


    fileprivate var x: CGFloat {

        if let leftView = leftView {
            return leftView.frame.origin.x + leftView.bounds.size.width - paddingX
        }
        return paddingX
    }

    fileprivate var fontHeight: CGFloat {
        return ceil(font!.lineHeight)
    }

    fileprivate var dtLayerHeight: CGFloat {
        return 54
    }

    fileprivate var floatLabelWidth: CGFloat {

        var width = bounds.size.width
        if let leftViewWidth = leftView?.bounds.size.width {
            width -= leftViewWidth
        }

        if let rightViewWidth = rightView?.bounds.size.width {
            width -= rightViewWidth
        }
        return width - (self.x * 2)
    }

    fileprivate var placeholderFinal: String {
        if let attributed = attributedPlaceholder { return attributed.string }
        return placeholder ?? " "
    }

    fileprivate var isFloatLabelShowing: Bool = false

    fileprivate var showErrorLabel: Bool = false {
        didSet {

            guard showErrorLabel != oldValue else { return }

            guard showErrorLabel else {
                hideErrorMessage()
                return
            }

            guard !errorMessage.isEmptyStr else { return }
            showErrorMessage()
        }
    }

    override public var borderStyle: UITextField.BorderStyle {
        didSet {
            guard borderStyle != oldValue else { return }
            borderStyle = .none
        }
    }

    public override var textAlignment: NSTextAlignment {
        didSet { setNeedsLayout() }
    }

    public override var text: String? {
        didSet {
            self.textFieldTextChanged()
        }
    }

    override public var placeholder: String? {
        didSet {

            guard let color = placeHolderColor else {
                lblFloatPlaceholder.text = placeholderFinal.capitalized
                return
            }
            attributedPlaceholder = NSAttributedString(string: placeholderFinal.capitalized,
                attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }

    override public var attributedPlaceholder: NSAttributedString? {
        didSet { lblFloatPlaceholder.text = placeholderFinal.uppercased() }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public func showError(message: String? = nil) {
        if let msg = message { errorMessage = msg }
        showErrorLabel = true
        imageError.isHidden = false
    }

    public func hideError() {
        showErrorLabel = false
        imageError.isHidden = true
    }


    fileprivate func commonInit() {
        imageError.isHidden = true
        dtborderStyle = .rounded
        dtLayer.backgroundColor = UIColor.clear.cgColor

        floatplaceHolderColor = placeHolderColor?.cgColor ?? UIColor.black.cgColor
        floatPlaceholderActiveColor = hintActiveColor ?? UIColor.red
        lblFloatPlaceholder.frame = CGRect.zero
        lblFloatPlaceholder.alpha = 0.0
        lblFloatPlaceholder.font = floatPlaceholderFont
        self.font = .bodyLarge
        lblFloatPlaceholder.text = placeholderFinal

        dtLayer.borderColor = borderColorOff.cgColor

        addSubview(lblFloatPlaceholder)

        lblError.frame = CGRect.zero
        lblError.font = errorFont
        lblError.textColor = UIColor.secondaryActive
        lblError.numberOfLines = 0
        lblError.isHidden = true

        addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)

        addSubview(lblError)

        layer.insertSublayer(dtLayer, at: 0)
    }

    fileprivate func showErrorMessage() {

        lblError.text = errorMessage
        lblError.isHidden = false
        let boundWithPadding = CGSize(width: bounds.width - (paddingX * 2), height: bounds.height)
        lblError.frame = CGRect(x: paddingX + 6, y: 0, width: boundWithPadding.width - 15, height: boundWithPadding.height)
        lblError.sizeToFit()

        invalidateIntrinsicContentSize()

    }

    func setErrorLabelAlignment() {
        var newFrame = lblError.frame

        if textAlignment == .right {
            newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
        } else if textAlignment == .left {
            newFrame.origin.x = paddingX
        } else if textAlignment == .center {
            newFrame.origin.x = (bounds.width / 2.0) - (newFrame.size.width / 2.0)
        } else if textAlignment == .natural {

            if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
                newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
            }
        }
        lblError.frame = newFrame
    }

    func setFloatLabelAlignment() {
        var newFrame = lblFloatPlaceholder.frame

        if textAlignment == .right {
            newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
        } else if textAlignment == .left {
            newFrame.origin.x = paddingX
        } else if textAlignment == .center {
            newFrame.origin.x = (bounds.width / 2.0) - (newFrame.size.width / 2.0)
        } else if textAlignment == .natural {
            if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
                newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
            }
        }
        lblFloatPlaceholder.frame = newFrame
    }

    fileprivate func hideErrorMessage() {
        lblError.text = ""
        lblError.isHidden = true
        lblError.frame = CGRect.zero
        imageError.isHidden = true
        invalidateIntrinsicContentSize()
    }

    fileprivate func showFloatingLabel(_ animated: Bool) {

        let animations: (() -> ()) = {
            self.lblFloatPlaceholder.alpha = 1.0
            self.lblFloatPlaceholder.frame = CGRect(x: self.lblFloatPlaceholder.frame.origin.x,
                y: self.paddingYFloatLabel,
                width: self.lblFloatPlaceholder.bounds.size.width,
                height: self.lblFloatPlaceholder.bounds.size.height)
        }

        if animated && animateFloatPlaceholder {
            UIView.animate(withDuration: floatingLabelShowAnimationDuration,
                delay: 0.0,
                options: [.beginFromCurrentState, .curveEaseOut],
                animations: animations) { status in
                DispatchQueue.main.async {
                    self.layoutIfNeeded()
                }
            }
        } else {
            animations()
        }
    }

    fileprivate func hideFlotingLabel(_ animated: Bool) {

        let animations: (() -> ()) = {
            self.lblFloatPlaceholder.alpha = 0.0
            self.lblFloatPlaceholder.frame = CGRect(x: self.lblFloatPlaceholder.frame.origin.x,
                y: self.lblFloatPlaceholder.font.lineHeight,
                width: self.lblFloatPlaceholder.bounds.size.width,
                height: self.lblFloatPlaceholder.bounds.size.height)
        }

        if animated && animateFloatPlaceholder {
            UIView.animate(withDuration: floatingLabelShowAnimationDuration,
                delay: 0.0,
                options: [.beginFromCurrentState, .curveEaseOut],
                animations: animations) { status in
                DispatchQueue.main.async {
                    self.layoutIfNeeded()
                }
            }
        } else {
            animations()
        }
    }

    fileprivate func insetRectForEmptyBounds(rect: CGRect) -> CGRect {
        let newX = x
        guard showErrorLabel else { return CGRect(x: newX, y: 0, width: rect.width - newX - paddingX, height: rect.height) }

        let topInset = (rect.size.height - paddingYErrorLabel - fontHeight) / 2.0
        let textY = topInset - ((rect.height - fontHeight) / 2.0)

        return CGRect(x: newX, y: floor(textY), width: rect.size.width - newX - paddingX, height: rect.size.height)
    }

    fileprivate func insetRectForBounds(rect: CGRect) -> CGRect {

        guard let placeholderText = lblFloatPlaceholder.text, !placeholderText.isEmptyStr else {
            return insetRectForEmptyBounds(rect: rect)
        }

        if floatingDisplayStatus == .never {
            return insetRectForEmptyBounds(rect: rect)
        } else {

            if let text = text, text.isEmptyStr, !isFirstResponder {
                return insetRectForEmptyBounds(rect: rect)
            } else {
                let topInset = paddingYFloatLabel + lblFloatPlaceholder.bounds.size.height + (paddingHeight / 2.0)
                let textOriginalY = (rect.height - fontHeight) / 2.0
                var textY = topInset - textOriginalY

                if textY < 0 && !showErrorLabel { textY = topInset }
                let newX = x
                return CGRect(x: newX, y: ceil(textY), width: rect.size.width - newX - paddingX, height: rect.height)
            }
        }
    }

    @objc fileprivate func textFieldTextChanged() {
        guard hideErrorWhenEditing && showErrorLabel else { return }
        showErrorLabel = false
    }

    override public var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()

        let textFieldIntrinsicContentSize = super.intrinsicContentSize

        if showErrorLabel {
            lblFloatPlaceholder.sizeToFit()
            return CGSize(width: textFieldIntrinsicContentSize.width,
                height: textFieldIntrinsicContentSize.height + paddingYFloatLabel + paddingYErrorLabel + lblFloatPlaceholder.bounds.size.height + lblError.bounds.size.height + paddingHeight)
        } else {
            return CGSize(width: textFieldIntrinsicContentSize.width,
                height: textFieldIntrinsicContentSize.height + paddingYFloatLabel + lblFloatPlaceholder.bounds.size.height + paddingHeight)
        }
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return insetRectForBounds(rect: rect)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return insetRectForBounds(rect: rect)
    }

    fileprivate func insetForSideView(forBounds bounds: CGRect) -> CGRect {
        var rect = bounds
        rect.origin.y = 0
        rect.size.height = dtLayerHeight
        return rect
    }

    override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return insetForSideView(forBounds: rect)
    }

    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return insetForSideView(forBounds: rect)
    }

    override public func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.y = (dtLayerHeight - rect.size.height) / 2
        return rect
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        dtLayer.frame = CGRect(x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: dtLayerHeight)
        CATransaction.commit()

        if showErrorLabel {
            var lblErrorFrame = lblError.frame
            lblErrorFrame.origin.y = dtLayer.frame.origin.y + dtLayer.frame.size.height + paddingYErrorLabel
            lblError.frame = lblErrorFrame

            imageError.frame = CGRect(x: dtLayer.frame.origin.x + 2, y: dtLayer.frame.origin.y + dtLayer.frame.size.height + paddingYErrorLabel + 1, width: 15, height: 15)
            imageError.contentMode = .scaleAspectFit
            addSubview(imageError)
        }
        let floatingLabelSize = lblFloatPlaceholder.sizeThatFits(lblFloatPlaceholder.superview!.bounds.size)
        lblFloatPlaceholder.frame = CGRect(x: x, y: lblFloatPlaceholder.frame.origin.y,
            width: floatingLabelSize.width,
            height: floatingLabelSize.height)
        setErrorLabelAlignment()
        setFloatLabelAlignment()
        lblFloatPlaceholder.textColor = isFirstResponder ? floatPlaceholderActiveColor : placeHolderColor
        dtLayer.borderColor = isFirstResponder ? borderColorOn.cgColor:
            self.imageError.isHidden ? borderColorOff.cgColor : UIColor.secondaryActive.cgColor
        switch floatingDisplayStatus {
        case .never:
            hideFlotingLabel(isFirstResponder)
        case .always:
            showFloatingLabel(isFirstResponder)
        default:
            // Hide / show label
            if isFirstResponder {
                showFloatingLabel(isFirstResponder)
                getPlaceholderLabel()?.isHidden = true
                self.invalidateIntrinsicContentSize()
                setErrorLabelAlignment()
                setFloatLabelAlignment()
            } else if text == nil || text?.isEmptyStr == true {
                hideFlotingLabel(isFirstResponder)
                getPlaceholderLabel()?.isHidden = false
            } else if text != nil {
                showFloatingLabel(isFirstResponder)
                getPlaceholderLabel()?.isHidden = true
                self.invalidateIntrinsicContentSize()
                setErrorLabelAlignment()
                setFloatLabelAlignment()
            }
        }
    }

    private func getPlaceholderLabel() -> UILabel? {
        return subviews.first { $0 is UILabel && ($0 as! UILabel).text == placeholder } as? UILabel
    }
}

