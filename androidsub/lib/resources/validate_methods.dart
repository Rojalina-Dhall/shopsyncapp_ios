
class ValidateMethods {
  String? validateImage(value) {
    if (value == null) {
      return "Please select an image"; // Error message if image is null
    }
    return null; // Return null if image is selected successfully
  }

  String? validateEmail(value) {
    // Regular expression for validating email address
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Check if the email is empty
    if (value.isEmpty) {
      return 'Email cannot be empty';
    }

    // Check if the email matches the regular expression
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null; // Return null if the email is valid
  }

  String? validateName(value) {
    // Check if the name is empty
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }

    // Check if the name contains only alphabetic characters and spaces (if needed)
    // This allows letters (both upper and lowercase) and spaces
    RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }

    // Check if the name is within a certain length (e.g., between 3 and 30 characters)
    if (value.length < 3 || value.length > 30) {
      return 'Name must be between 3 and 30 characters';
    }

    return null; // Returns null if the name is valid
  }

  String? validatePassword(value) {
    // Regular expression for validating password
    RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*\d).{8,}$', // Must contain at least one uppercase letter and one digit, and be at least 8 characters long
    );

    // Check if the password is empty
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }

    // Check if the password meets the required pattern
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must contain at least 8 characters, including an uppercase letter and a number';
    }

    return null; // Return null if the password is valid
  }

  String? validateCityName(value) {
    // Regular expression for validating city name
    RegExp cityNameRegExp = RegExp(
      r'^[a-zA-Z\s\-]+$', // Allows letters, spaces, and hyphens
    );

    // Check if the city name is empty
    if (value.isEmpty) {
      return 'City name cannot be empty';
    }

    // Check if the city name matches the regular expression
    if (!cityNameRegExp.hasMatch(value)) {
      return 'City name can only contain letters, spaces, and hyphens';
    }

    // Optionally, you can add length checks (e.g., minimum 2 characters)
    if (value.length < 2) {
      return 'City name must be at least 2 characters long';
    }

    return null; // Return null if the city name is valid
  }

  String? validateAddress(value) {
    RegExp addressRegExp = RegExp(r'^[A-Za-z0-9,]+$');

    // Check if the address is empty
    if (value.isEmpty) {
      return 'Address cannot be empty';
    }

    if (!addressRegExp.hasMatch(value)) {
      return 'Address must contain only numbers, letters and  comma';
    }
    return null;
  }

  String? validateZipCode(value) {
    RegExp ZipRegExp = RegExp(r'^\d+$');

    // Check if the zipcode is empty
    if (value.isEmpty) {
      return 'Zip Code cannot be empty';
    }

    if (!ZipRegExp.hasMatch(value)) {
      return 'Zip Code must contain only numbers';
    }
    return null;
  }

  // String? validateDescBox(value) {
  //   final int maxLines = RestroRegistration().lines;
  //   // Check if the description field is empty
  //   if (value.isEmpty) {
  //     return 'Description field cannot be empty';
  //   }

  //   // Split the value into lines and count them
  //   // int lineCount = '\n'.allMatches(value).length + 1; // Count number of lines

  //   if (value.toString().length > maxLines) {
  //     return 'Description should not exceed $maxLines lines';
  //   }

  //   return null;
  // }

  String? validatePrice(value) {
    // Check if the price field is empty
    if (value.isEmpty) {
      return 'Price field cannot be empty';
    }

    // Try to parse the value to a double
    final double? price = double.tryParse(value);

    // Check if the price is a valid number
    if (price == null) {
      return 'Please enter a valid price';
    }

    // Check if the price is greater than or equal to 0
    if (price <= 0) {
      return 'Price cannot be negative or 0';
    }

    // Optionally, check if the price has more than two decimal places
    if (price.toStringAsFixed(2) != value) {
      return 'Price can have a maximum of two decimal places';
    }

    return null;
  }

  // Validator for the "Small, Medium, Large" selection
  String? validatePriceType(value) {
    if (value == null || value.isEmpty) {
      return 'Please select a price type';
    }
    return null;
  }

// Validator for the "Small, Medium, Large" selection
  String? validateSizeOption(value) {
    if (value == null || value.isEmpty) {
      return 'Please select a size (Small, Medium, Large)';
    }
    return null;
  }

  // Validator for the "Half, Full" selection
  String? validateHalfFullOption(value) {
    if (value == null || value.isEmpty) {
      return 'Please select Half or Full';
    }
    return null;
  }

  // Validator for Price
  String? validatePriceOption(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    try {
      double.parse(value);
    } catch (e) {
      return 'Please enter a valid number for the price';
    }
    return null;
  }

  // Validator for category text field (only lowercase letters)
  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Category is required';
    }

    return null; // Valid input
  }

  // Confirm Password validation
  // Confirm Password validation
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password field cannot be empty';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}