abstract class ProductsEvent {
  const ProductsEvent();
}

class InitEvent extends ProductsEvent {
  const InitEvent();
}

class CreateItemEvent extends ProductsEvent {
  const CreateItemEvent();
}
