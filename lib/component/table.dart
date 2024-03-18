import 'package:flutter/material.dart';

class MyData extends DataTableSource {
  //Creating our data source: (for now its just static we generate some data , then if every thing works well we well return to firebase)

  // final List<Map<String, dynamic>> _data = List.generate(
  //     200,
  //         (index) => {
  //       "id": index,
  //       "title": "Item $index",
  //       "price": Random().nextInt(10000),
  //     });
  final List<DataRow> _rows;

  MyData(this._rows);

  @override
  DataRow? getRow(int index) {
    // return DataRow(cells: [
    //   DataCell(Text(_data[index]['id'].toString())),
    //   DataCell(Text(_data[index]['title'])),
    //   DataCell(Text(_data[index]['price'].toString())),
    // ]);
    return _rows[index];
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _rows.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}