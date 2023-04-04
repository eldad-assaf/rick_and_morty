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
                height: 700.0,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Filter Options',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                              onPressed: () {
                                log('clear');
                                context
                                    .read<FilterBloc>()
                                    .add(ClearFilterEvent());
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                              label: const Text(
                                'clear',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ))
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
                            groupValue:
                                context.read<FilterBloc>().filterStatusBy,
                            onChanged: (value) {
                              context.read<FilterBloc>().add(
                                  FilterByStatusEvent(
                                      statusFilterType: StatusFilter.alive));
                            },
                          ),
                          const Text('Alive'),
                          Radio(
                            value: 'dead',
                            groupValue:
                                context.read<FilterBloc>().filterStatusBy,
                            onChanged: (value) {
                              context.read<FilterBloc>().add(
                                  FilterByStatusEvent(
                                      statusFilterType: StatusFilter.dead));
                            },
                          ),
                          const Text('Dead'),
                          Radio(
                            value: 'unknown',
                            groupValue:
                                context.read<FilterBloc>().filterStatusBy,
                            onChanged: (value) {
                              context.read<FilterBloc>().add(
                                  FilterByStatusEvent(
                                      statusFilterType: StatusFilter.unknown));
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
                            groupValue:
                                context.read<FilterBloc>().filterspeciesBy,
                            onChanged: (value) {
                              context.read<FilterBloc>().add(
                                  FilterBySpeciesEvent(
                                      speciesFilterType: SpeciesFilter.human));
                            },
                          ),
                          const Text('Human'),
                          Radio(
                            value: 'alien',
                            groupValue:
                                context.read<FilterBloc>().filterspeciesBy,
                            onChanged: (value) {
                              context.read<FilterBloc>().add(
                                  FilterBySpeciesEvent(
                                      speciesFilterType: SpeciesFilter.alien));
                            },
                          ),
                          const Text('Alien'),
                          Radio(
                            value: 'unknown',
                            groupValue:
                                context.read<FilterBloc>().filterspeciesBy,
                            onChanged: (value) {
                              context.read<FilterBloc>().add(
                                  FilterBySpeciesEvent(
                                      speciesFilterType:
                                          SpeciesFilter.unknown));
                            },
                          ),
                          const Text('Unknown'),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'female',
                            groupValue:
                                context.read<FilterBloc>().filterGenderBy,
                            onChanged: (value) {},
                          ),
                          const Text('Female'),
                          Radio(
                            value: 'male',
                            groupValue:
                                context.read<FilterBloc>().filterGenderBy,
                            onChanged: (value) {
                              // context.read<FilterBloc>().add(
                              //     FilterBySpeciesEvent(
                              //         speciesFilterType: SpeciesFilter.alien));
                            },
                          ),
                          const Text('Male'),
                          Radio(
                            value: 'genderless ',
                            groupValue:
                                context.read<FilterBloc>().filterGenderBy,
                            onChanged: (value) {
                              // context.read<FilterBloc>().add(
                              //     FilterBySpeciesEvent(
                              //         speciesFilterType:
                              //             SpeciesFilter.unknown));
                            },
                          ),
                          const Text('Genderless'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Radio(
                              value: 'unknown',
                              groupValue:
                                  context.read<FilterBloc>().filterGenderBy,
                              onChanged: (value) {
                                // context.read<FilterBloc>().add(
                                //     FilterBySpeciesEvent(
                                //         speciesFilterType:
                                //             SpeciesFilter.unknown));
                              },
                            ),
                            const Text('Unknown'),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey.shade900,
                        child: const Center(
                          child: Icon(
                            Icons.done,
                            size: 45,
                          ),
                        ),
                      )
                    ]));
          },
        );
      });
}
// female, male, genderless or unknown