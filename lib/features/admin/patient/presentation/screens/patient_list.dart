import 'package:behind_silent_eyes/core/widgets/search_field.dart';
import 'package:behind_silent_eyes/features/admin/patient/presentation/screens/patient_details.dart';
import 'package:flutter/material.dart';

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
  }
  List<Map<String, String>> patients = [
    {
      "name": "Ahmed Ali",
      "id": "1234 5678 9012 34",
      "dob": "12/2/2004",
      "gender": "Male"
    },
    {
      "name": "Sara Mohamed",
      "id": "9876 5432 1012 34",
      "dob": "5/6/2003",
      "gender": "Female"
    },
    {
      "name": "Omar Khaled",
      "id": "4567 8912 3012 34",
      "dob": "10/1/2002",
      "gender": "Male"
    },
  ];
  List<Map<String, String>> filteredPatients = [];
  void onSearch(String query) {
    setState(() {
      filteredPatients = patients.where((patient) {
        final name = patient["name"]!.toLowerCase();
        final id = patient["id"]!;
        final search = query.toLowerCase();

        return name.contains(search) || id.contains(search);
      }).toList();
    });
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchField(onSearch: onSearch, hint: "search patient by name or ID"),
            SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  return
                    Card(
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
                                      filteredPatients[index]["name"]!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "National ID ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  filteredPatients[index]["id"]!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date of birth: ", style: TextStyle(fontSize: 14)),
                                Text(
                                  filteredPatients[index]["dob"]!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Gender: ", style: TextStyle(fontSize: 14)),
                                Text(
                                  filteredPatients[index]["gender"]!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PatientDetails(
                                          patient: filteredPatients[index],
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff0B2F60),
                                    minimumSize: Size(130, 32),
                                  ),
                                  child: Text(
                                    "View",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
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
