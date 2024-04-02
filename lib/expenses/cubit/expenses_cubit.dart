import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expenses_state.dart';
part 'expenses_cubit.freezed.dart';
part 'expenses_cubit.g.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesState.initial());
  //ExpensesCubit() : super(const ExpensesState(status: ExpensesStatus.initial));
}
