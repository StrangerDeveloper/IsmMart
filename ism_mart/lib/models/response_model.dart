class ResponseModel{
  bool? success;
  String? message;
  dynamic data;

  ResponseModel({this.message, this.success,this.data});

  factory ResponseModel.fromResponse(response) => ResponseModel(
      success: response['success'],
      message: response['message'],
      data: response['data']
  );
}