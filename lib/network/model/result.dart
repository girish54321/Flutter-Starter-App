enum LoadingStatus { loading, success, error }

class LoadingState<T> {
  final LoadingStatus status;
  final T? data;
  final String? errorMessage;

  LoadingState.loading()
      : status = LoadingStatus.loading,
        data = null,
        errorMessage = null;
  LoadingState.success(this.data)
      : status = LoadingStatus.success,
        errorMessage = null;
  LoadingState.error(this.errorMessage)
      : status = LoadingStatus.error,
        data = null;
}
