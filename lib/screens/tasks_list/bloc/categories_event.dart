part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();
  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoriesEvent {}

class AddCategory extends CategoriesEvent {
  final String name;
  const AddCategory(this.name);

  @override
  List<Object?> get props => [name];
}

class EditCategory extends CategoriesEvent {
  final String id;
  final String name;
  const EditCategory(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}

class DeleteCategory extends CategoriesEvent {
  final String id;
  const DeleteCategory(this.id);

  @override
  List<Object?> get props => [id];
}
