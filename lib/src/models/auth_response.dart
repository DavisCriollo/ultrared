import 'dart:convert';

class AuthResponse {
    String? token;
    int ? id;
    String? nombre;
    String? usuario;
    String? rucempresa;
    String? codigo;
    String? nomEmpresa;
    String? nomComercial;
    DateTime? fechaCaducaFirma;
    List<String> ? rol;
    String? empCategoria;
    String? logo;
    String? foto;
    String? colorPrimario;
    String? colorSecundario;
    List<String>? empRoles;
    Map<String, PermisosUsuario>?permisosUsuario;

    AuthResponse({
        this.token,
        this.id,
        this.nombre,
        this.usuario,
        this.rucempresa,
        this.codigo,
        this.nomEmpresa,
        this.nomComercial,
        this.fechaCaducaFirma,
        this.rol,
        this.empCategoria,
        this.logo,
        this.foto,
        this.colorPrimario,
        this.colorSecundario,
        this.empRoles,
        this.permisosUsuario,
    });

    factory AuthResponse.fromJson(String str) => AuthResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
        id: json["id"],
        nombre: json["nombre"],
        usuario: json["usuario"],
        rucempresa: json["rucempresa"],
        codigo: json["codigo"],
        nomEmpresa: json["nomEmpresa"],
        nomComercial: json["nomComercial"],
        fechaCaducaFirma: DateTime.parse(json["fechaCaducaFirma"]),
        rol: List<String>.from(json["rol"].map((x) => x)),
        empCategoria: json["empCategoria"],
        logo: json["logo"],
        foto: json["foto"],
        colorPrimario: json["colorPrimario"],
        colorSecundario: json["colorSecundario"],
        empRoles: List<String>.from(json["empRoles"].map((x) => x)),
        permisosUsuario: Map.from(json["permisos_usuario"]).map((k, v) => MapEntry<String, PermisosUsuario>(k, PermisosUsuario.fromMap(v))),
    );

    Map<String, dynamic> toMap() => {
        "token": token,
        "id": id,
        "nombre": nombre,
        "usuario": usuario,
        "rucempresa": rucempresa,
        "codigo": codigo,
        "nomEmpresa": nomEmpresa,
        "nomComercial": nomComercial,
        "fechaCaducaFirma": "${fechaCaducaFirma!.year.toString().padLeft(4, '0')}-${fechaCaducaFirma!.month.toString().padLeft(2, '0')}-${fechaCaducaFirma!.day.toString().padLeft(2, '0')}",
        "rol": List<dynamic>.from(rol!.map((x) => x)),
        "empCategoria": empCategoria,
        "logo": logo,
        "foto": foto,
        "colorPrimario": colorPrimario,
        "colorSecundario": colorSecundario,
        "empRoles": List<dynamic>.from(empRoles!.map((x) => x)),
        "permisos_usuario": Map.from(permisosUsuario!).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
    };
}

class PermisosUsuario {
    Configuracion configuracion;

    PermisosUsuario({
        required this.configuracion,
    });

    factory PermisosUsuario.fromJson(String str) => PermisosUsuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PermisosUsuario.fromMap(Map<String, dynamic> json) => PermisosUsuario(
        configuracion: Configuracion.fromMap(json["Configuracion"]),
    );

    Map<String, dynamic> toMap() => {
        "Configuracion": configuracion.toMap(),
    };
}

class Configuracion {
    int permisos;

    Configuracion({
        required this.permisos,
    });

    factory Configuracion.fromJson(String str) => Configuracion.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Configuracion.fromMap(Map<String, dynamic> json) => Configuracion(
        permisos: json["permisos"],
    );

    Map<String, dynamic> toMap() => {
        "permisos": permisos,
    };
}
