import UIKit

final class MovieQuizPresenter {
    let questionsAmount = 10
    private var currentQuestionIndex = 0
    var currentQuestion: QuizQuestion?
    weak var viewController: MovieQuizViewController?
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)"
        )
    }
    
    func noButtonClicked() {
        guard let currentQuestion = currentQuestion else { return }
        let answerToQuestion = false
        viewController?.showAnswerResult(isCorrect: answerToQuestion == currentQuestion.correctAnswer)
    }
    
    func yesButtonClicked() {
        guard let currentQuestion = currentQuestion else { return }
        let answerToQuestion = true
        viewController?.showAnswerResult(isCorrect: answerToQuestion == currentQuestion.correctAnswer)
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func resetQuestIndex() {
        currentQuestionIndex = 0
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func currentIndex() -> Int {
        currentQuestionIndex
    }
    
}
