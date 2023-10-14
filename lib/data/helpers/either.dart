
///Clase Base para controlar respuesta de API
class Either<Left, Right> {
  final Left? left;
  final Right? right;
  final bool isLeft;

  Either._(this.left, this.right, this.isLeft);

  factory Either.left(Left failure) {
    return Either._(failure, null, true);
  }

  factory Either.right(Right value) {
    return Either._(null, value, false);
  }

  T when<T>(
    T Function(Left) left,
    T Function(Right) right,
  ) {
    if (isLeft) {
      return left(this.left as Left);
    } else {
      return right(this.right as Right);
    }
  }
}
