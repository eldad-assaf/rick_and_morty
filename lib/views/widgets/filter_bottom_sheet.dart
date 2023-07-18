import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/common/utils/constants.dart';
import 'package:rick_and_morty/common/utils/text_style.dart';
import 'package:rick_and_morty/state/blocs/filter_bloc/bloc/filter_bloc.dart';

void showFilterModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return _FilterModalContent();
    },
  );
}

class _FilterModalContent extends StatefulWidget {
  @override
  __FilterModalContentState createState() => __FilterModalContentState();
}

class __FilterModalContentState extends State<_FilterModalContent> {
  String? _filterStatusBy;
  String? _filterspeciesBy;
  String? _filterGenderBy;

  @override
  void initState() {
    super.initState();
    _initFilterParams();
  }

  void _initFilterParams() {
    final state = context.read<FilterBloc>().state;
    final filterParams = state.filterParmas;
    if (filterParams != null) {
      _filterStatusBy = filterParams['status'];
      _filterGenderBy = filterParams['gender'];
      _filterspeciesBy = filterParams['species'];
    }
  }

  bool _isThereAtLeastOneFilterChoice() {
    return _filterGenderBy != null ||
        _filterspeciesBy != null ||
        _filterStatusBy != null;
  }

  void _onStatusChanged(String? status) {
    setState(() {
      _filterStatusBy = status;
    });
  }

  void _onSpeciesChanged(String? species) {
    setState(() {
      _filterspeciesBy = species;
    });
  }

  void _onGenderChanged(String? gender) {
    setState(() {
      _filterGenderBy = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Filter Options',
                style: appStyle(20, Appconst.kGreyBk, FontWeight.w300),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _isThereAtLeastOneFilterChoice()
                    ? () {
                        context.read<FilterBloc>().add(ClearFilterEvent());
                        setState(() {
                          _filterStatusBy = null;
                          _filterspeciesBy = null;
                          _filterGenderBy = null;
                        });
                        Navigator.pop(context);
                      }
                    : null,
                icon: Icon(
                  Icons.clear,
                  color: _isThereAtLeastOneFilterChoice()
                      ? Colors.red
                      : Colors.grey,
                  size: 22.sp,
                ),
                label: Text(
                  'clear',
                  style: appStyle(
                    13,
                    _isThereAtLeastOneFilterChoice()
                        ? Appconst.kred
                        : Appconst.kGreyLight,
                    FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Status',
            style: appStyle(16, Appconst.kBkDark, FontWeight.bold),
          ),
          _buildFilterGroup(
            groupValue: _filterStatusBy,
            choices: ['alive', 'dead', 'unknown'],
            onChanged: _onStatusChanged,
          ),
          SizedBox(height: 16.h),
          Text(
            'Species',
            style: appStyle(16, Appconst.kBkDark, FontWeight.bold),
          ),
          _buildFilterGroup(
            groupValue: _filterspeciesBy,
            choices: ['human', 'alien', 'unknown'],
            onChanged: _onSpeciesChanged,
          ),
          SizedBox(height: 16.h),
          Text(
            'Gender',
            style: appStyle(16, Appconst.kBkDark, FontWeight.bold),
          ),
          _buildFilterGroup(
            groupValue: _filterGenderBy,
            choices: ['female', 'male', 'genderless'],
            onChanged: _onGenderChanged,
          ),
          _buildFilterGroup(
            groupValue: _filterGenderBy,
            choices: ['unknown'],
            onChanged: _onGenderChanged,
          ),
          SizedBox(height: 20.h),
          InkWell(
            onTap: _isThereAtLeastOneFilterChoice()
                ? () {
                    context.read<FilterBloc>().add(ApplyFiltersEvent(
                          filterParams: _buildFilterParamsMap(),
                        ));
                    Navigator.pop(context);
                  }
                : null,
            child: Container(
              color: Colors.grey.shade900,
              child: Center(
                child: Icon(
                  Icons.done,
                  size: 45.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterGroup({
    required String? groupValue,
    required List<String> choices,
    required void Function(String?) onChanged,
  }) {
    return Row(
      children: choices.map((choice) {
        return Expanded(
          child: Row(
            children: [
              Radio(
                value: choice,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              SizedBox(width: 2.0.w),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.none,
                  child: Text(
                    choice.capitalizeFirstLetter(),
                    style: appStyle(13, Appconst.kBkDark, FontWeight.normal),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Map<String, dynamic>? _buildFilterParamsMap() {
    final params = <String, dynamic>{};
    if (_filterStatusBy != null) params['status'] = _filterStatusBy;
    if (_filterGenderBy != null) params['gender'] = _filterGenderBy;
    if (_filterspeciesBy != null) params['species'] = _filterspeciesBy;
    return params.isEmpty ? null : params;
  }
}

extension StringExtensions on String {
  String capitalizeFirstLetter() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;
  }
}
