class BusArrival {
  final String service;
  final String operatorName;
  final List nextBuses;

  BusArrival({this.service, this.operatorName, this.nextBuses});

  factory BusArrival.fromJson(Map<String, dynamic> json) {
    return new BusArrival(
      service: json['ServiceNo'],
      operatorName: json['Operator'],
      nextBuses: [
        NextBus.fromJson(json['NextBus']),
        NextBus.fromJson(json['NextBus2']),
        NextBus.fromJson(json['NextBus3']),
      ],
    );
  }
}

class NextBus {
  final String timeInMinutes;

  final String load;
  final String feature;
  final String type;

  NextBus({this.timeInMinutes, this.load, this.feature, this.type});

  factory NextBus.fromJson(Map<String, dynamic> json) {
    DateTime now = DateTime.now();
    String timeInMinutes;

    try {
      var estimatedArrival = DateTime.parse(json['EstimatedArrival']);
      timeInMinutes = estimatedArrival.difference(now).inMinutes.toString();


      // Arrived indicator rather than showing arrival in 0 minutes
      if (timeInMinutes == "0") 
        timeInMinutes = "Arr";
      else timeInMinutes = '${timeInMinutes} m';
    } catch (e) {
      timeInMinutes = null;
    }

    return new NextBus(
      // estimatedArrival: json['EstimatedArrival'],
      timeInMinutes: timeInMinutes,
      load: json['Load'],
      feature: json['Feature'],
      type: json['type'],
    );
  }
}
