import "package:finalproject/models/user_model.dart";
import "package:finalproject/services/profile_services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final profileServices = ProfileServicesImpl();

  void getProfile() async {
    emit(ProfileLoading());
    try {
      final UserModel user = await profileServices.getProfile(); 
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
