
import 'dart:convert';

class ResponseInfo {
    final int? count;
    final int? pages;
    final String? next;
    final String? prev;

    ResponseInfo({
        this.count,
        this.pages,
        this.next,
        this.prev,
    });

    ResponseInfo copyWith({
        int? count,
        int? pages,
        String? next,
        String? prev,
    }) => 
        ResponseInfo(
            count: count ?? this.count,
            pages: pages ?? this.pages,
            next: next ?? this.next,
            prev: prev ?? this.prev,
        );

    factory ResponseInfo.fromRawJson(String str) => ResponseInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseInfo.fromJson(Map<String, dynamic> json) => ResponseInfo(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}
