class SharedData {
  late Map<String, dynamic> userData,picData;
  void Function()? _listener;

  // Private constructor
  SharedData._privateConstructor();

  // Static instance variable for Singleton
  static final SharedData _instance = SharedData._privateConstructor();

  // Factory method to return the Singleton instance
  factory SharedData() {
    return _instance;
  }

  void setData(Map<String, dynamic> userData) {
    this.userData = userData;
    _notifyListeners(); // Notify listeners when data changes
  }
  void setPicData(Map<String,dynamic>picData) {
    this.picData = picData;  
    _notifyListeners();
  }
  
  

  Map<String, dynamic> getData() {
    return  userData;
  }
  Map<String, dynamic> getPicData() {
    return  picData;
  }
  

  // Method to add a listener
  void addListener(void Function() listener) {
    _listener = listener;
  }

  // Method to remove a listener
  void removeListener() {
    _listener = null;
  }
  void clearUserData() {
  userData = {};
  picData = {}; // Reset userData to an empty map
  removeListener(); // Remove the listener to prevent further updates
  _notifyListeners(); // Notify listeners that data has changed
}

  // Method to notify listeners
  void _notifyListeners() {
    if (_listener != null) {
      _listener!();
    }
  }
  
}
