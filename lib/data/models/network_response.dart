class NetworkResponse{
  final int statusCode;
  final bool inSuccessFul;
  final dynamic responseData;
  final String? errorMessage;

  NetworkResponse({required this.statusCode, required this.inSuccessFul,  this.responseData,  this.errorMessage = 'Something Went Wrong\ntry again'});


}