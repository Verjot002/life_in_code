import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _projectType = "App Development";
  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = "";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    final data = {
      "name": _nameController.text,
      "email": _emailController.text,
      "projectType": _projectType,
      "message": _messageController.text,
    };

    try {
      // Send message to FormSubmit API (which will forward to verjotheer@gmail.com)
      final url = Uri.parse("https://formsubmit.co/ajax/verjotheer@gmail.com");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
        });
      } else {
        throw Exception("Failed to send message. Please try again.");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll("Exception:", "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 24 : size.width * 0.08,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          _buildSectionHeader("05.", "Start a Project / Connect", isMobile),
          const SizedBox(height: 40),

          // Main form block
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 700),
              padding: EdgeInsets.all(isMobile ? 20 : 40),
              decoration: BoxDecoration(
                color: const Color(0xFF131824).withOpacity(0.5),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF202B3E), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: AnimatedCrossFade(
                firstChild: _buildSuccessWidget(),
                secondChild: _buildFormWidget(isMobile),
                crossFadeState: _isSuccess
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String index, String title, bool isMobile) {
    return Row(
      children: [
        Text(
          index,
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF64FFDA),
            fontFamily: "monospace",
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 20 : 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        if (!isMobile) ...[
          const SizedBox(width: 20),
          const Expanded(
            child: Divider(
              color: Color(0xFF202B3E),
              thickness: 1,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFormWidget(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Need a custom app or website built? Let's discuss details and create something awesome together.",
            style: TextStyle(fontSize: 15, color: Color(0xFF909BB4)),
          ),
          const SizedBox(height: 32),

          // Name Input
          _buildTextField(
            label: "Your Name",
            controller: _nameController,
            icon: Icons.person_outline_rounded,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please enter your name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Email Input
          _buildTextField(
            label: "Email Address",
            controller: _emailController,
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please enter your email";
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return "Please enter a valid email address";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Project Type Selector
          const Text(
            "What type of project is it?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildChoiceChip("App Development"),
              _buildChoiceChip("Web Development"),
              _buildChoiceChip("App & Web Design"),
              _buildChoiceChip("Consultation"),
            ],
          ),
          const SizedBox(height: 24),

          // Budget Selector removed

          // Message Input
          _buildTextField(
            label: "Tell me about your project",
            controller: _messageController,
            icon: Icons.chat_bubble_outline_rounded,
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please share some project details";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.redAccent, fontSize: 13),
              ),
            ),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF64FFDA),
                foregroundColor: const Color(0xFF07090E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Color(0xFF07090E),
                      ),
                    )
                  : const Text(
                      "Submit Project Request",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF505A70), fontSize: 14),
        floatingLabelStyle: const TextStyle(color: Color(0xFF64FFDA)),
        prefixIcon: Icon(icon, color: const Color(0xFF505A70), size: 20),
        filled: true,
        fillColor: const Color(0xFF07090E).withOpacity(0.4),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF202B3E)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF64FFDA), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    final isSelected = _projectType == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _projectType = label;
          });
        }
      },
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF07090E) : Colors.white,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
      ),
      selectedColor: const Color(0xFF64FFDA),
      backgroundColor: const Color(0xFF07090E).withOpacity(0.4),
      side: BorderSide(
        color: isSelected ? const Color(0xFF64FFDA) : const Color(0xFF202B3E),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // _buildBudgetChip helper removed

  Widget _buildSuccessWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF64FFDA).withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF64FFDA), width: 3),
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: Color(0xFF64FFDA),
              size: 72,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            "Project Request Sent!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Thank you for reaching out. I've received your request and will get in touch with you at the email provided within 24 hours.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF909BB4),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _isSuccess = false;
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();
              });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF64FFDA),
              side: const BorderSide(color: Color(0xFF64FFDA)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Send Another Message"),
          ),
        ],
      ),
    );
  }
}
