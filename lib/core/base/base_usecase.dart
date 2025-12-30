import 'result.dart';

abstract class BaseUseCase<T, Params> {
  Future<Result<T>> call(Params params);
}


abstract class BaseNoParamUseCase<T> {
  Future<Result<T>> call();
}

abstract class BaseStreamNoParamUseCase<T> {
  Stream<T> call();
}

abstract class BaseStreamUseCase<T, Params> {
  Stream<T> call(Params params);
}