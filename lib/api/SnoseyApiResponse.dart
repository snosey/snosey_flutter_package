enum SnoseyRequestState {
  Fetch,
  Error,
}

class SnoseyApiResponse {
  late bool success;
  SnoseyRequestState requestState;
  late String errorMessage;
  late String exceptionMessage;
  SnoseyPagination pagination = SnoseyPagination();
  dynamic objectResponse;

  SnoseyApiResponse({
    this.success = false,
    this.requestState = SnoseyRequestState.Fetch,
    this.errorMessage = "",
    this.exceptionMessage = "",
    this.objectResponse,
  });

  setStatus(Map<String, dynamic> json) {
    success = json['Success'] as bool;
    errorMessage = json['ErrorMessage'] as String;
    exceptionMessage = json['ExceptionMessage'] as String;
  }
}

class SnoseyPagination {
  bool hasPagination = false;
  int currentPage = 0;
  int totalPages = 0;
  int pageSize = 0;
  int totalCount = 0;
  bool hasPrevious = false;
  bool hasNext = false;
  String? prevPage = "";
  String? nextPage = "";

  set(Map<String, dynamic> json) {
    hasNext = json['HasNext'] as bool;
    hasPrevious = json['HasPrevious'] as bool;
    totalCount = json['TotalCount'] as int;
    pageSize = json['PageSize'] as int;
    totalPages = json['TotalPages'] as int;
    currentPage = json['CurrentPage'] as int;
    prevPage = json['PrevoisPageLink'] as String?;
    nextPage = json['NextPageLink'] as String?;
  }
}
