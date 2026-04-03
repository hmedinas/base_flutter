class BusinessModels{
    String empresa;
    String desEmpresa;
    String negocio;

    BusinessModels({
        required this.empresa,
        required this.desEmpresa,
        required this.negocio
    });
      
    factory BusinessModels.fromJson(Map<String, dynamic> json) =>  BusinessModels(
        empresa: json["empresa"],
        desEmpresa: json["desEmpresa"],
        negocio: json["negocio"],
    );

     Map<String, dynamic> toJson() => {
        "Empresa": empresa,
        "DesEmpresa": desEmpresa,
        "Negocio": negocio
    };
}