class Router {
  List<Routes> routes;

  Router({this.routes});

  Router.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = [];
      json['routes'].forEach((v) {
        routes.add(new Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routes != null) {
      data['routes'] = this.routes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  List<Legs> legs;

  Routes({this.legs});

  Routes.fromJson(Map<String, dynamic> json) {
    if (json['legs'] != null) {
      legs = [];
      json['legs'].forEach((v) {
        legs.add(new Legs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.legs != null) {
      data['legs'] = this.legs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Legs {
  List<Steps> steps;

  Legs({this.steps});

  Legs.fromJson(Map<String, dynamic> json) {
    if (json['steps'] != null) {
      steps = [];
      json['steps'].forEach((v) {
        steps.add(new Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  Maneuver maneuver;

  Steps({this.maneuver});

  Steps.fromJson(Map<String, dynamic> json) {
    maneuver = json['maneuver'] != null
        ? new Maneuver.fromJson(json['maneuver'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.maneuver != null) {
      data['maneuver'] = this.maneuver.toJson();
    }
    return data;
  }
}

class Maneuver {
  List<double> location;

  Maneuver({this.location});

  Maneuver.fromJson(Map<String, dynamic> json) {
    location = json['location'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    return data;
  }
}