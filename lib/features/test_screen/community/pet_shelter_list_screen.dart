import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/list_items/pet_shelter_list_item_card.dart';
import 'package:poochcare/features/community/data/models/pet_shelter_model.dart';

class PetShelterListScreen extends StatefulWidget {
  const PetShelterListScreen({super.key});

  @override
  State<PetShelterListScreen> createState() => _PetShelterListScreenState();
}

class _PetShelterListScreenState extends State<PetShelterListScreen> {
  final List<PetShelterModel> _shelters = [
    const PetShelterModel(
      id: '1',
      // image: 'https://images.unsplash.com/photo-1558788353-f76d92427f16?w=500',
      // name: 'Happy Paws Shelter',
      // experience: '15+ yrs experience',
      // location: 'Andheri West',
    ),
    const PetShelterModel(
      id: '2',
      // image: 'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=500',
      // name: 'Safe Haven Animal Care',
      // experience: '10+ yrs experience',
      // location: 'Bandra East',
    ),
    const PetShelterModel(
      id: '3',
      // image:
      //     'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?w=500',
      // name: 'Furry Friends Rescue',
      // experience: '8+ yrs experience',
      // location: 'Powai',
    ),
    const PetShelterModel(
      id: '4',
      // image:
      //     'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?w=500',
      // name: 'Paws & Claws Shelter',
      // experience: '12+ yrs experience',
      // location: 'Kandivali East',
    ),
  ];

  late Map<String, bool> _selectedShelters;

  @override
  void initState() {
    super.initState();
    _selectedShelters = {for (var shelter in _shelters) shelter.id: false};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: _shelters.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final shelter = _shelters[index];
            return PetShelterListItemCard(
              item: shelter,
              isSelected: _selectedShelters[shelter.id] ?? false,
              onSelectionChanged: (value) {
                setState(() {
                  _selectedShelters[shelter.id] = value;
                });
              },
              onTap: () {
                // Handle tap - navigate to shelter details
              },
            );
          },
        ),
      ),
    );
  }
}
