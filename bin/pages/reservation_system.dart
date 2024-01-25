import 'dart:developer';
import 'dart:io';

import '../data/food.dart';
import '../models/order.dart';
import '../models/restaurant.dart';
import '../models/user.dart';
import '../utils/methods.dart';

class ReservationSystem {
  Restaurant restaurant = Restaurant();
  User user = User();

  List<Order> orders = [];
  String staffPassword = "admin1221";

  void enterUserInfo() {
    stdout.write("Enter your name: ");
    user.name = stdin.readLineSync()!;

    stdout.write("Enter your family name: ");
    user.family = stdin.readLineSync()!;

    while (true) {
      stdout.write("Enter your email: ");
      user.email = stdin.readLineSync()!;

      if (user.email.contains("@gmail.com") || user.email.contains("@")) {
        break;
      } else {
        print("Please enter a valid Gmail address.");
      }
    }
  }

  void run() {
    ReservationService.displayWelcomeSpeech();

    while (true) {
      print("\x1B[31m\n \t\t\t ------ Main Menu ------\x1B[0m");
      print("\t\t\t |  1.📜 Menu");
      print("\t\t\t |  2.📃 Restaurant Info");
      print("\t\t\t |  3.👨‍🍳 Staff");
      print("\t\t\t |  4.⬅️  Exit");
      print("\x1B[31m \t\t\t -----------------------\x1B[0m");

      int choice = ReservationService.readInt("Enter your choice: ");

      try {
        switch (choice) {
          case 1:
            enterUserInfo();
            handleMenu();
            break;
          case 2:
            ReservationService.displayRestaurantInfo();
            break;
          case 3:
            handleStaff();
            break;
          case 4:
            print(
                "\x1B[33m\n \t\t 👋 Exiting the program. Goodbye!👋\x1B[0m \n");
            exit(0);
          default:
            print("Invalid choice. Please try again.");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void handleMenu() {
    while (true) {
      print("\x1B[31m\n \t\t\t ------ Menu Options ------\x1B[0m");
      print("\t\t\t | 1. Order Food");
      print("\t\t\t | 2. Exit to Main Menu");
      print("\x1B[31m \t\t\t --------------------------\x1B[0m");
      ReservationService.displayMenu();

      int choice = ReservationService.readInt("Enter your choice: ");
      try {
        switch (choice) {
          case 1:
            handleOrderFood();
            break;
          case 2:
            return;
          default:
            print("Invalid choice. Please try again.");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  String readNonEmptyString(String prompt) {
    String? input;
    do {
      stdout.write(prompt);
      input = stdin.readLineSync();
      if (input == null || input.isEmpty) {
        print("Input cannot be empty. Please enter a value.");
      }
    } while (input == null || input.isEmpty);
    return input;
  }

  int readPositiveInt(String prompt) {
    int number;
    do {
      number = ReservationService.readInt(prompt);
      if (number < 1) {
        print("Number must be positive.");
      }
    } while (number < 1);
    return number;
  }

  String readValidDate(String prompt) {
    RegExp dateRegex =
        RegExp(r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}$");
    String date;
    do {
      date = readNonEmptyString(prompt);
      if (!dateRegex.hasMatch(date)) {
        print("Invalid date format. Please enter in dd/mm/yyyy format.");
      }
    } while (!dateRegex.hasMatch(date));
    return date;
  }

  String readValidTime(String prompt) {
    RegExp timeRegex = RegExp(r"^([01]?[0-9]|2[0-3]):[0-5][0-9]$");
    String time;
    do {
      time = readNonEmptyString(prompt);
      if (!timeRegex.hasMatch(time)) {
        print("Invalid time format. Please enter in HH:MM format.");
      }
    } while (!timeRegex.hasMatch(time));
    return time;
  }

  void handleOrderFood() {
    var numberOfPeople =
        readPositiveInt("Enter the number of people for the reservation: ");
    var reservationDate =
        readValidDate("Enter the date for the reservation (dd/mm/yyyy): ");
    var reservationTime =
        readValidTime("Enter the time for the reservation (HH:MM): ");

    stdout.write("Enter any special requests (or type 'none'): ");
    var specialRequests = stdin.readLineSync()!;

    stdout.write("Enter a contact number for the reservation: ");
    var contactNumber = stdin.readLineSync()!;

    stdout.write("Enter the meal number which you want to order: ");
    var itemNumbers = stdin
        .readLineSync()!
        .split(',')
        .map((e) => int.parse(e.trim()))
        .toList();

    var totalCost = 0.0;

    for (var itemNumber in itemNumbers) {
      if (itemNumber >= 1 && itemNumber <= menu.length) {
        var food = menu[itemNumber - 1];
        int quantity =
            ReservationService.readInt("Enter the quantity of ${food.name}: ");

        var itemCost = food.price * quantity;
        totalCost += itemCost;
        orders.add(Order( user.name, food.name, quantity, itemCost, reservationDate,
            reservationTime, specialRequests, contactNumber));
      } else {
        print("Invalid meal number. Please try again.");
        return;
      }
    }

    print(
        "\n\t\t\t 🎉 Order placed successfully! Total Cost: \$${totalCost.toStringAsFixed(2)}");

    print("\nYour Order Details:");
    print("Date: $reservationDate");
    print("Time: $reservationTime");
    print("Special Requests: $specialRequests");
    print("Contact Number: $contactNumber");
    print("Total Cost: \$${totalCost.toStringAsFixed(2)}");
    print("Reservation confirmed for $numberOfPeople people.\n");
  }

  void handleStaff() {
    stdout.write("🔐 Enter password:");
    var enteredPassword = stdin.readLineSync()!;

    if (enteredPassword == staffPassword) {
      while (true) {
        ReservationService.displayStaffMenu();

        stdout.write("Enter your choice: ");
        var staffChoice = int.parse(stdin.readLineSync()!);

        switch (staffChoice) {
          case 1:
            ReservationService.displayMenu();
            break;
          case 2:
            displayOrderedOrders();
            break;
          case 3:
            ReservationService.addItemToMenu();
            break;
          case 4:
            ReservationService.changePriceOfItem();
            break;
          case 5:
            ReservationService.editItemInMenu();
            break;
          case 6:
            ReservationService.deleteItemFromMenu();
            break;
          case 7:
            cancelOrder();
            break;
          case 8:
            print("Exiting Staff Section.");
            return;
          default:
            print("Invalid choice. Please try again.");
        }
      }
    } else {
      print("\t\t\t 🚫 Incorrect password. Access denied.");
    }
  }

  void displayOrderedOrders() {
    const int consoleWidth = 80;
    print("\x1B[35m\n \t\t\t ----- 📋 Ordered Orders -----\x1B[0m");

    int index = 1;
    for (var order in orders) {
      String orderLine = "Order #$index: $order";
      int padding = (consoleWidth - orderLine.length) ~/ 2;
      padding = padding > 0 ? padding : 0;
      String paddedLine = ' ' * padding + orderLine;
      print(paddedLine);
      index++;
    }
  }

  void cancelOrder() {
    displayOrderedOrders();
    stdout.write("Enter the order number you want to cancel: ");
    var orderNumber = int.parse(stdin.readLineSync()!) - 1;

    if (orderNumber >= 0 && orderNumber < orders.length) {
      var cancelledOrder = orders.removeAt(orderNumber);

      print("\t\t\t $cancelledOrder cancelled successfully!");
    } else {
      print("\t\t\t Invalid order number. Please try again.");
    }
  }
}
