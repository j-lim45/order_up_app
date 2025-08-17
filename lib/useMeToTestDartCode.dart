Future<void> createAnOrder() async {
  var order = await fetchOrder();

  print("$order has arrived!!!");
}

Future<String> fetchOrder() {
  return Future.delayed(Duration(seconds: 2), () => 'Uhhhh give me a large no 9');
}

main() async {
  print("Hello welcome to mcdonalds may i take your order?");
  createAnOrder();
  for (int i = 0; i < 10; i++) {
    await createAnOrder();
  }
  print("I guess were'd oen");
}

// Future<void> fetchUserOrder() {
//   // Imagine that this function is fetching user info from another service or database.
//   return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
// }

// void main() {
//   fetchUserOrder();
//   print('Fetching user order...');
// }