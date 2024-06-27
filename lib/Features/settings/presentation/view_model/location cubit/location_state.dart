part of 'location_cubit.dart';

sealed class LocationStates extends Equatable {
  const LocationStates();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationStates {}

final class LocationLoadingStates extends LocationStates {}

final class GetLocationLoading extends LocationLoadingStates {}

final class GetLocationSuccess extends LocationStates {}

final class GetLocationError extends LocationStates {}

final class GetAddressLoading extends LocationLoadingStates {}

final class GetAddressSuccess extends LocationStates {}

final class GetAddressError extends LocationStates {}

final class OpenMapLoading extends LocationLoadingStates {}

final class OpenMapSuccess extends LocationStates {}

final class OpenMapError extends LocationStates {}

final class AddNewLocationLoading extends LocationLoadingStates {}

final class AddNewLocationSuccess extends LocationStates {}

final class AddNewLocationError extends LocationStates {}

final class GetLocationModelsLoading extends LocationLoadingStates {}

final class GetLocationModelsSuccess extends LocationStates {}

final class GetLocationModelsError extends LocationStates {}

final class DeleteAddressLoading extends LocationStates {}

final class DeleteAddressSuccess extends LocationStates {}

final class DeleteAddressError extends LocationStates {}

final class UpdateAddressLoading extends LocationLoadingStates {}

final class UpdateAddressSuccess extends LocationStates {}

final class UpdateAddressError extends LocationStates {}