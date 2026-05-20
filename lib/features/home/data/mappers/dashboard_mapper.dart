import 'package:poochcare/core/domain/models/appointment.dart';
import 'package:poochcare/core/domain/models/cart.dart';
import 'package:poochcare/core/domain/models/pet.dart';
import 'package:poochcare/core/domain/models/user.dart';
import 'package:poochcare/features/home/data/models/dashboard_response.dart';

class DashboardDomainData {
  const DashboardDomainData({
    required this.user,
    required this.cart,
    required this.pets,
    required this.appointments,
  });

  final User user;
  final Cart cart;
  final List<Pet> pets;
  final List<Appointment> appointments;
}

class DashboardMapper {
  const DashboardMapper._();

  static DashboardDomainData toDomain(DashboardResponse response) {
    return DashboardDomainData(
      user: User(
        id: response.user.id,
        name: response.user.name,
        email: response.user.email,
      ),
      cart: Cart(
        itemsCount: response.cart.itemsCount,
        totalAmount: response.cart.totalAmount,
      ),
      pets: response.pets
          .map(
            (PetItemResponse p) => Pet(id: p.id, name: p.name, breed: p.breed),
          )
          .toList(),
      appointments: response.appointments
          .map(
            (AppointmentItemResponse a) => Appointment(
              id: a.id,
              petId: a.petId,
              service: a.service,
              dateLabel: a.dateLabel,
            ),
          )
          .toList(),
    );
  }
}
