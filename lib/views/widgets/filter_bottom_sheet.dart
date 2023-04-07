import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/blocs/filter_bloc/bloc/filter_bloc.dart';

void show(BuildContext context) {
  Map<String, dynamic> _params = {};
  String? _filterStatusBy;
  String? _filterspeciesBy;
  String? _filterGenderBy;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                              setState(
                                () {
                                  _filterStatusBy = null;
                                  _filterspeciesBy = null;
                                  _filterGenderBy = null;
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            label: const Text(
                              'clear',
                              style: TextStyle(fontSize: 18, color: Colors.red),
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
                          groupValue: _filterStatusBy,
                          onChanged: (status) {
                            setState(
                              () {
                                _filterStatusBy = status;
                                //    _params['status'] = status;
                              },
                            );
                          },
                        ),
                        const Text('Alive'),
                        Radio(
                          value: 'dead',
                          groupValue: _filterStatusBy,
                          onChanged: (status) {
                            setState(
                              () {
                                _filterStatusBy = status;
                              },
                            );
                          },
                        ),
                        const Text('Dead'),
                        Radio(
                          value: 'unknown',
                          groupValue: _filterStatusBy,
                          onChanged: (status) {
                            setState(
                              () {
                                _filterStatusBy = status;
                              },
                            );
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
                          groupValue: _filterspeciesBy,
                          onChanged: (species) {
                            setState(
                              () {
                                _filterspeciesBy = species;
                              },
                            );
                          },
                        ),
                        const Text('Human'),
                        Radio(
                          value: 'alien',
                          groupValue: _filterspeciesBy,
                          onChanged: (species) {
                            setState(
                              () {
                                _filterspeciesBy = species;
                              },
                            );
                          },
                        ),
                        const Text('Alien'),
                        Radio(
                          value: 'unknown',
                          groupValue: _filterspeciesBy,
                          onChanged: (species) {
                            setState(
                              () {
                                _filterspeciesBy = species;
                              },
                            );
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
                          groupValue: _filterGenderBy,
                          onChanged: (gender) {
                            setState(
                              () {
                                _filterGenderBy = gender;
                              },
                            );
                          },
                        ),
                        const Text('Female'),
                        Radio(
                          value: 'male',
                          groupValue: _filterGenderBy,
                          onChanged: (gender) {
                            setState(
                              () {
                                _filterGenderBy = gender;
                              },
                            );
                          },
                        ),
                        const Text('Male'),
                        Radio(
                          value: 'genderless',
                          groupValue: _filterGenderBy,
                          onChanged: (gender) {
                            setState(
                              () {
                                _filterGenderBy = gender;
                              },
                            );
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
                            groupValue: _filterGenderBy,
                            onChanged: (gender) {
                              setState(
                                () {
                                  _filterGenderBy = gender;
                                },
                              );
                            },
                          ),
                          const Text('Unknown'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_filterGenderBy != null ||
                            _filterspeciesBy != null ||
                            _filterStatusBy != null) {
                          _filterStatusBy != null
                              ? _params['status'] = _filterStatusBy
                              : null;
                          _filterGenderBy != null
                              ? _params['gender'] = _filterGenderBy
                              : null;
                          _filterspeciesBy != null
                              ? _params['species'] = _filterspeciesBy
                              : null;
                          context
                              .read<FilterBloc>()
                              .add(ApplyFiltersEvent(filterParams: _params));
                        }
                      },
                      child: Container(
                        color: Colors.grey.shade900,
                        child: const Center(
                          child: Icon(
                            Icons.done,
                            size: 45,
                          ),
                        ),
                      ),
                    )
                  ]));
        },
      );
    },
  );
}
