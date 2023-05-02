part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoryEvent {}

class UpdateCategories extends CategoryEvent {
  UpdateCategories({this.categories = const <Category>[]});

  final List<Category> categories;

  @override
  List<Object?> get props => [categories];
}
