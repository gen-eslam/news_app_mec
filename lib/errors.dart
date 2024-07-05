import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  const Failures({required this.errorMessage});
}

class LocalFailures extends Failures {
  LocalFailures({required super.errorMessage});
}

class ServerFailure extends Failures {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioError(DioException dioExceptionErrorType) {
    switch (dioExceptionErrorType.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: "Connection TimeOut");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: "receive Timeout");
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: "send Timeout");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioExceptionErrorType.response!.statusCode!,
            dioExceptionErrorType.response!);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: "Request was cancelled ");
      case DioExceptionType.unknown:
        if (dioExceptionErrorType.message!.contains("SocketException")) {
          return ServerFailure(errorMessage: "No Internet Connection");
        } else {
          return ServerFailure(
              errorMessage: "UnExpected Error , Please try again");
        }
      default:
        return ServerFailure(errorMessage: "Oops UnExpected Error ");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return ServerFailure(errorMessage: "Bad Request: ${response.data}");
      case 401:
        return ServerFailure(errorMessage: "Unauthorized: ${response.data}");
      case 402:
        return ServerFailure(
            errorMessage:
                "Payment Required: Payment is required to access this resource.");
      case 403:
        return ServerFailure(errorMessage: "Forbidden: ${response.data}");
      case 404:
        return ServerFailure(
            errorMessage: "Not Found: Your request was not found.");
      case 405:
        return ServerFailure(
            errorMessage:
                "Method Not Allowed: This HTTP method is not supported for this resource.");
      case 406:
        return ServerFailure(
            errorMessage:
                "Not Acceptable: The requested resource cannot produce the content in the format specified.");
      case 407:
        return ServerFailure(
            errorMessage:
                "Proxy Authentication Required: You must authenticate with the proxy server.");
      case 408:
        return ServerFailure(
            errorMessage:
                "Request Timeout: The server timed out waiting for the request.");
      case 409:
        return ServerFailure(
            errorMessage:
                "Conflict: There was a conflict with the current state of the resource.");
      case 410:
        return ServerFailure(
            errorMessage:
                "Gone: The requested resource is no longer available.");
      case 411:
        return ServerFailure(
            errorMessage:
                "Length Required: The 'Content-Length' header is missing or invalid.");
      case 412:
        return ServerFailure(
            errorMessage:
                "Precondition Failed: The server does not meet one of the preconditions specified in the request.");
      case 413:
        return ServerFailure(
            errorMessage:
                "Payload Too Large: The request payload exceeds the server's limits.");
      case 414:
        return ServerFailure(
            errorMessage:
                "URI Too Long: The request URI exceeds the server's limits.");
      case 415:
        return ServerFailure(
            errorMessage:
                "Unsupported Media Type: The media type of the request is not supported.");
      case 416:
        return ServerFailure(
            errorMessage:
                "Range Not Satisfiable: The requested range is not satisfiable.");
      case 417:
        return ServerFailure(
            errorMessage:
                "Expectation Failed: The server cannot meet the requirements of the 'Expect' header.");
      case 418:
        return ServerFailure(
            errorMessage: "I'm a Teapot: This request cannot be handled.");
      case 421:
        return ServerFailure(
            errorMessage:
                "Misdirected Request: The request was directed at a server that is not able to produce a response.");
      case 422:
        return ServerFailure(
            errorMessage:
                "Unprocessable Entity: The server understands the content type but cannot process the request.");
      case 423:
        return ServerFailure(
            errorMessage:
                "Locked: The resource is locked and cannot be accessed.");
      case 424:
        return ServerFailure(
            errorMessage:
                "Failed Dependency: The request failed due to a failed dependency.");
      case 425:
        return ServerFailure(
            errorMessage:
                "Unordered Collection: The server is unable to respond to the request.");
      case 426:
        return ServerFailure(
            errorMessage:
                "Upgrade Required: The client must upgrade to a newer protocol.");
      case 428:
        return ServerFailure(
            errorMessage:
                "Precondition Required: The server requires the request to be conditional.");
      case 429:
        return ServerFailure(
            errorMessage:
                "Too Many Requests: Please slow down and try again later.");
      case 431:
        return ServerFailure(
            errorMessage:
                "Request Header Fields Too Large: The request headers are too large.");
      case 451:
        return ServerFailure(
            errorMessage:
                "Unavailable For Legal Reasons: Access to this resource is denied for legal reasons.");
      case 500:
        return ServerFailure(
            errorMessage: "Internal Server Error: Please try again later.");
      case 501:
        return ServerFailure(
            errorMessage:
                "Not Implemented: The server does not support the functionality required to fulfill the request.");
      case 502:
        return ServerFailure(
            errorMessage:
                "Bad Gateway: The server received an invalid response from the upstream server.");
      case 503:
        return ServerFailure(
            errorMessage: "Service Unavailable: Please try again later.");
      case 504:
        return ServerFailure(
            errorMessage: "Gateway Timeout: Please try again later.");
      case 505:
        return ServerFailure(
            errorMessage:
                "HTTP Version Not Supported: The server does not support the HTTP protocol version.");
      case 506:
        return ServerFailure(
            errorMessage:
                "Variant Also Negotiates: The server has an internal configuration error.");
      case 507:
        return ServerFailure(
            errorMessage:
                "Insufficient Storage: The server is unable to store the representation needed to complete the request.");
      case 508:
        return ServerFailure(
            errorMessage:
                "Loop Detected: The server detected an infinite loop while processing the request.");
      case 510:
        return ServerFailure(
            errorMessage:
                "Not Extended: Further extensions to the request are required.");
      case 511:
        return ServerFailure(
            errorMessage:
                "Network Authentication Required: The client must authenticate with the network before accessing the resource.");
      default:
        return ServerFailure(
            errorMessage: "An unknown error occurred: Please try again.");
    }
  }
}
