import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/expenses/expenses.dart';

/*import 'package:expenses_repository/expenses_repository.dart'
    as expenses_repository;*/

part 'transaction.g.dart';
part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const Transaction._();

  factory Transaction({
    //@DateTimeConverter() required DateTime date,
    @Default('') String id,
    //@DateTimeNullableConverter() DateTime? createdAt,
    String? description,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  /*expenses_repository.Transaction toRepository() {
    var json = toJson();
    return expenses_repository.Transaction.fromJson(json);
  }*/
}
