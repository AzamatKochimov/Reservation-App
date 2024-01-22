import 'dart:io';

import '../data/food.dart';
import '../models/food.dart';
import '../models/restaurant.dart';

class ReservationService {

  //! THIS IS WELCOME SPEECH
  static void displayWelcomeSpeech() {
    Restaurant restaurant = Restaurant();
    print(
        "\x1B[35m\x1B[1m \n \t\t🌟 Welcome to ${restaurant.name} - ${restaurant.brand}! 🌟\x1B[0m \n");
  }

  //! DISPLAY FOODS MENU
  static void displayMenu() {
    print("\x1B[36m\n \t\t\t ----- 🍽️ Menu ----- \x1B[0m");
    for (var i = 0; i < menu.length; i++) {
      print(" \t\t\t | ${i + 1}. ${menu[i].name} - \$${menu[i].price}");
    }
  }

  //! SHOW RESTAURANT INFO
  static void displayRestaurantInfo() {
    Restaurant restaurant = Restaurant();
    print("\x1B[32m\n \t\t\t ------- 🏢 Restaurant Info --------------\x1B[0m");
    print(" \t\t\t |  Name: ${restaurant.name}");
    print(" \t\t\t |  Brand: ${restaurant.brand}");
    print(" \t\t\t |  Location: ${restaurant.location}");
    print(" \t\t\t |  Website: ${restaurant.website}");
    print("\x1B[32m \t\t\t -----------------------------------------\x1B[0m");
  }

  //! DISPLAY STAFF MENU
  static void displayStaffMenu() {
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

  //! DELETING FROM MENU
  static void deleteItemFromMenu() {
    ReservationService.displayMenu();
    stdout.write("Enter the item number you want to delete: ");
    var itemNumber = int.parse(stdin.readLineSync()!) - 1;

    if (itemNumber >= 0 && itemNumber < menu.length) {
      var food = menu.removeAt(itemNumber);

      print("\t\t\t ${food.name} deleted from the menu successfully!");
    } else {
      print("Invalid item number. Please try again.");
    }
  }

  //! ADD ITEM
  static void addItemToMenu() {
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

  //! CHANGING THE PRICE OF FOOD
  static void changePriceOfItem() {
    ReservationService.displayMenu();
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

  //! EDITING ITEM MENU
  static void editItemInMenu() {
    ReservationService.displayMenu();
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

}