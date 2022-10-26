import 'dart:async';
import 'Employee.dart';

// below are the steps to implement the BLOC
// imports
// Lists of employees
// stream controller
// stream sink getter
// constructor - add data; listen to change
// core function
// dipose

class EmployeeBloc {
  // sink to add data in pipe
  // stream to get data from pipe
  // by pipe i mean data flow

  List<Employee> employeeList = [
    Employee(1, 'Nikhil', 500000),
    Employee(2, 'Rohini', 50000),
    Employee(3, 'Steve', 100000),
    Employee(4, 'Elon', 200000),
    Employee(5, 'Sundar', 300000),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStramController = StreamController<Employee>();

  // getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get emplopyeeSalaryDecrement =>
      _employeeSalaryDecrementStramController.sink;

  EmployeeBloc() {
    employeeListSink.add(employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_increamentSalary);
    _employeeSalaryDecrementStramController.stream.listen(_decrementSalary);
  }

  _increamentSalary(Employee employee) {
    print(employee);
    double salary = employee.salary;
    double incrementedSalary = salary * 20 / 100;
    employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(employeeList);
  }

  _decrementSalary(Employee employee) {
    print(employee);
    double salary = employee.salary;
    double decrementedSalary = salary * 20 / 100;
    employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(employeeList);
  }

  void dispose() {
    print(employeeList);
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStramController.close();
    _employeeListStreamController.close();
  }
}
