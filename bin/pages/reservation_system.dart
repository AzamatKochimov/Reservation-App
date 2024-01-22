import 'dart:io';

import '../data/food.dart';
import '../models/food.dart';
import '../models/restaurant.dart';
import '../models/user.dart';

class ReservationSystem {
  Restaurant restaurant = Restaurant();
  User user = User();

  List<String> orders = [];
  String staffPassword = "password123";

  void displayWelcomeSpeech() {
    print(
        "\x1B[35m\x1B[1m \n \t\t🌟 Welcome to ${restaurant.name} - ${restaurant.brand}! 🌟\x1B[0m \n");
  }

  void enterUserInfo() {
    stdout.write("Enter your name: ");
    user.name = stdin.readLineSync()!;

    stdout.write("Enter your family name: ");
    user.family = stdin.readLineSync()!;

    while (true) {
      stdout.write("Enter your email: ");
      user.email = stdin.readLineSync()!;

      if (user.email.contains("@gmail.com")) {
        break;
      } else {
        print("Please enter a valid Gmail address.");
      }
    }
  }

  void displayMenu() {
    print("\x1B[36m\n \t\t\t ----- 🍽️ Menu ----- \x1B[0m");
    for (var i = 0; i < menu.length; i++) {
      print(" \t\t\t | ${i + 1}. ${menu[i].name} - \$${menu[i].price}");
    }
  }

  void displayRestaurantInfo() {
    print("\x1B[32m\n \t\t\t ------- 🏢 Restaurant Info --------------\x1B[0m");
    print(" \t\t\t |  Name: ${restaurant.name}");
    print(" \t\t\t |  Brand: ${restaurant.brand}");
    print(" \t\t\t |  Location: ${restaurant.location}");
    print(" \t\t\t |  Website: ${restaurant.website}");
    print("\x1B[32m \t\t\t -----------------------------------------\x1B[0m");
  }

  void displayStaffMenu() {
    print("\x1B[33m\n \t\t\t ------ 🛠 Staff Menu -------\x1B[0m");
    print(" \t\t\t | 1.👀 View Restaurant Menu");
    print(" \t\t\t | 2.👁 View Ordered Orders");
    print(" \t\t\t | 3.➕ Add Item to Menu");
    print(" \t\t\t | 4.💲 Change Price of Item");
    print(" \t\t\t | 5.📝 Edit Item in Menu");
    print(" \t\t\t | 6.🗑 Delete Item from Menu");
    print(" \t\t\t | 7.❌ Cancel Order");
    print(" \t\t\t | 8.🚪 Exit Staff Section");
    print("\x1B[33m \t\t\t ---------------------------\x1B[0m");
  }

  void run() {
    displayWelcomeSpeech();

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
          displayRestaurantInfo();
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
      displayMenu();

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
        "🎉 Order placed successfully! Total Cost: \$${totalCost.toStringAsFixed(2)}");

    stdout.write("Enter the number of people for the reservation: ");
    var numberOfPeople = int.parse(stdin.readLineSync()!);

    print("Reservation confirmed for $numberOfPeople people.");
  }

  void handleStaff() {
    stdout.write("Enter staff password 🔐:");
    var enteredPassword = stdin.readLineSync()!;

    if (enteredPassword == staffPassword) {
      while (true) {
        displayStaffMenu();

        stdout.write("Enter your choice: ");
        var staffChoice = int.parse(stdin.readLineSync()!);

        switch (staffChoice) {
          case 1:
            displayMenu();
            break;
          case 2:
            displayOrderedOrders();
            break;
          case 3:
            addItemToMenu();
            break;
          case 4:
            changePriceOfItem();
            break;
          case 5:
            editItemInMenu();
            break;
          case 6:
            deleteItemFromMenu();
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

  void addItemToMenu() {
    stdout.write("Enter the name of the new item: ");
    var itemName = stdin.readLineSync()!;

    stdout.write("Enter the price of $itemName: ");
    var itemPrice = double.parse(stdin.readLineSync()!);

    stdout.write("Enter the ingredients of $itemName: ");
    var itemIngredients = stdin.readLineSync()!;

    stdout.write("Enter the description of $itemName: ");
    var itemDescription = stdin.readLineSync()!;

    menu.add(Food(itemName, itemPrice, itemIngredients, itemDescription));

    print("\t\t\t $itemName added to the menu successfully!");
  }

  void changePriceOfItem() {
    displayMenu();
    stdout.write("Enter the item number you want to change the price for: ");
    var itemNumber = int.parse(stdin.readLineSync()!) - 1;

    if (itemNumber >= 0 && itemNumber < menu.length) {
      var food = menu[itemNumber];
      stdout.write("Enter the new price for ${food.name}: ");
      var newPrice = double.parse(stdin.readLineSync()!);

      food.price = newPrice;

      print("\t\t\t Price for ${food.name} updated successfully!");
    } else {
      print("\t\t\t Invalid item number. Please try again.");
    }
  }

  void editItemInMenu() {
    displayMenu();
    stdout.write("Enter the item number you want to edit: ");
    var itemNumber = int.parse(stdin.readLineSync()!) - 1;

    if (itemNumber >= 0 && itemNumber < menu.length) {
      var food = menu[itemNumber];

      stdout.write("Enter the new name for ${food.name}: ");
      var newName = stdin.readLineSync()!;
      food.name = newName;

      stdout.write("Enter the new price for $newName: ");
      var newPrice = double.parse(stdin.readLineSync()!);
      food.price = newPrice;

      stdout.write("Enter the new ingredients for $newName: ");
      var newIngredients = stdin.readLineSync()!;
      food.ingredients = newIngredients;

      stdout.write("Enter the new description for $newName: ");
      var newDescription = stdin.readLineSync()!;
      food.description = newDescription;

      print("\t\t\t $newName updated in the menu successfully!");
    } else {
      print("Invalid item number. Please try again.");
    }
  }

  void deleteItemFromMenu() {
    displayMenu();
    stdout.write("Enter the item number you want to delete: ");
    var itemNumber = int.parse(stdin.readLineSync()!) - 1;

    if (itemNumber >= 0 && itemNumber < menu.length) {
      var food = menu.removeAt(itemNumber);

      print("\t\t\t ${food.name} deleted from the menu successfully!");
    } else {
      print("Invalid item number. Please try again.");
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
