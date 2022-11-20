import 'package:flutter/material.dart';
import '../../core/models/group/table_row_data.dart';

class DataTableComunUsers extends StatefulWidget {
  final List<DataRowAdminGroup> users;
  const DataTableComunUsers({super.key, required this.users});

  @override
  State<DataTableComunUsers> createState() => _DataTableComunUsersState();
}

class _DataTableComunUsersState extends State<DataTableComunUsers> {  
  @override
  Widget build(BuildContext context) {
    List<bool> selected = List<bool>.generate(widget.users.length, (int index) => false);
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Users'),
          ),
        ],
        rows: List<DataRow>.generate(
          numItems,
          (int index) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              // All rows will have the same selected color.
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }
              // Even rows will have a grey color.
              if (index.isEven) {
                return Colors.grey.withOpacity(0.3);
              }
              return null; // Use default value for other states and odd rows.
            }),
            cells: <DataCell>[DataCell(Text('Row $index'))],
            selected: selected[index],
            onSelectChanged: (bool? value) {
              setState(() {
                selected[index] = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
