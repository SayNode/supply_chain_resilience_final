class Order {
  String bestellnummer = '';
  String allAttributes = '';

  Order();

  Order.fromJson(Map<String, dynamic> json)
      : bestellnummer = json['bestellnummer'] ?? -1,
        allAttributes = json['all_attributes'] ?? "";

  Order.fromString(String csvLine) {
    allAttributes = csvLine;
    List<String> splittedLine = csvLine.split(";");
    bestellnummer = splittedLine [0];
  }

  Map<String, dynamic> toJson() => {
    "bestellnummer": bestellnummer,
    "bestellnummer": allAttributes,
  };

}