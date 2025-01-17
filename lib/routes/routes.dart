class fRoutes {
  static const firstScreen = '/';
  static const secondScreen = '/secondScreen';
  static const secondScreenWithUID = '/secondScreenWithUID';

  static const login = '/login';
  static const forgetPassword = '/forgetPassword/';
  static const resetPassword = '/resetPassword';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const banners = '/banner';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const products = '/products';
  static const createProduct = '/createProduct';
  static const editProduct = '/editProduct';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static const customers = '/customers';
  static const createCustomer = '/createCustomer';
  static const customerDetails = '/customerDetails';

  static const orders = '/orders';
  static const ordersDetails = '/ordersDetails';

  static const responsiveDesignScreen = '/responsiveDesignScreen';
  static const desktop = '/desktop';

  static const coupons = '/coupons';
  static const profile = '/profile';
  static const settings = '/settings';

  static List sideMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    products,
    customers,
    orders,
    profile,
    settings,
    coupons,
    //firstScreen,
    //     secondScreen,
    //     responsiveDesignScreen
  ];
}
