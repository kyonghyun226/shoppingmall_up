import 'dart:io';

class Product {
  String name;
  int price;
  Product(this.name, this.price);
}

class ShoppingMall {
  List<Product> products = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];

  List<String> cart = []; // 장바구니 상품 이름
  int cartTotal = 0;

  void showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  void addToCart() {
    stdout.write('상품 이름을 입력해 주세요 !\n');
    String? name = stdin.readLineSync();
    stdout.write('상품 개수를 입력해 주세요 !\n');
    String? countInput = stdin.readLineSync();

    if (name == null || name.isEmpty || !products.any((p) => p.name == name)) {
      print('입력값이 올바르지 않아요 !');
      return;
    }
    int? count = int.tryParse(countInput ?? '');
    if (count == null) {
      print('입력값이 올바르지 않아요 !');
      return;
    }
    if (count <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
      return;
    }
    Product p = products.firstWhere((p) => p.name == name);
    cartTotal += p.price * count;
    for (int i = 0; i < count; i++) {
      cart.add(name);
    }
    print('장바구니에 상품이 담겼어요 !');
  }

  void showCartAndTotal() {
    if (cart.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
    } else {
      // 담긴 상품명 종류만, 중복 제거 없이 나열 (한글 요구에 맞춤)
      String productNames = cart.join(', ');
      print('장바구니에 $productNames가 담겨있네요. 총 ${cartTotal}원 입니다!');
    }
  }

  void showTotal() {
    print('장바구니에 ${cartTotal}원 어치를 담으셨네요 !');
  }

  void clearCart() {
    if (cart.isEmpty) {
      print('이미 장바구니가 비어있습니다.');
    } else {
      cart.clear();
      cartTotal = 0;
      print('장바구니를 초기화합니다.');
    }
  }
}

void main() {
  ShoppingMall mall = ShoppingMall();
  bool running = true;

  while (running) {
    print('-----------------------------------------------------------');
    print(
      '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 목록과 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화',
    );
    print('-----------------------------------------------------------');
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showCartAndTotal();
        break;
      case '4':
        print('정말 종료하시겠습니까?');
        String? confirm = stdin.readLineSync();
        if (confirm == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
          running = false;
        } else {
          print('종료하지 않습니다.');
        }
        break;
      case '6':
        mall.clearCart();
        break;
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}
