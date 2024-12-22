//
// CrossVerticalPresentation.swift
// Sahayak
//

import UIKit

private final class CrossVerticalModalController: UIPresentationController {
    private var dimmingView = UIView()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerBounds = containerView?.bounds ?? .zero
        let presentedViewSize = presentedViewController.view.frame.size
        
        let x = (containerBounds.width - presentedViewSize.width) / 2
        let y = (containerBounds.height - presentedViewSize.height) / 2
        
        return CGRect(x: x, y: y, width: presentedViewSize.width, height: presentedViewSize.height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerViewCopy = containerView else { return }
        dimmingView = UIView(frame: containerViewCopy.bounds)
        dimmingView.backgroundColor = UIColor.black
        dimmingView.alpha = 0.0
        
        containerView?.insertSubview(dimmingView, at: 0)
        
        // Animate the dimming view
        guard let coordinator = presentedViewController.transitionCoordinator
        else { return }
        
        coordinator.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0.5
        })
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // Animate the dimming view back to transparent when the dismissal begins
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        coordinator.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}

private final class CrossVerticalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to)
        else { return }
        
        if isPresenting {
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(
                x: 0,
                y: containerView.bounds.height,
                width: containerView.bounds.width,
                height: containerView.bounds.height
            )
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    toViewController.view.frame = containerView.bounds
                }
            ) { finished in
                transitionContext.completeTransition(finished)
            }
        } else {
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    fromViewController.view.frame = CGRect(
                        x: 0,
                        y: containerView.bounds.height,
                        width: containerView.bounds.width,
                        height: containerView.bounds.height
                    )
                }
            ) { finished in
                fromViewController.view.removeFromSuperview()
                transitionContext.completeTransition(finished)
            }
        }
    }
}

/// Using a generic transition that can be applied across multiple view controllers,
/// eliminating the need to individually conform each popup view controller to `UIViewControllerTransitioningDelegate`.
private final class CrossVerticalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        return CrossVerticalModalController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return CrossVerticalTransition(isPresenting: true)
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return CrossVerticalTransition(isPresenting: false)
    }
}

public extension UIViewController {
    func presentCrossVerticalModal(
        _ viewControllerToPresent: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        let transitioningDelegate = CrossVerticalTransitioningDelegate()
        viewControllerToPresent.modalPresentationStyle = .custom
        viewControllerToPresent.transitioningDelegate = transitioningDelegate
        
        present(viewControllerToPresent, animated: animated, completion: completion)
    }
}
