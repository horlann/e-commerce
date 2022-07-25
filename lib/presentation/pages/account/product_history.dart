class ProductHistory {
  final String name;
  final int price;
  final int count;
  final String data;
  final String image;

  ProductHistory({
    required this.name,
    required this.price,
    required this.count,
    required this.data,
    required this.image,
  });
}

List<ProductHistory> product_list = [
  ProductHistory(
    data: '09/11/2022',
    image: "https://www.elfbar.com.ua/wp-content/uploads/2021/01/reverseside-5.jpg",
    name: 'ElfBar Banana Ice',
    price: 320,
    count: 50,
  ),
  ProductHistory(
    data: '11/12/2022',
    image: "https://www.elfbar.com.ua/wp-content/uploads/2021/01/reverseside-2.jpg",
    name: 'ElfBar Grape',
    price: 20,
    count: 1,
  ),
  ProductHistory(
    data: '02/11/2022',
    image: "https://www.elfbar.com.ua/wp-content/uploads/2021/01/reverseside-5.jpg",
    name: 'ElfBar Banana Ice',
    price: 320,
    count: 5,
  ),
  ProductHistory(
    data: '11/12/2022',
    image: "https://www.elfbar.com.ua/wp-content/uploads/2021/01/reverseside-2.jpg",
    name: 'ElfBar Grape',
    price: 200,
    count: 1,
  ),
];
