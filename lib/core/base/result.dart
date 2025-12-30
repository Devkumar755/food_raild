 class Result<T> {
  final T? data;
  final String? error;
  final int? statusCode;
  final bool isSuccess;

  // Private constructor
  Result._({
    this.data,
    this.error,
    this.statusCode,
    required this.isSuccess,
  });

  // Success state: Requires generic data
  static Result<T> success<T>(T data) {
    return Result._(
      data: data,
      isSuccess: true,
    );
  }

  // Error state: Requires message, status code, and optional data
  static Result<T> failure<T>({
    required String message,
    int? statusCode,
    T? data,
  }) {
    return Result._(
      error: message,
      statusCode: statusCode,
      data: data,
      isSuccess: false,
    );
  }
}