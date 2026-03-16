import 'package:behind_silent_eyes/core/widgets/search_field.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/screens/add_doc.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/screens/doc_details.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/screens/edit_doc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocList extends StatefulWidget {
  const DocList({super.key});

  @override
  State<DocList> createState() => _DocListState();
}

class _DocListState extends State<DocList> {
  @override
  void initState() {
    filteredDoctors = doctors;
    super.initState();
  }

  List<Map<String, String>> doctors = [
    {
      "name": "Ahmed Ali",
      "code": "doc_101",
      "email": "ahmed@gmail.com",
      "role": "doctor",
      "registered_on": "12/3/2026",
      "phone": "01222339770",
    },
    {
      "name": "Mohamed Hassan",
      "code": "doc_102",
      "email": "mohamed@gmail.com",
      "role": "doctor",
      "registered_on": "12/3/2026",
      "phone": "01222339770",
    },
    {
      "name": "Sara Khaled",
      "code": "doc_103",
      "email": "sara@gmail.com",
      "role": "doctor",
      "registered_on": "12/3/2026",
      "phone": "01222339770",
    },
  ];

  void searchDoctor(String query) {
    setState(() {
      filteredDoctors = doctors.where((doctor) {
        final name = doctor["name"]!.toLowerCase();
        final code = doctor["code"]!.toLowerCase();
        final search = query.toLowerCase();

        return name.contains(search) || code.contains(search);
      }).toList();
    });
  }

  List<Map<String, String>> filteredDoctors = [];
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchField(
                    onSearch: searchDoctor,
                    hint: "Search doctor by name or code",
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff474161),
                    minimumSize: Size(129, 32),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddDoc()),
                    );
                  },
                  child: Text(
                    "Add Doctor",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Color(0xffffffff),
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: SizedBox(
                      width: 335,
                      height: 220,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row 1: Icon + Name + Edit
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Color(0xff68848C),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      filteredDoctors[index]["name"]!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueGrey,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditDoc(
                                          code: "doc_123",
                                          email: "a@gmail.com",
                                          phone: "01015369825",
                                          fullName: "ahmed ali",
                                          role: "Doctor",
                                          pass: "ali123",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            // Row 2: Doctor code
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Doctor code: ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  filteredDoctors[index]["code"]!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            // Row 3: Role
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Role: ", style: TextStyle(fontSize: 14)),
                                Text(
                                  "doctor ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            // Row 4: Email
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Email ", style: TextStyle(fontSize: 14)),
                                Text(
                                  filteredDoctors[index]["email"]!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            Spacer(),
                            Divider(),
                            // Last Row: View Button + Delete Icon
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DocDetails(
                                            doctor: filteredDoctors[index],
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff0B2F60),
                                      minimumSize: Size(80, 32),
                                    ),
                                    child: Text(
                                      "View",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
