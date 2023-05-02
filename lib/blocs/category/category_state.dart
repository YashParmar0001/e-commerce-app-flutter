part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  CategoryLoaded({this.categories = const <Category>[]});

  final List<Category> categories;

  @override
  List<Object?> get props => [categories];
}