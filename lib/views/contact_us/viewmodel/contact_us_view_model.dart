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
  final GraphQLService graphQLService = getIt<GraphQLService>();

  Future<String> submitContactForm(String name, String email, String comment, String? telephone) async {
    try {
      return await graphQLService.submitContactForm(name, email, comment, telephone);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      final name = nameController.text;
      final email = emailController.text;
      final comment = commentController.text;
      final telephone = telephoneController.text.isNotEmpty ? telephoneController.text : null;

      await graphQLService.submitContactForm(name, email, comment, telephone);

    }
  }

}
