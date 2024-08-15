
import 'package:either_dart/either.dart';

typedef Failure=String;
typedef Success=void;
typedef Result=Future<Either<Failure,Success>>;