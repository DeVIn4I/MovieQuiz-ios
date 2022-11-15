import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol, AlertPresenterDelegate {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Private
    private var currentQuestion: QuizQuestion?
    private var alertPresenter: AlertPresenterProtocol?
    private var statisticService: StatisticService?
    private var presenter: MovieQuizPresenter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter = AlertPresenter(alertVC: self, delegate: self)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        statisticService = StatisticServiceImplementation()
        presenter = MovieQuizPresenter(viewController: self)
        
        showLoadingIndicator()
    }
    
    //MARK: - AlertPresenterDelegate
    func didShowAlert() {
        presenter.restartGame()
    }
    
    //MARK: - Actions
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
        buttonsToggle(state: false)
        
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
        buttonsToggle(state: false)
    }
    
    //MARK: - Methods
    func show(quizStep: QuizStepViewModel) {
        
        imageView.layer.borderWidth = 0
        buttonsToggle(state: true)
        imageView.image = quizStep.image
        textLabel.text = quizStep.question
        counterLabel.text = quizStep.questionNumber
    }
    
    private func buttonsToggle(state: Bool) {
        yesButton.isEnabled = state
        noButton.isEnabled = state
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }
    
    func show(quiz result: QuizResultsViewModel) {
        
        let model = AlertModel(title: result.title,message: result.text,buttonText: result.buttonText) {
            self.presenter.restartGame()
        }
        alertPresenter?.showAlert(model: model)
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let viewModel = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать ещё раз",
            completion: { [weak self] in
                guard let self = self else { return }
                self.presenter.restartGame()
            })
        alertPresenter?.showAlert(model: viewModel)
    }
}

