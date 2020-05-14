//
//  SimpleLoadingButton.swift
//  SimpleLoadingButton
//
//  Created by Ruva on 7/1/16.
//  Copyright (c) 2016 Ruva. All rights reserved.
//
import UIKit
@IBDesignable
public class BaseButton: UIControl {
    
    /**
     Button internal states
     
     - Normal:       Title label is displayed, button background color is normalBackgroundColor
     - Highlighted: Title label is displayed, button background color changes to highlightedBackgroundColor
     - Loading:      Loading animation is displayed, background color changes to normalBackgroundColor
     - Disable:       Loading animation is displayed, background color changes to normalBackgroundColor
     */
    fileprivate enum ButtonState {
        case normal
        case highlighted
        case loading
        case disable
    }
    
    var buttonBackgroundColor:UIColor = UIColor.gray
    var imgView: UIImageView?
    
    var blurEffectView = UIVisualEffectView()
    //MARK: - Private
    fileprivate var currentlyVisibleView:UIView?
    fileprivate var secondaryVisibleView:UIView?
    private var buttonState:ButtonState = .normal { didSet {
        if oldValue != buttonState {
            print(buttonState)
            updateUI(forState:buttonState)
            updateStyle()
        }
        }
    }
    
    /// Font for the title label (IB does not allow UIFont to be inspected therefore font must be set programmatically)
    public var titleFont:UIFont = .button {
        didSet {
            guard let titleLabel = currentlyVisibleView as? UILabel else { return }
            titleLabel.font = .button
            updateStyle()
        }
    }
    
    
    //MARK: - Inspectable / Designable properties
    
    @IBInspectable public var kernSpace : Int = 2
    @IBInspectable public var kernRightSpace : Int = 0

    
    /// Button title
    @IBInspectable public var title:String = NSLocalizedString("Button", comment:"Button") {
        didSet {
            guard let titleLabel = currentlyVisibleView as? UILabel else { return }
            updateStyle()
            titleLabel.font = .button
            titleLabel.attributedText = NSAttributedString(string: title, attributes: [.kern: kernSpace])
        }
    }
    
    @IBInspectable public var rightText: String = "" {
        didSet {
            guard let rightLabel = secondaryVisibleView as? UILabel else { return }
            rightLabel.font = .button
            rightLabel.textColor = rightTextColor
            rightLabel.attributedText = NSAttributedString(string: rightText, attributes: [.kern: kernRightSpace])
            updateUI(forState: buttonState)
        }
    }
    
    /// Title color
    @IBInspectable public var titleColor:UIColor = UIColor.white {
        didSet {
            guard let titleLabel = currentlyVisibleView as? UILabel else { return }
            titleLabel.textColor = titleColor
        }
    }
    
    @IBInspectable public var rightTextColor:UIColor = UIColor.white {
        didSet {
            guard let rightTextLabel = secondaryVisibleView as? UILabel else { return }
            rightTextLabel.textColor = rightTextColor
        }
    }
    
    @IBInspectable public var textAlignment: String = "left" {
        didSet{
            guard let titleLabel = currentlyVisibleView as? UILabel else { return }
            switch textAlignment {
            case "left":
                titleLabel.textAlignment = .left
            case "right":
                titleLabel.textAlignment = .right
            case "center":
                titleLabel.textAlignment = .center
            default:
                titleLabel.textAlignment = .left
            }
        }
    }
    @IBInspectable public var currentState: String = "normal"{
        didSet{
            switch currentState {
            case "normal":
                self.normal()
            case "loading":
                self.loading()
            case "highlighted":
                self.highlighted()
            case "disable":
                self.disable()
            default:
                self.normal()
            }
        }
    }
    
    @IBInspectable public var nextState: String = "normal"
    
    /// Loading indicator color
    @IBInspectable public var loadingIndicatorColor:UIColor = UIColor.white {
        didSet{
            updateUI(forState: buttonState)
        }
    }
    
    @IBInspectable public var image:UIImage?{
        didSet{
            updateUI(forState: buttonState)
        }
    }
    
     public var isImageOnRight : Bool? {
        didSet{
            updateUI(forState: buttonState)
        }
    }
    
    
    /// Border width
    @IBInspectable public var borderWidth:CGFloat = 0 {
        didSet { updateStyle() }
    }
    
    /// Border color
    @IBInspectable public var borderColor:UIColor = UIColor.white {
        didSet { updateStyle() }
    }
    
    /// Corner radius
    @IBInspectable public var cornerRadius:CGFloat = 0 {
        didSet { updateStyle() }
    }
    
    /// Background color for normal state
    @IBInspectable public var normalBackgroundColor:UIColor = UIColor.primaryActive {
        didSet {
            updateStyle() }
    }
    
    /// Background color for highlighted state
    @IBInspectable public var highlightedBackgroundColor:UIColor = UIColor.primaryActiveAlt {
        didSet { updateStyle() }
    }
    
    /// Duration of one animation cycle
    @IBInspectable public var loadingAnimationDuration:Double = 2.0
    
    /// Size of the animating shape
    @IBInspectable public var loadingShapeSize:CGSize = CGSize(width: 10, height: 10)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        updateStyle()
        showImage()
        updateUI(forState: buttonState)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        updateStyle()
        showImage()
        updateUI(forState: buttonState)

    }
    
    /**
     Setup button to initial state
     */
    private func setupButton() -> Void {
        
        let titleLabel = createTitleLabel(withFrame:CGRect(x: 0, y: 0, width: frame.width - 48, height: frame.height))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant:  24).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24 ).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        currentlyVisibleView = titleLabel
        
        let rightLabel = createTitleLabel(withFrame:CGRect(x: 0, y: 0, width: frame.width - 48, height: frame.height))
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightLabel)
        //rightLabel.leftAnchor.constraint(equalTo: leftAnchor, constant:  24).isActive = true
        rightLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rightLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24 ).isActive = true
        rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        secondaryVisibleView = rightLabel
        rightLabel.textAlignment = .right
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        self.sendSubviewToBack(blurEffectView)
        blurEffectView.alpha = 0
        blurEffectView.isHidden = true
        showImage()
        updateUI(forState: buttonState)
        backgroundColor = normalBackgroundColor
    }
    
    /**
     Button style update
     */
    private func updateStyle() -> Void {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        guard let titleLabel = currentlyVisibleView as? UILabel else { return }
        titleLabel.font = titleFont
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [.kern: kernSpace])
        showImage()
    }
    
    /**
     Update button UI as a result of state change
     - parameter buttonState: new button state
     */
    private func updateUI(forState buttonState:ButtonState) -> Void {
        
        switch buttonState {
        case .normal:
            secondaryVisibleView?.isHidden = false
            buttonBackgroundColor = normalBackgroundColor
            showLabelView()
            showImage()
            self.isUserInteractionEnabled = true

        case .highlighted:
            secondaryVisibleView?.isHidden = false
            buttonBackgroundColor = highlightedBackgroundColor
            showImage()
            self.isUserInteractionEnabled = true

        case .loading:
            buttonBackgroundColor = normalBackgroundColor
            showLoadingView()
            showImage()
        case .disable:
            //if (buttonBackgroundColor != normalBackgroundColor) {
            buttonBackgroundColor = UIColor.primaryInactive
            currentlyVisibleView?.isUserInteractionEnabled = false
            self.isUserInteractionEnabled = false
            // }
            showImage()
        }
        
        UIView.animate(withDuration: 0.15, animations: { [unowned self] in self.backgroundColor = self.buttonBackgroundColor })
    }
    
    fileprivate func createTitleLabel(withFrame frame:CGRect) -> UILabel {
        let titleLabel = UILabel(frame:frame)
        titleLabel.text = title
        switch textAlignment {
        case "left":
            titleLabel.textAlignment = .left
        case "right":
            titleLabel.textAlignment = .right
        case "center":
            titleLabel.textAlignment = .center
        default:
            titleLabel.textAlignment = .left
        }
        titleLabel.textColor = titleColor
        //titleLabel.font = titleFont
        return titleLabel
    }
}



extension BaseButton {
    
    //MARK: - Touch handling
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard buttonState == .normal,
            let touchLocation = touches.first?.location(in: self),
            bounds.contains(touchLocation) else {
                super.touchesBegan(touches, with: event)
                return
        }
        buttonState = .highlighted
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard buttonState != .loading,
            let touchLocation = touches.first?.location(in: self) else {
                super.touchesMoved(touches, with: event)
                return
        }
        
        buttonState = bounds.contains(touchLocation) ? .highlighted : .normal
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard buttonState == .highlighted,
            let touchLocation = touches.first?.location(in: self),
            bounds.contains(touchLocation) else {
                buttonState = .normal
                super.touchesEnded(touches, with: event)
                return
        }
        //buttonState = .loading
        //self.enable()
        buttonState = .normal
        sendActions(for: .touchUpInside)
    }
    // touchesCancelled
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.normal()
    }

    
    public func blurEffect(){
        blurEffectView.isHidden = false
    }
}

extension BaseButton {
    
    //MARK: - View transitions
    
    /**
     Transition to title label
     */
    fileprivate func showLabelView() -> Void {
        
        guard let loadingView = currentlyVisibleView as? SimpleLoadingView else { return }
        let titleLabel = createTitleLabel(withFrame:loadingView.frame)
        // titleLabel.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 8, right: 20)
        addSubview(titleLabel)
        currentlyVisibleView = titleLabel
        secondaryVisibleView?.isHidden = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        switch textAlignment {
        case "left":
            titleLabel.textAlignment = .left
        case "right":
            titleLabel.textAlignment = .right
        case "center":
            titleLabel.textAlignment = .center
        default:
            titleLabel.textAlignment = .left
        }
        
        UIView.transition(from: loadingView, to:titleLabel, duration:0.15, options:.transitionCrossDissolve) { (_) in
            loadingView.removeFromSuperview()
        }
    }
    
    private func showImage() -> Void {
        if (image != nil && (self.buttonState == .normal || buttonState == .highlighted || buttonState == .disable)) {
            imgView?.removeFromSuperview()
            //When is left aligned and there is right label we move the image to the right
            if let rightLabel = secondaryVisibleView as? UILabel, textAlignment == "left" || self.isImageOnRight == true {
                imgView = UIImageView(frame: CGRect(x: self.bounds.size.width-48-4-self.rightText.widthOfString(usingFont: .button), y: (self.bounds.size.height/2)-6, width: 12, height: 12))
                imgView?.isHidden = false
                // test.rightAnchor.constraint(equalTo: rightLabel.leftAnchor).isActive = true
            } else {
                imgView = UIImageView(frame: CGRect(x: 12, y: (self.bounds.size.height/2)-12, width: 24, height: 24))
                imgView?.isHidden = false
            }
            imgView!.contentMode = .scaleAspectFit
            imgView!.image = self.image
            addSubview(self.imgView!)
            imgView!.alpha = (self.buttonState == .normal) ? 1 : 0.3
        } else {
            imgView?.removeFromSuperview()
        }
    }
    
    /**
     Transition to loading animation
     */
    fileprivate func showLoadingView() -> Void {
        
        guard let titleLabel = currentlyVisibleView as? UILabel else { return }
        let loadingView = SimpleLoadingView(withFrame:titleLabel.frame, animationDuration: loadingAnimationDuration, animatingShapeSize:loadingShapeSize, loadingIndicatorColor:loadingIndicatorColor)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingView)
        currentlyVisibleView = loadingView
        secondaryVisibleView?.isHidden = true
        
        loadingView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        loadingView.startAnimation()
        
        UIView.transition(from: titleLabel, to: loadingView, duration: 0.15, options:.transitionCrossDissolve) { (_) in
            titleLabel.removeFromSuperview()
        }
    }
}


extension BaseButton {
    
    public func loading() -> Void {
        buttonState = .loading
    }
    
    public func normal() -> Void {
        buttonState = .normal
    }
    
    public func disable() -> Void {
        buttonState = .disable
    }
    
    public func highlighted() -> Void {
        buttonState = .highlighted
    }
}
