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
     
     - Normal:      Title label is displayed, button background color is normalBackgroundColor
     - Highlighted: Title label is displayed, button background color changes to highlightedBackgroundColor
     - Loading:     Loading animation is displayed, background color changes to normalBackgroundColor
     */
    fileprivate enum ButtonState {
        case normal
        case highlighted
        case loading
        case enable
    }
    
    var buttonBackgroundColor:UIColor = UIColor.primaryInactive
    var imgView: UIImageView?
    
    
    //MARK: - Private
    fileprivate var currentlyVisibleView:UIView?
    fileprivate var secondaryVisibleView:UIView?
    fileprivate var buttonState:ButtonState = .normal { didSet {
        if oldValue != buttonState {
            print(buttonState)
            updateUI(forState:buttonState)
        }
        }
    }
    
    /// Font for the title label (IB does not allow UIFont to be inspected therefore font must be set programmatically)
    public var titleFont:UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            guard let titleLabel = currentlyVisibleView as? UILabel else { return }
            titleLabel.font = titleFont
        }
    }
    
    
    //MARK: - Inspectable / Designable properties
    
    /// Button title
    @IBInspectable var title:String = NSLocalizedString("Button", comment:"Button") {
        didSet {
            guard let titleLabel = currentlyVisibleView as? UILabel else { return }
            titleLabel.text = title
        }
    }
    
    @IBInspectable var rightText: String = "" {
        didSet {
            guard let rightLabel = secondaryVisibleView as? UILabel else { return }
            rightLabel.text = rightText
        }
    }
    
    /// Title color
    @IBInspectable var titleColor:UIColor = UIColor.white {
        didSet {
            guard let titleLabel = currentlyVisibleView as? UILabel else { return }
            titleLabel.textColor = titleColor
        }
    }
    
    @IBInspectable var textAlignment: String = "" {
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
                
            }            //updateStyle()
        }
    }
    
    @IBInspectable var nextState: String = ""
    //        {
    //        didSet{
    //            guard let titleLabel = currentlyVisibleView as? UILabel else { return }
    //            switch nextState {
    //            case "normal":
    //                titleLabel.textAlignment = .left
    //            case "highligted":
    //                titleLabel.textAlignment = .right
    //            case "loading":
    //                titleLabel.textAlignment = .center
    //            case "enable":
    //                titleLabel.textAlignment = .center
    //            default:
    //                titleLabel.textAlignment = .left
    //
    //            }            //updateStyle()
    //        }
    //    }
    
    /// Loading indicator color
    @IBInspectable var loadingIndicatorColor:UIColor = UIColor.white {
        
        didSet{
            updateUI(forState: buttonState)
        }
    }
    
    @IBInspectable var image:UIImage?{
        didSet{
            updateUI(forState: buttonState)
        }
    }
    
    /// Border width
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet { updateStyle() }
    }
    
    /// Border color
    @IBInspectable var borderColor:UIColor = UIColor.white {
        didSet { updateStyle() }
    }
    
    /// Corner radius
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet { updateStyle() }
    }
    
    /// Background color for normal state
    @IBInspectable var normalBackgroundColor:UIColor = UIColor.lightGray {
        didSet { updateStyle() }
    }
    
    /// Background color for highlighted state
    @IBInspectable var highlightedBackgroundColor:UIColor = UIColor.darkGray {
        didSet { updateStyle() }
    }
    
    /// Duration of one animation cycle
    @IBInspectable var loadingAnimationDuration:Double = 2.0
    
    /// Size of the animating shape
    @IBInspectable var loadingShapeSize:CGSize = CGSize(width: 10, height: 10)
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        updateStyle()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        updateStyle()
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
    }
    
    /**
     Button style update
     */
    private func updateStyle() -> Void {
        backgroundColor = normalBackgroundColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    /**
     Update button UI as a result of state change
     - parameter buttonState: new button state
     */
    private func updateUI(forState buttonState:ButtonState) -> Void {
        
        switch buttonState {
        case .normal:
            buttonBackgroundColor = normalBackgroundColor
            showLabelView()
            showImage()
        case .highlighted:
            buttonBackgroundColor = highlightedBackgroundColor
            showImage()
        case .loading:
            buttonBackgroundColor = normalBackgroundColor
            showLoadingView()
            showImage()
        case .enable:
            if (buttonBackgroundColor != normalBackgroundColor) {
                buttonBackgroundColor = UIColor.primaryInactive
                currentlyVisibleView?.isUserInteractionEnabled = false
            }
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
        titleLabel.font = titleFont
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
                super.touchesEnded(touches, with: event)
                return
        }
        sendActions(for: .touchUpInside)
        //buttonState = .loading
        //self.enable()
        switch nextState {
        case "normal":
            buttonState = .normal
        case "highlighted":
            buttonState = .highlighted
        case "loading":
            buttonState = .loading
        case "enable":
            buttonState = .enable
        default:
            buttonState = .normal
        }
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
        if (image != nil && (self.buttonState == .normal || buttonState == .enable)) {
            imgView = UIImageView(frame: CGRect(x: 24, y: (self.bounds.size.height/2)-12, width: 24, height: 24))
            imgView!.contentMode = .scaleAspectFit
            imgView!.image = self.image
            addSubview(self.imgView!)
            imgView!.alpha = (self.buttonState == .normal) ? 1 : 0.3
            print(self.imgView?.alpha)
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
        
        loadingView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        loadingView.startAnimation()
        
        UIView.transition(from: titleLabel, to: loadingView, duration:0.15, options:.transitionCrossDissolve) { (_) in
            titleLabel.removeFromSuperview()
        }
    }
}


extension BaseButton {
    
    public func animate() -> Void {
        buttonState = .loading
    }
    
    public func stop() -> Void {
        buttonState = .normal
    }
    
    public func enable() -> Void {
        buttonState = .enable
    }
}
