import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/blocs/filter_bloc/bloc/filter_bloc.dart';

void show(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            return Container(
                height: 400.0,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filter Options',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'asc',
                            groupValue:
                                context.read<FilterBloc>().nameFilterType,
                            onChanged: (value) {
                              log(value.toString());

                              context.read<FilterBloc>().add(
                                  FilterSelectionEvent(nameFilterType: 'asc'));
                            },
                          ),
                          const Text('Ascending'),
                          Radio(
                            value: 'desc',
                            groupValue:
                                context.read<FilterBloc>().nameFilterType,
                            onChanged: (value) {
                              context.read<FilterBloc>().add(
                                  FilterSelectionEvent(nameFilterType: 'desc'));
                            },
                          ),
                          const Text('Descending'),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'alive',
                            groupValue: '_statusFilter',
                            onChanged: (value) {
                              // setState(() {
                              //   _statusFilter = value;
                              // });
                            },
                          ),
                          const Text('Alive'),
                          Radio(
                            value: 'dead',
                            groupValue: '_statusFilter',
                            onChanged: (value) {
                              // setState(() {
                              //   _statusFilter = value;
                              // });
                            },
                          ),
                          const Text('Dead'),
                          Radio(
                            value: 'unknown',
                            groupValue: '_statusFilter',
                            onChanged: (value) {
                              // setState(() {
                              //   _statusFilter = value;
                              // });
                            },
                          ),
                          const Text('Unknown'),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Species',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'human',
                            groupValue: '_speciesFilter',
                            onChanged: (value) {
                              // setState(() {
                              //   _speciesFilter = value;
                              // });
                            },
                          ),
                          const Text('Human'),
                          Radio(
                            value: 'alien',
                            groupValue: '_speciesFilter',
                            onChanged: (value) {
                              // setState(() {
                              //   _speciesFilter = value;
                              // });
                            },
                          ),
                          const Text('Alien'),
                          Radio(
                            value: 'unknown',
                            groupValue: '_speciesFilter',
                            onChanged: (value) {
                              // setState(() {
                              //   _speciesFilter = value;
                              // });
                            },
                          ),
                          const Text('Unknown'),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: Colors.amber,
                        child: Center(
                          child: Icon(
                            Icons.done,
                            size: 32,
                          ),
                        ),
                      )
                    ]));
          },
        );
      });
}
