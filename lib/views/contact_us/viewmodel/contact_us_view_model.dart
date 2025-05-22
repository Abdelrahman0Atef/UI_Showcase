part of '../contact_us_imports.dart';

class ContactUsViewModel {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final commentController = TextEditingController();
  final telephoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final commentFocusNode = FocusNode();
  final telephoneFocusNode = FocusNode();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    commentController.dispose();
    telephoneController.dispose();
  }

  final GraphQLService _graphQLService = getIt<GraphQLService>();


  Future<String> _submitContactForm(
      String name,
      String email,
      String comment,
      String? telephone,
      ) async {
    const mutation = r'''
    mutation SubmitContactForm($name: String!, $email: String!, $comment: String!, $telephone: String) {
      contactUs(input: {
        name: $name,
        email: $email,
        comment: $comment,
        telephone: $telephone
      }) {
        status
      }
    }
  ''';

    final variables = {
      'name': name,
      'email': email,
      'comment': comment,
      'telephone': telephone,
    };

    try {
      final data = await _graphQLService.performMutation(
        mutation: mutation,
        variables: variables,
      );

      final status = data?['contactUs']?['status'];
      return status == true ? 'Success' : 'Error';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  Future<void> _submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      final name = nameController.text;
      final email = emailController.text;
      final comment = commentController.text;
      final telephone = telephoneController.text.isNotEmpty ? telephoneController.text : null;

      try {
        EasyLoading.show(status: MyStrings.sending);

        await _submitContactForm(name, email, comment, telephone);

        EasyLoading.dismiss();
        BotToast.showText(text: MyStrings.successSent,align: Alignment.topCenter);
        nameController.clear();
        emailController.clear();
        commentController.clear();
        telephoneController.clear();
      } catch (e) {
        EasyLoading.dismiss();
        BotToast.showText(text: MyStrings.failedSent,align: Alignment.topCenter);
      }
    }
  }
}
