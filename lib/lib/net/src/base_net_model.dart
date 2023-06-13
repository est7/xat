/// It's a base class for all network models
mixin MyJsonSerializable<T> {
  T fromMyJson(Map<String, dynamic> json);
}
