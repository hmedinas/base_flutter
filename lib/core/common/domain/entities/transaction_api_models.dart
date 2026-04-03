enum TypeTransaction {
  err('ERR'),
  ok('OK'),
  notFound('NOTFOUND');

  // Propiedad para almacenar el string que viene de la API
  final String value;
  
  // Constructor constante
  const TypeTransaction(this.value);

  /// Método de ayuda para convertir un String de la API al Enum
  /// Útil si la API te devuelve 'ERR' y quieres obtener TypeTransaction.err
  static TypeTransaction fromString(String status) {
    return TypeTransaction.values.firstWhere(
      (e) => e.value == status,
      orElse: () => TypeTransaction.err, // Valor por defecto en caso de error
    );
  }
}

class TransactionApiModels {
    final TypeTransaction typeTransaction;
    final String message;
    final String? key;
    final Object? output;

    TransactionApiModels({
        required this.typeTransaction,
        required this.message,
        this.key,
        this.output
    });

    factory TransactionApiModels.fromJson(Map<String, dynamic> json) 
    {
        return TransactionApiModels(
        // Mapeamos el código numérico al Enum
        typeTransaction: TypeTransaction.fromString(json['type']),
        message: json['message'] ?? '',
        key:  json['key'] ,
        output: json['outPut'],
        );
    }
}

