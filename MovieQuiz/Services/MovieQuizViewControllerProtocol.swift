import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quizStep: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showNetworkError(message: String)
    
}
