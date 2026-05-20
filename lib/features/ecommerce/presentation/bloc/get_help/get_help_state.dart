import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_message_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_question_ui_model.dart';

class GetHelpState {
  final String? sessionId;
  final int currentStage;
  final String? petContext;

  final List<GetHelpQuestionUIModel> questions;
  final int currentQuestionIndex;

  final List<GetHelpMessageModel> messages;

  final Map<String, String> answers;

  final List<ProductModel> recommendations;
  final bool isLoadingRecommendations;
  final bool hasRequestedRecommendations;

  final bool isLoading;
  final bool isSubmitting;
  final String? error;
  final bool isTyping;

  const GetHelpState({
    this.sessionId,
    this.currentStage = 1,
    this.petContext,
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.messages = const [],
    this.answers = const {},
    this.isLoading = false,
    this.isSubmitting = false,
    this.error,
    this.recommendations = const [],
    this.isLoadingRecommendations = false,
    this.hasRequestedRecommendations = false,
    this.isTyping = false,
  });

  GetHelpState copyWith({
    String? sessionId,
    int? currentStage,
    String? petContext,
    List<GetHelpQuestionUIModel>? questions,
    int? currentQuestionIndex,
    List<GetHelpMessageModel>? messages,
    Map<String, String>? answers,
    List<ProductModel>? recommendations,
    bool? isLoadingRecommendations,
    bool? hasRequestedRecommendations,
    bool? isLoading,
    bool? isSubmitting,
    String? error,
    bool? isTyping,
  }) {
    return GetHelpState(
      sessionId: sessionId ?? this.sessionId,
      currentStage: currentStage ?? this.currentStage,
      petContext: petContext ?? this.petContext,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      messages: messages ?? this.messages,
      answers: answers ?? this.answers,
      recommendations: recommendations ?? this.recommendations,
      isLoadingRecommendations:
          isLoadingRecommendations ?? this.isLoadingRecommendations,
      hasRequestedRecommendations:
          hasRequestedRecommendations ?? this.hasRequestedRecommendations,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}
