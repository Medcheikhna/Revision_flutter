import 'package:flutter/material.dart';
import 'package:newtest/generated/l10n.dart';

class CustomFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final VoidCallback onSubmit;

  const CustomFormWidget({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.emailController,
    required this.nameController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
            validator: (value) => value!.isEmpty ? 'Phone is required' : null,
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) => value!.isEmpty ? 'Email is required' : null,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) => value!.isEmpty ? 'Name is required' : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text(S.of(context).update),
          ),
        ],
      ),
    );
  }
}
