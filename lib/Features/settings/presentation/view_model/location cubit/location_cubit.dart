import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shop_api_app/Features/settings/data/models/delete_address_model/delete_address_model.dart';
import 'package:shop_api_app/Features/settings/data/models/get_address_model/get_address_model.dart';
import 'package:shop_api_app/Features/settings/data/models/location_model/location_model.dart';
import 'package:shop_api_app/core/functions/toast_message.dart';
import 'package:shop_api_app/core/utils/consts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/api/urls.dart';
import '../../../../../core/utils/cache_helper.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(LocationInitial());
  static LocationCubit get(context) => BlocProvider.of(context);

  String lat = '';
  String long = '';
  String locationMessage = 'Your Location';
  String street = '';
  String city = '';
  String region = '';
  String fullAddress = '';

  Future<void> getCurrentLocation() async {
    emit(GetLocationLoading());
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationMessage = 'Location Services are disabled.';
      //await Future.error('Location Services are disabled.');
      //emit(GetLocationError());
    }
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        locationMessage = 'Location permissions are denied.';
        await Future.error('Location permissions are denied.');
        emit(GetLocationError());
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      locationMessage = 'Location permissions are permanently denied.';
      await Future.error('Location permissions are permanently denied.');
      emit(GetLocationError());
    }
    await Geolocator.getCurrentPosition().then((value) async {
      lat = value.latitude.toString();
      long = value.longitude.toString();
      locationMessage = 'Latitude: $lat , Longitude: $long';
      emit(GetLocationSuccess());
      liveLocation();
      await getAddressFromLatLng();
    });
  }

  void liveLocation() {
    try {
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position position) {
        lat = position.latitude.toString();
        long = position.longitude.toString();
        locationMessage = 'Latitude: $lat , Longitude: $long';
      });
      emit(GetLocationSuccess());
    } catch (e) {
      emit(GetLocationError());
    }
  }

  Future<void> openMap({required double lat, required double long}) async {
    try {
      emit(OpenMapLoading());
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$lat,$long';
      if (await canLaunchUrlString(googleUrl)) {
        await launchUrlString(googleUrl);
        emit(OpenMapSuccess());
      } else {
        toastMessage(msg: 'Could\'nt launch $googleUrl', type: ToastType.error);
        emit(OpenMapError());
      }
    } catch (e) {
      emit(OpenMapError());
    }
  }

  Future<void> getAddressFromLatLng() async {
    try {
      emit(GetAddressLoading());
      double latitude = double.parse(lat);
      double longitude = double.parse(long);
      List<Placemark> placemark =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemark[0];
      street = place.street.toString();
      region = place.locality.toString();
      city = place.administrativeArea.toString();
      fullAddress =
          'Address: ${place.locality}, ${place.country}, ${place.street}, ${place.administrativeArea}';
      emit(GetAddressSuccess());
    } catch (e) {
      emit(GetAddressError());
    }
  }

  LocationModel? locationModel;

  Future<void> addNewAddress({
    required String name,
    required String city,
    required String region,
    required String street,
    required String notes,
  }) async {
    try {
      emit(AddNewLocationLoading());
      final token = CacheHelper.getData(key: 'token');
      var value = await ApiService.postData(
        token: token,
        url: Urls.addresses,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': street,
          'notes': notes,
          'latitude': lat,
          'longitude': long,
        },
      );
      print('$name, $city, $region, $street, $notes, $lat, $long');
      locationModel = LocationModel.fromJson(value.data);
      if (locationModel?.status == true) {
        toastMessage(
            msg: locationModel?.message ?? 'Success', type: ToastType.success);
        emit(AddNewLocationSuccess());
      } else {
        toastMessage(
            msg: locationModel?.message ?? 'something invalid',
            type: ToastType.error);
        emit(AddNewLocationError());
      }
      getAddresses();
    } catch (e) {
      print(e);
      toastMessage(msg: e.toString(), type: ToastType.error);
      emit(AddNewLocationError());
    }
  }

  GetAddressModel? getAddressModel;
  Future<void> getAddresses() async {
    try {
      emit(GetLocationModelsLoading());
      final token = CacheHelper.getData(key: 'token');
      var value =
          await ApiService.getData(url: Urls.addresses, token: token);
      getAddressModel = GetAddressModel.fromJson(value);
      emit(GetLocationModelsSuccess());
    } catch (e) {
      print(e.toString());
      emit(GetLocationModelsError());
    }
  }

  DeleteAddressModel? deleteAddressModel;
  Future<void> deleteAddress({required int id}) async {
    try {
      getAddressModel?.data?.data?.removeWhere((address) => address.id == id);
      emit(DeleteAddressLoading());
      final token = CacheHelper.getData(key: 'token');
      var value = await ApiService.deleteData(
          url: '${Urls.addresses}/$id', token: token);
      deleteAddressModel = DeleteAddressModel.fromJson(value);
      toastMessage(
          msg: deleteAddressModel?.message ?? 'Success',
          type: ToastType.success);
      emit(DeleteAddressSuccess());
    } catch (e) {
      toastMessage(
          msg: deleteAddressModel?.message ?? 'Error', type: ToastType.error);
      print(e.toString());
      getAddresses();
      emit(DeleteAddressError());
    }
  }

  Future<void> updateAddress({
    required int id,
    required String name,
    required String city,
    required String region,
    required String street,
    required String lat,
    required String long,
    required String notes,
  }) async {
    try {
      double latitude = double.parse(lat);
      double longitude = double.parse(long);
      emit(UpdateAddressLoading());
      final token = CacheHelper.getData(key: 'token');
      await ApiService.putData(
        url: '${Urls.addresses}/$id',
        token: token,
        data: {
          "name": name,
          "city": city,
          "region": region,
          "details": street,
          "latitude": latitude,
          "longitude": longitude,
          "notes": notes
        },
      );
      //deleteAddressModel = DeleteAddressModel.fromJson(value);
      toastMessage(msg: 'Edited Successfuully...', type: ToastType.success);
      emit(UpdateAddressSuccess());
      await getAddresses();
    } catch (e) {
      toastMessage(
          msg: deleteAddressModel?.message ?? 'Error', type: ToastType.error);
      print(e.toString());
      getAddresses();
      emit(UpdateAddressError());
    }
  }
}
