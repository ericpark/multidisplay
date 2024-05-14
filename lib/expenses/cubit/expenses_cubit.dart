import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expenses_state.dart';
part 'generated/expenses_cubit.freezed.dart';
part 'generated/expenses_cubit.g.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesState.initial());
}
