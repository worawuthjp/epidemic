class PhotoMap {
  int height;
  int width;
  String photoReference;

  PhotoMap(int height, int width, String photoReference) {
    this.height = height == null ? null : height;
    this.width = width == null ? null : width;
    this.photoReference = photoReference == null ? null : photoReference;
  }

}