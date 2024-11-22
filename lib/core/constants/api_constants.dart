class ApiConstants {
  ApiConstants._();

  // Default Profile Picture
  static const String DEFAULT_PROFILE_PIC =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
  static const String DEFAULT_BOOK_PIC =
      "https://img.freepik.com/free-vector/man-running-book_1343-61.jpg?t=st=1732195077~exp=1732198677~hmac=fd435811d0f9e2d396078d4d1ec45bed7ff89459a71b50d9e23cbe7433c164e4&w=996";
  // Default Error Message
  static const String DEFAULT_ERROR_MESSAGE = 'An error occurred. Please try again later.';
  // Base URL
  static const String BASE_URL = 'https://assign-api.piton.com.tr/api/rest/';

  // Auth
  static const String SIGN_UP_URL = 'register';
  static const String SIGN_IN_URL = 'login';
  static const String GET_USER_URL = 'auth/get-user';

  // Categories
  static const String GET_CATEGORIES_URL = 'categories';

  // Books
  static const String GET_BOOKS_BY_CATEGORY_ID_URL = 'products';
  static const String GET_IMAGE_OF_BOOK_URL = 'cover_image';
}
