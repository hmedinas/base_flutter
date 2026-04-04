class BusinessModels{
    int idEmpresa;
    String empresa;
    String desEmpresa;
    String negocio;

    BusinessModels({
        required this.idEmpresa,
        required this.empresa,
        required this.desEmpresa,
        required this.negocio
    });
      
    factory BusinessModels.fromJson(Map<String, dynamic> json) =>  BusinessModels(
        idEmpresa: json["idEmpresa"],
        empresa: json["empresa"],
        desEmpresa: json["desEmpresa"],
        negocio: json["negocio"],
    );

     Map<String, dynamic> toJson() => {
        "IdEmpresa": idEmpresa,
        "Empresa": empresa,
        "DesEmpresa": desEmpresa,
        "Negocio": negocio
    };
}