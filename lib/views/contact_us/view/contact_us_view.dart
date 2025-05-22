part of '../contact_us_imports.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final ContactUsViewModel vm = ContactUsViewModel();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const CustomText(text: MyStrings.contactUs),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: vm.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextFieldWithTitle(
                label: MyStrings.userName,
                validator: (value) => ValidationHelper.validateFullName(value),
                controller: vm.nameController,
                focusNode: vm.nameFocusNode,
                onSubmitted: (_) {
                  vm.nameFocusNode.unfocus();
                  vm.emailFocusNode.requestFocus();
                },
              ),
              16.verticalSpace,
              CustomTextFieldWithTitle(
                label: MyStrings.email,
                validator: (value) => ValidationHelper.validateEmail(value),
                controller: vm.emailController,
                focusNode: vm.emailFocusNode,
                onSubmitted: (_) {
                  vm.emailFocusNode.unfocus();
                  vm.commentFocusNode.requestFocus();
                },
              ),
              16.verticalSpace,
              CustomTextFieldWithTitle(
                label: MyStrings.comment,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? MyStrings.requiredComment
                            : null,
                controller: vm.commentController,
                focusNode: vm.commentFocusNode,
                onSubmitted: (_) {
                  vm.commentFocusNode.unfocus();
                  vm.telephoneFocusNode.requestFocus();
                },
              ),
              16.verticalSpace,
              CustomTextFieldWithTitle(
                isPhoneField: true,
                label: MyStrings.phoneNumber,
                validator: (value) => ValidationHelper.validatePhone(value),
                controller: vm.telephoneController,
                focusNode: vm.telephoneFocusNode,
                keyboardType: TextInputType.phone,
                onSubmitted: (_) => vm.commentFocusNode.unfocus(),
              ),
              32.verticalSpace,
              Center(
                child: CustomButton(
                  onPressed: vm._submitForm,
                  text: MyStrings.submit,
                  textColor: MyColors.white,
                  color: MyColors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
