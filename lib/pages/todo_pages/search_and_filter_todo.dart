import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/cubits.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/debounce.dart';

class SearchAndFilter extends StatelessWidget {
  SearchAndFilter({Key? key}) : super(key: key);
  final debounce = Debounce(miliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Search Todos...',
              filled: true,
              prefixIcon: Icon(Icons.search)),
          onChanged: (String? newSearchterm) {
            if (newSearchterm != null) {
              debounce.run(() {
                context.read<TodoSearchCubit>().setSearchTerm(newSearchterm);
              });
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.All),
            filterButton(context, Filter.Active),
            filterButton(context, Filter.Completed),
          ],
        )
      ],
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () {
        context.read<TodoFilterCubit>().changeFilter(filter);
      },
      child: Text(
        filter == Filter.All
            ? 'All'
            : filter == Filter.Active
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          fontSize: 18,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterCubit>().state.filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}
