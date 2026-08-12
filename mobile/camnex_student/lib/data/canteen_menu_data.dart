import '../models/canteen_item.dart';

List<CanteenItem> canteenMenuItems = [
  CanteenItem(
    name: "Veg Burger",
    category: "Fast Food",
    price: 60,
    calories: 320,
    counter: "Main Counter",
    availableQty: 25,
    status: "Available",
  ),

  CanteenItem(
    name: "Cold Coffee",
    category: "Beverage",
    price: 80,
    calories: 180,
    counter: "Beverage Counter",
    availableQty: 15,
    status: "Available",
  ),

  CanteenItem(
    name: "French Fries",
    category: "Fast Food",
    price: 70,
    calories: 280,
    counter: "Main Counter",
    availableQty: 18,
    status: "Available",
  ),

  CanteenItem(
    name: "Pasta",
    category: "Italian",
    price: 120,
    calories: 400,
    counter: "Special Counter",
    availableQty: 10,
    status: "Low Stock",
  ),
];