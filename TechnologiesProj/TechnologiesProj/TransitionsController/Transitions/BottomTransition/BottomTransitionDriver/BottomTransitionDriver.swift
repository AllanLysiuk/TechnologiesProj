import UIKit

class BottomTransitionDriver: UIPercentDrivenInteractiveTransition {
    // Расчёты опираются на maxTranslation,
    // его мы рассчитываем как высоту показываемого контроллера
    var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }
    
    private var isRunning: Bool {
        return percentComplete != 0
    }
    
    var direction: BottomTransitionDirection = .present
    
    // Разведём поведение на основе состояния жеста.
    // Если жест начался, то это интерактивное закрытие, а если не начинался, то обычное:
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
        
        set { }
    }
    
    private weak var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?
    
    func link(to controller: UIViewController) {
        presentedController = controller
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer!)
    }
    
    private func handlePresentation(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
            
        case .changed:
            let increment = -r.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)
            
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                cancel()
            } else {
                finish()
            }
            
        case .failed:
            cancel()
            
        default:
            break
        }
    }
    
    
    // Если панель потащить вниз, то начнётся анимация закрытия,
    // и движение пальца будет влиять на степень закрытости.
    // UIPercentDrivenInteractiveTransition позволяет перехватить анимацию перехода
    // и управлять ей вручную. У него есть методы update, finish, cancel
    private func handleDismiss(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
            // Начать дисмисс самым обычным образом. Ссылку на контроллер мы сохранили в методе link(to:)
        case .began:
            // Допустим, мы начали закрывать нашу карточку, но передумали и хотим вернуть.
            pause() // Без паузы percentComplete всегда равен 0
            if !isRunning {
                presentedController?.dismiss(animated: true)
            }
            
            // Посчитать инкремент и передать его в метод update.
            // Принимаемое значение может изменяться от 0 до 1,
            // так мы будет управлять степенью завершённости анимации из метода
            // interactionControllerForDismissal(using:)
        case .changed:
            update(percentComplete + r.incrementToBottom(maxTranslation: maxTranslation))
            
            // Смотрим завершенность жеста.
            // Правило завершения: если сместилось больше половины, то закрываем.
            // При этом смещение надо считать не только по текущей координате, но и учесть velocity.
            // Так мы поймём намерение пользователя: он мог не довести до середины,
            // но свайпнуть сильно вниз. Или наоборот: увести вниз, но свайпнуть вверх для возврата.
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }
            
            // Случится, если жест отменится другим жестом.
            // Так, например, жест перетаскивания может отменять жест тапа.
        case .failed:
            cancel()
            
        default:
            break
        }
    }
    
    @objc private func handle(recognizer r: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: r)
        case .dismiss:
            handleDismiss(recognizer: r)
        }
    }
}

private extension UIPanGestureRecognizer {
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)
        
        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
}

private extension UIPanGestureRecognizer {
    func isProjectedToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTranslation / 2
        
        return isPresentationCompleted
    }
    
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view!) + velocityOffset
        return projectedLocation
    }
}
