class AccessUserModels{
    String Empresa;
    String DesEmpresa;
    String Negocio;

    AccessUserModels({
        required this.Empresa,
        required this.DesEmpresa,
        required this.Negocio
    });
      
    factory AccessUserModels.fromJson(Map<String, dynamic> json) => AccessUserModels(
        Empresa: json["Empresa"],
        DesEmpresa: json["DesEmpresa"],
        Negocio: json["Negocio"],
    );

     Map<String, dynamic> toJson() => {
        "Empresa": Empresa,
        "DesEmpresa": DesEmpresa,
        "Negocio": Negocio
    };
}