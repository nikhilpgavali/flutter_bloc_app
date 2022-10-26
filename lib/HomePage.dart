import 'package:flutter/material.dart';
import 'Employee.dart';
import 'EmployeeBloc.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee App'),
        leading: IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pushNamed(context, '/second'),
        ),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder:
              ((BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "${snapshot.data![index].id}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].name,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              "₹ ${snapshot.data![index].salary}",
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_up),
                          color: Colors.green,
                          onPressed: () {
                            _employeeBloc.employeeSalaryIncrement
                                .add(snapshot.data![index]);
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_down),
                          color: Colors.red,
                          onPressed: () {
                            _employeeBloc.emplopyeeSalaryDecrement
                                .add(snapshot.data![index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
