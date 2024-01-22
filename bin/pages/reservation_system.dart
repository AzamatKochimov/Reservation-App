import 'dart:io';

import '../data/food.dart';
import '../models/restaurant.dart';
import '../models/user.dart';
import '../utils/methods.dart';

class ReservationSystem {
  Restaurant restaurant = Restaurant();
  User user = User();

  List<String> orders = [];
  String staffPassword = "password123";

  void enterUserInfo() {
    stdout.write("Enter your name: ");
    user.name = stdin.readLineSync()!;

    stdout.write("Enter your family name: ");
    user.family = stdin.readLineSync()!;

    while (true) {
      stdout.write("Enter your email: ");
      user.email = stdin.readLineSync()!;

      if (user.email.contains("@gmail.com") || user.email.contains("")) {
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

      stdout.write("Enter your choice: ");
      var choice = int.parse(stdin.readLineSync()!);

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
          print("\x1B[33m\n \t\t 👋 Exiting the program. Goodbye!👋\x1B[0m \n");
          exit(0);
        default:
          print("Invalid choice. Please try again.");
      }
    }
  }

  void handleMenu() {
    while (true) {
      ReservationService.displayMenu();

      print("\x1B[31m\n \t\t\t ------ Menu Options ------\x1B[0m");
      print("\t\t\t | 1. Order Food");
      print("\t\t\t | 2. Exit to Main Menu");
      print("\x1B[31m \t\t\t --------------------------\x1B[0m");

      stdout.write("Enter your choice: ");
      var choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          handleOrderFood();
          break;
        case 2:
          return;
        default:
          print("Invalid choice. Please try again.");
      }
    }
  }

  void handleOrderFood() {
    stdout.write("Enter the item numbers you want to order ");
    var itemNumbers = stdin
        .readLineSync()!
        .split(',')
        .map((e) => int.parse(e.trim()))
        .toList();

    var totalCost = 0.0;

    for (var itemNumber in itemNumbers) {
      if (itemNumber >= 1 && itemNumber <= menu.length) {
        var food = menu[itemNumber - 1];
        stdout.write("Enter the quantity of ${food.name}: ");
        var quantity = int.parse(stdin.readLineSync()!);

        var itemCost = food.price * quantity;
        totalCost += itemCost;

        orders
            .add("${food.name} x$quantity - \$${itemCost.toStringAsFixed(2)}");
      } else {
        print("Invalid item number. Please try again.");
        return;
      }
    }

    print(
        "\t\t\t 🎉 Order placed successfully! Total Cost: \$${totalCost.toStringAsFixed(2)}");

    stdout.write("Enter the number of people for the reservation: ");
    var numberOfPeople = int.parse(stdin.readLineSync()!);

    print("Reservation confirmed for $numberOfPeople people.");
  }

  void handleStaff() {
    stdout.write("Enter staff password 🔐:");
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
    print("\x1B[35m\n \t\t\t ----- 📋 Ordered Orders -----\x1B[0m");
    print("\t\t\t Ordered by : ${user.name}");
    for (var order in orders) {
      print(order);
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
