class Order {
  String userName;
  String mealName;
  int quantity;
  double cost;
  String date;
  String time;
  String specialRequests;
  String contactNumber;

  Order( this.userName, this.mealName, this.quantity, this.cost, this.date, this.time,
      this.specialRequests, this.contactNumber);

  @override
  String toString() {
    return 'Ordered by: $userName, Meal: $mealName, Quantity: $quantity, Cost: \$${cost.toStringAsFixed(2)}, Date: $date, Time: $time,\nSpecial Requests: $specialRequests, Contact Number: $contactNumber\n';
  }
}
