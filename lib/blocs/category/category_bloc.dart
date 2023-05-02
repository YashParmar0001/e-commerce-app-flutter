import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/repositories/category/category_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/category_model.dart';
import 'dart:developer' as developer;

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required CategoryRepository categoryRepository}) : _categoryRepository = categoryRepository, super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
  }

  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  void _onLoadCategories(LoadCategories event, Emitter<CategoryState> emit) {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllCategories().listen((categories) {
      add(UpdateCategories(categories: categories));
    });
    // add(UpdateCategories(categories: Category.categories));
  }

  void _onUpdateCategories(UpdateCategories event, Emitter<CategoryState> emit) {
    developer.log('Updating categories...', name: 'CategoryState');
    emit(CategoryLoaded(categories: event.categories));
  }
}
