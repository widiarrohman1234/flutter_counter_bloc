class ProductMetaModel {
  final ProductMetaModelPagination? pagination;

  ProductMetaModel({
    this.pagination,
  });

  ProductMetaModel copyWith({
    ProductMetaModelPagination? pagination,
  }) {
    return ProductMetaModel(
      pagination: pagination ?? this.pagination,
    );
  }

  factory ProductMetaModel.fromMap(Map<String, dynamic> json) {
    return ProductMetaModel(
      pagination: json['pagination'] != null ? ProductMetaModelPagination.fromMap(Map<String, dynamic>.from(json['pagination'])) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pagination': pagination?.toMap(),
    };
  }
}

class ProductMetaModelPagination {
  final int page;
  final int pagesize;
  final int pagecount;
  final int total;

  ProductMetaModelPagination({
    required this.page,
    required this.pagesize,
    required this.pagecount,
    required this.total,
  });

  ProductMetaModelPagination copyWith({
    int? page,
    int? pagesize,
    int? pagecount,
    int? total,
  }) {
    return ProductMetaModelPagination(
      page: page ?? this.page,
      pagesize: pagesize ?? this.pagesize,
      pagecount: pagecount ?? this.pagecount,
      total: total ?? this.total,
    );
  }

  factory ProductMetaModelPagination.fromMap(Map<String, dynamic> json) {
    return ProductMetaModelPagination(
      page: json['page'],
      pagesize: json['pageSize'],
      pagecount: json['pageCount'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pagesize,
      'pageCount': pagecount,
      'total': total,
    };
  }
}
