import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/reset_pass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendCode extends StatefulWidget {
  const SendCode({super.key});

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {

  List<TextEditingController> controllers =
  List.generate(5, (index) => TextEditingController());

  List<FocusNode> focusNodes =
  List.generate(5, (index) => FocusNode());

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  String getCode() {
    return controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.primary,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios),
              ),
              SizedBox(height: 20),
              Text(
                "Check your email",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff665F5F),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We've sent a 5-digit code to your email",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xff989898),
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return SizedBox(
                      width: 55,
                      height: 60,
                      child: TextFormField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "";
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "";
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < 4) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            }
                          } else {
                            if (index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index - 1]);
                            }
                          }
                        },
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: Colors.white,
                      
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton (
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF474161),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      String code = getCode();
                      // هنا بقى التحقق الحقيقي من الكود (API مثلاً)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPass(),
                        ),
                      );}else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter valid code"),backgroundColor:Color(0xFF474161),),
                      );
                    }
},
                 child: Text(
                    "Verify Code",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Haven't got the email yet? ",
                      style: GoogleFonts.poppins(
                        color: Color(0xff989898),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Resend email",
                        style: GoogleFonts.poppins(
                          color: Color(0xff0400FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}