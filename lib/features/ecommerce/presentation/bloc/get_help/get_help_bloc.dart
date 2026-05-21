import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_message_model.dart';
import 'package:poochcare/features/ecommerce/domain/repository/get_help_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_state.dart';

class GetHelpBloc extends Bloc<GetHelpEvent, GetHelpState> {
  final GetHelpRepository _repo;

  GetHelpBloc(this._repo) : super(const GetHelpState()) {
    on<StartGetHelp>(_onStart);
    on<SelectOption>(_onSelectOption);
    on<SubmitStage>(_onSubmitStage);
    on<LoadStage>(_onLoadStage);
    on<FetchRecommendations>(_onFetchRecommendations);
    on<OpenRecommendations>(_onOpenRecommendations);
  }

  Future<void> _onStart(StartGetHelp event, Emitter<GetHelpState> emit) async {
    emit(const GetHelpState().copyWith(isLoading: true));

    try {
      final sessionId = await _repo.startSession();

      emit(state.copyWith(sessionId: sessionId));

      add(LoadStage(1, null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onLoadStage(LoadStage event, Emitter<GetHelpState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final questions = await _repo.getStageQuestions(
        stage: event.stage,
        petContext: event.petContext,
      );

      if (questions.isEmpty) {
        emit(state.copyWith(isLoading: false, error: 'No questions found'));
        return;
      }

      // final firstMessage = GetHelpMessageModel(
      //   id: questions.first.id,
      //   text: questions.first.question,
      //   isUser: false,
      //   options: questions.first.options,
      // );

      // Add Stage separator immediately
      final updatedMessages = List<GetHelpMessageModel>.from(state.messages)
        ..add(
          GetHelpMessageModel(
            id: 'stage_${event.stage}',
            text: '',
            isUser: false,
            isStageSeparator: true,
            stageTitle: 'Stage ${event.stage}',
          ),
        );

      // Emit intermediate state with only the stage separator
      emit(state.copyWith(isLoading: false, messages: updatedMessages));

      // Add typing indicator for first question
      final typingMessage = GetHelpMessageModel(
        id: 'typing_${questions.first.id}',
        text: '',
        isUser: false,
        isTyping: true,
      );

      final messagesWithTyping = List<GetHelpMessageModel>.from(updatedMessages)
        ..add(typingMessage);
      emit(state.copyWith(messages: messagesWithTyping));

      // Wait a bit before showing the first question
      await Future<void>.delayed(const Duration(milliseconds: 700));

      // Replace typing with actual message
      final firstMessage = GetHelpMessageModel(
        id: questions.first.id,
        text: questions.first.question,
        isUser: false,
        options: questions.first.options,
        createdAt: DateTime.now(),
      );

      final finalMessages = List<GetHelpMessageModel>.from(messagesWithTyping)
        ..removeWhere((m) => m.isTyping) // REMOVE TYPING
        ..add(firstMessage);

      emit(
        state.copyWith(
          isLoading: false,
          questions: questions,
          currentQuestionIndex: 0,
          messages: finalMessages,
          // answers: {},
          answers: <String, String>{},
          currentStage: event.stage,
          hasRequestedRecommendations: false,
          recommendations: [],
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onSelectOption(SelectOption event, Emitter<GetHelpState> emit) async {
    final newAnswers = Map<String, String>.from(state.answers);

    newAnswers[event.question.id] = event.option.key;

    final newMessages = List<GetHelpMessageModel>.from(state.messages)
      ..add(
        GetHelpMessageModel(
          id: event.option.id,
          text: event.option.text,
          isUser: true,
          createdAt: DateTime.now(),
        ),
      );

    emit(state.copyWith(messages: newMessages, answers: newAnswers));

    final nextIndex = state.currentQuestionIndex + 1;

    // 🔥 LAST QUESTION
    if (nextIndex >= state.questions.length) {
      emit(
        state.copyWith(
          messages: newMessages,
          answers: newAnswers,
          currentQuestionIndex: state.questions.length - 1,
        ),
      );

      add(SubmitStage());
      return;
    }

    final nextQuestion = state.questions[nextIndex];

    // 🔹 Add typing indicator
    final typingMessage = GetHelpMessageModel(
      id: 'typing_${nextQuestion.id}',
      text: '',
      isUser: false,
      isTyping: true,
    );

    final messagesWithTyping = List<GetHelpMessageModel>.from(newMessages)
      ..add(typingMessage);
    emit(state.copyWith(messages: messagesWithTyping));

    // Optional: add a tiny delay for typing effect
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final nextMessage = GetHelpMessageModel(
      id: nextQuestion.id,
      text: nextQuestion.question,
      isUser: false,
      options: nextQuestion.options,
      createdAt: DateTime.now(),
    );

    // 🔹 Append next question after delay
    final finalMessages = List<GetHelpMessageModel>.from(messagesWithTyping)
      ..removeWhere((m) => m.isTyping) //  REMOVE TYPING
      ..add(nextMessage);

    // newMessages.add(
    //   GetHelpMessageModel(
    //     id: nextQuestion.id,
    //     text: nextQuestion.question,
    //     isUser: false,
    //     options: nextQuestion.options,
    //   ),
    // );

    emit(
      state.copyWith(
        messages: finalMessages,
        answers: newAnswers,
        currentQuestionIndex: nextIndex,
      ),
    );
  }

  Future<void> _onSubmitStage(
    SubmitStage event,
    Emitter<GetHelpState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      final response = await _repo.submitStage(
        sessionId: state.sessionId!,
        stage: state.currentStage,
        answers: state.answers,
      );

      emit(state.copyWith(isSubmitting: false));

      if (response.status == 'continue') {
        add(LoadStage(response.nextStage!, response.petContext));
      } else {
        // final newMessages = List<GetHelpMessageModel>.from(state.messages)
        //   ..add(
        //     GetHelpMessageModel(
        //       id: 'result_msg',
        //       text:
        //           'Good news! Based on our conversation, we have curated the pets we think would be best suited to you and your home.',
        //       isUser: false,
        //     ),
        //   )
        //   ..add(
        //     GetHelpMessageModel(
        //       id: 'cta',
        //       text: '',
        //       isUser: false,
        //       isCTA: true, // 👈 NEW FLAG
        //     ),
        //   );

        // emit(state.copyWith(messages: newMessages, isSubmitting: false));

        add(FetchRecommendations());
      }
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }

  // Future<void> _onFetchRecommendations(
  //   FetchRecommendations event,
  //   Emitter<GetHelpState> emit,
  // ) async {
  //   emit(
  //     state.copyWith(
  //       isLoadingRecommendations: true,
  //       hasRequestedRecommendations: true,
  //     ),
  //   );

  //   try {
  //     final response = await _repo.getRecommendations(
  //       sessionId: state.sessionId!,
  //     );

  //     final products = response.products;

  //     final newMessages = List<GetHelpMessageModel>.from(state.messages);

  //     if (products.isNotEmpty) {
  //       newMessages.add(
  //         GetHelpMessageModel(
  //           id: 'hooray',
  //           text: '',
  //           isUser: false,
  //           isHooray: true,
  //         ),
  //       );
  //     } else {
  //       newMessages.add(
  //         GetHelpMessageModel(
  //           id: 'empty',
  //           text: 'Oops! We couldn’t find any pets based on your preferences.',
  //           isUser: false,
  //           isEmpty: true,
  //         ),
  //       );
  //     }

  //     emit(
  //       state.copyWith(
  //         isLoadingRecommendations: false,
  //         recommendations: products,
  //         messages: newMessages,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(
  //       state.copyWith(isLoadingRecommendations: false, error: e.toString()),
  //     );
  //   }
  // }

  Future<void> _onFetchRecommendations(
    FetchRecommendations event,
    Emitter<GetHelpState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingRecommendations: true,
        hasRequestedRecommendations: true,
      ),
    );

    try {
      final response = await _repo.getRecommendations(
        sessionId: state.sessionId!,
      );

      final products = response.products;

      final newMessages = List<GetHelpMessageModel>.from(state.messages);

      // ✅ NO PRODUCTS
      if (products.isEmpty) {
        newMessages.add(
          GetHelpMessageModel(
            id: 'empty',
            text: 'Oops! We couldn’t find any pets based on your preferences.',
            isUser: false,
            isEmpty: true,
          ),
        );

        emit(
          state.copyWith(
            isLoadingRecommendations: false,
            recommendations: [],
            messages: newMessages,
          ),
        );

        return;
      }

      // ✅ PRODUCTS FOUND
      newMessages
        ..add(
          GetHelpMessageModel(
            id: 'result_msg',
            text:
                'Good news! Based on our conversation, we have curated the pets we think would be best suited to you and your home.',
            isUser: false,
          ),
        )
        ..add(
          GetHelpMessageModel(id: 'cta', text: '', isUser: false, isCTA: true),
        );

      emit(
        state.copyWith(
          isLoadingRecommendations: false,
          recommendations: products,
          messages: newMessages,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoadingRecommendations: false, error: e.toString()),
      );
    }
  }

  void _onOpenRecommendations(
    OpenRecommendations event,
    Emitter<GetHelpState> emit,
  ) {
    if (state.hasOpenedRecommendations) return;
    final updatedMessages = List<GetHelpMessageModel>.from(state.messages)
      ..removeWhere((m) => m.isCTA)
      ..add(
        GetHelpMessageModel(
          id: 'hooray',
          text: '',
          isUser: false,
          isHooray: true,
        ),
      );

    emit(
      state.copyWith(messages: updatedMessages, hasOpenedRecommendations: true),
    );
  }
}
