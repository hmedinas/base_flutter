
class ResponseApiModels<T> {
    final int idResponse;
    final String message;
    final int totalRows;
    final T? data;

    ResponseApiModels({
        required this.idResponse,
        required this.message,
        required this.totalRows,
        this.data
    });

    /// Factory para convertir el JSON de la API
    /// [json]: El mapa que viene de Dio/Http
    /// [fromJsonT]: Una función que explica cómo mapear el objeto T
    factory ResponseApiModels.fromJson(Map<String, dynamic> json, T Function(Object? json)? fromJsonT) 
    {
        return ResponseApiModels<T>(
        // Mapeamos el código numérico al Enum
        idResponse: json['idResponse'],
        message: json['message'] ?? '',
        totalRows: json['totalRows'] ?? 0,
        // Si hay data y tenemos la función de mapeo, la ejecutamos
        data: (json['data'] != null && fromJsonT != null) 
            ? fromJsonT(json['data']) 
            : null
        );
    }

}