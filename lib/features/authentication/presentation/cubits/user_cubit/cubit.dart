import 'dart:io';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';
import 'package:shopera/features/authentication/domain/usecases/login.dart';
import 'package:shopera/features/authentication/domain/usecases/logout.dart';
import 'package:shopera/features/authentication/domain/usecases/register.dart';
import 'package:shopera/features/authentication/domain/usecases/update_user.dart';



part 'states.dart';

class UserCubit extends Cubit<UserState> {

  User? userEntite ;
  final LoginUsecase getLogin;
  final  RegisterUsecase getRegister;
  final UpdateUsecase putUser;
  final LogoutUseCase logout;
  UserCubit({required this.getLogin , required this.getRegister ,required this.putUser,required this.logout}) : super(UserInitial());


  Future<void> loginUser(
      {required String username, required String password , bool isFromGoogle =false}) async {
    // Add login logic here (e.g., API call)
    if(isFromGoogle) {
      emit(UserLoading());
    }

    // Simulate a successful login
    final failureOrLogin = await getLogin(username, password);

    emit(_mapFailureOrUserToState(failureOrLogin));
  }



  Future<void> registerUser(
     {required String username, required String email, required String password, bool isFromGoogle =false}) async {
    // Add register logic here (e.g., API call)
    if(isFromGoogle) {
      emit(UserLoading());
    }

    // Simulate a successful register
    final failureOrRegister = await getRegister(username,email, password);

    emit(_mapFailureOrUserToState(failureOrRegister));
  }



   Future<void> updateUser(
     {required User user}) async {
   
      emit(UserLoading());

    // Simulate a successful update
    final failureOrUpdated = await putUser(user);

    emit(_mapFailureOrUserToState(failureOrUpdated));

  }

  Future<void> logoutUser(BuildContext context) async {
    logout().then((onValue){
      Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.routeName,(route) => false, );
    });

  }


    Future<void> pickImage() async {
      final picker = ImagePicker();
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      //  File(pickerFile.path);
      emit(ProfileImagePickerSuccessState( imageFile: File(pickerFile.path),));
    } else {
      print("No image selected");
      emit(const ProfileImagePickerErrorState(error: 'Error image selected'));
    }
  }


  UserState _mapFailureOrUserToState(Either<Failure, User> either) {
    return either.fold(
        (failure) => UserFailure(error: failure.message),
        (user) {
          userEntite = user;
          return UserSuccess(user: user);

        } 
        );
  }


}
