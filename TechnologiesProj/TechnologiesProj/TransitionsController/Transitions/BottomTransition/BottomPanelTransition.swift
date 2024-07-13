import UIKit

class BottomPanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    private let driver = BottomTransitionDriver()
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        
        // Присоединяем обработчик скрытия экрана
        driver.link(to: presented)
        
        let presentationController = DimmPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source
        )
        presentationController.driver = driver
        return presentationController
    }
    
    // Анимация показа контроллера
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return BottomPresentAnimation()
    }
    
    // Анимация скрытия контроллера
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomDismissAnimation()
    }
    
    // Указываем, что скрытие стало управляемым
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    // Контроллер начал показываться, но нам это не нужно.
    // Мы ловим его и отправляем свайпом вниз обратно.
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
}


