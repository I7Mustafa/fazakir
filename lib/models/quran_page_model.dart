class QuranPageModel {
  List<PageData> page = [];
  QuranPageModel.fromjson(Map<String, dynamic> json) {
    json['data'].forEach((e) {
      page.add(PageData.fromjson(e));
    });
  }
}

class PageData {
  String? name;
  String? jza;
  String? haz;
  String? page;
  PageData.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    jza = json["jza"];
    haz = json["haz"];
    page = json["page"];
  }
}
