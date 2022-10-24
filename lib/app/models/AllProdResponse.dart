
class AllProdResponse {
    List<Data>? data;
    String? msg;
    bool? success;

    AllProdResponse({this.data, this.msg, this.success});

    factory AllProdResponse.fromJson(Map<String, dynamic> json) {
        return AllProdResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null,
            msg: json['msg'],
            success: json['success'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['success'] = this.success;
        if (this.data != null) {
            data['data'] = this.data!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    String? category_name;
    ItemsInCategory? items_in_category;

    Data({this.category_name, this.items_in_category});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            category_name: json['category_name'],
            items_in_category: json['items_in_category'] != null ? ItemsInCategory.fromJson(json['items_in_category']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_name'] = this.category_name;
        if (this.items_in_category != null) {
            data['items_in_category'] = this.items_in_category!.toJson();
        }
        return data;
    }
}

class ItemsInCategory {
    List<DataX>? data;
    int? current_page;
    String? first_page_url;
    int? from;
    int? last_page;
    String? last_page_url;
    Object? next_page_url;
    String? path;
    int? per_page;
    Object? prev_page_url;
    int? to;
    int? total;

    ItemsInCategory({this.data, this.current_page, this.first_page_url, this.from, this.last_page, this.last_page_url, this.next_page_url, this.path, this.per_page, this.prev_page_url, this.to, this.total});

    factory ItemsInCategory.fromJson(Map<String, dynamic> json) {
        return ItemsInCategory(
            data: json['data'] != null ? (json['data'] as List).map((i) => DataX.fromJson(i)).toList() : null,
            current_page: json['current_page'],
            first_page_url: json['first_page_url'],
            from: json['from'],
            last_page: json['last_page'],
            last_page_url: json['last_page_url'],
            path: json['path'],
            per_page: json['per_page'],
            to: json['to'],
            total: json['total'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['current_page'] = this.current_page;
        data['first_page_url'] = this.first_page_url;
        data['from'] = this.from;
        data['last_page'] = this.last_page;
        data['last_page_url'] = this.last_page_url;
        data['path'] = this.path;
        data['per_page'] = this.per_page;
        data['to'] = this.to;
        data['total'] = this.total;
        if (this.data != null) {
            data['data'] = this.data?.map((v) => v.toJson()).toList();
        }



        return data;
    }
}

class DataX {
    int? brand_id;
    String? brand_name;
    int? category_id;
    String? category_ids;
    String? category_name;
    String? created_at;
    String? description;
    String? fullImage;
    int? id;
    String? image;
    int? incoming_stock;
    int? manufacturer_id;
    String? manufacturer_name;
    Object? meta_info;
    String? model_no;
    String? name;
    int? pharmacy_id;
    String? pharmacy_name;
    String? product_tags;
    int? status;
    int? total_stock;
    int? unit_price;
    String? updated_at;
    int? use_stock;

    DataX({this.brand_id, this.brand_name, this.category_id, this.category_ids, this.category_name, this.created_at, this.description, this.fullImage, this.id, this.image, this.incoming_stock, this.manufacturer_id, this.manufacturer_name, this.meta_info, this.model_no, this.name, this.pharmacy_id, this.pharmacy_name,  this.product_tags, this.status, this.total_stock, this.unit_price, this.updated_at, this.use_stock});

    factory DataX.fromJson(Map<String, dynamic> json) {
        return DataX(
            brand_id: json['brand_id'],
            brand_name: json['brand_name'],
            category_id: json['category_id'],
            category_ids: json['category_ids'],
            category_name: json['category_name'],
            created_at: json['created_at'],
            description: json['description'],
            fullImage: json['fullImage'],
            id: json['id'],
            image: json['image'],
            incoming_stock: json['incoming_stock'],
            manufacturer_id: json['manufacturer_id'],
            manufacturer_name: json['manufacturer_name'],
            name: json['name'],
            pharmacy_id: json['pharmacy_id'],
            pharmacy_name: json['pharmacy_name'],
            product_tags: json['product_tags'],
            status: json['status'],
            total_stock: json['total_stock'],
            unit_price: json['unit_price'],
            updated_at: json['updated_at'],
            use_stock: json['use_stock'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['brand_id'] = this.brand_id;
        data['brand_name'] = this.brand_name;
        data['category_id'] = this.category_id;
        data['category_ids'] = this.category_ids;
        data['category_name'] = this.category_name;
        data['created_at'] = this.created_at;
        data['description'] = this.description;
        data['fullImage'] = this.fullImage;
        data['id'] = this.id;
        data['image'] = this.image;
        data['incoming_stock'] = this.incoming_stock;
        data['manufacturer_id'] = this.manufacturer_id;
        data['manufacturer_name'] = this.manufacturer_name;
        data['name'] = this.name;
        data['pharmacy_id'] = this.pharmacy_id;
        data['pharmacy_name'] = this.pharmacy_name;
        data['product_tags'] = this.product_tags;
        data['status'] = this.status;
        data['total_stock'] = this.total_stock;
        data['unit_price'] = this.unit_price;
        data['updated_at'] = this.updated_at;
        data['use_stock'] = this.use_stock;



        return data;
    }
}

// class ProductCategory {
//     String created_at;
//     int id;
//     String name;
//     String parent_id;
//     String status;
//     String updated_at;
//
//     ProductCategory({this.created_at, this.id, this.name, this.parent_id, this.status, this.updated_at});
//
//     factory ProductCategory.fromJson(Map<String, dynamic> json) {
//         return ProductCategory(
//             created_at: json['created_at'],
//             id: json['id'],
//             name: json['name'],
//             parent_id: json['parent_id'],
//             status: json['status'],
//             updated_at: json['updated_at'],
//         );
//     }
//
//     Map<String, dynamic> toJson() {
//         final Map<String, dynamic> data = new Map<String, dynamic>();
//         data['created_at'] = this.created_at;
//         data['id'] = this.id;
//         data['name'] = this.name;
//         data['parent_id'] = this.parent_id;
//         data['status'] = this.status;
//         data['updated_at'] = this.updated_at;
//         return data;
//     }
// }
//
// class ProductManufacturer {
//     String created_at;
//     Object description;
//     int id;
//     String name;
//     String status;
//     String updated_at;
//
//     ProductManufacturer({this.created_at, this.description, this.id, this.name, this.status, this.updated_at});
//
//     factory ProductManufacturer.fromJson(Map<String, dynamic> json) {
//         return ProductManufacturer(
//             created_at: json['created_at'],
//             description: json['description'] != null ? Object.fromJson(json['description']) : null,
//             id: json['id'],
//             name: json['name'],
//             status: json['status'],
//             updated_at: json['updated_at'],
//         );
//     }
//
//     Map<String, dynamic> toJson() {
//         final Map<String, dynamic> data = new Map<String, dynamic>();
//         data['created_at'] = this.created_at;
//         data['id'] = this.id;
//         data['name'] = this.name;
//         data['status'] = this.status;
//         data['updated_at'] = this.updated_at;
//         if (this.description != null) {
//             data['description'] = this.description.toJson();
//         }
//         return data;
//     }
// }
//
// class ProductPharmacy {
//     String address;
//     String commission_amount;
//     String created_at;
//     String delivery_charges;
//     Object description;
//     String email;
//     String end_time;
//     String fullImage;
//     int id;
//     String image;
//     String is_shipping;
//     String lang;
//     Object language;
//     String lat;
//     String name;
//     String phone;
//     String start_time;
//     String status;
//     String updated_at;
//     String user_id;
//
//     ProductPharmacy({this.address, this.commission_amount, this.created_at, this.delivery_charges, this.description, this.email, this.end_time, this.fullImage, this.id, this.image, this.is_shipping, this.lang, this.language, this.lat, this.name, this.phone, this.start_time, this.status, this.updated_at, this.user_id});
//
//     factory ProductPharmacy.fromJson(Map<String, dynamic> json) {
//         return ProductPharmacy(
//             address: json['address'],
//             commission_amount: json['commission_amount'],
//             created_at: json['created_at'],
//             delivery_charges: json['delivery_charges'],
//             description: json['description'] != null ? Object.fromJson(json['description']) : null,
//             email: json['email'],
//             end_time: json['end_time'],
//             fullImage: json['fullImage'],
//             id: json['id'],
//             image: json['image'],
//             is_shipping: json['is_shipping'],
//             lang: json['lang'],
//             language: json['language'] != null ? Object.fromJson(json['language']) : null,
//             lat: json['lat'],
//             name: json['name'],
//             phone: json['phone'],
//             start_time: json['start_time'],
//             status: json['status'],
//             updated_at: json['updated_at'],
//             user_id: json['user_id'],
//         );
//     }
//
//     Map<String, dynamic> toJson() {
//         final Map<String, dynamic> data = new Map<String, dynamic>();
//         data['address'] = this.address;
//         data['commission_amount'] = this.commission_amount;
//         data['created_at'] = this.created_at;
//         data['delivery_charges'] = this.delivery_charges;
//         data['email'] = this.email;
//         data['end_time'] = this.end_time;
//         data['fullImage'] = this.fullImage;
//         data['id'] = this.id;
//         data['image'] = this.image;
//         data['is_shipping'] = this.is_shipping;
//         data['lang'] = this.lang;
//         data['lat'] = this.lat;
//         data['name'] = this.name;
//         data['phone'] = this.phone;
//         data['start_time'] = this.start_time;
//         data['status'] = this.status;
//         data['updated_at'] = this.updated_at;
//         data['user_id'] = this.user_id;
//         if (this.description != null) {
//             data['description'] = this.description.toJson();
//         }
//         if (this.language != null) {
//             data['language'] = this.language.toJson();
//         }
//         return data;
//     }
// }
//
// class ProductBrand {
//     String created_at;
//     int id;
//     String name;
//     String status;
//     String updated_at;
//
//     ProductBrand({this.created_at, this.id, this.name, this.status, this.updated_at});
//
//     factory ProductBrand.fromJson(Map<String, dynamic> json) {
//         return ProductBrand(
//             created_at: json['created_at'],
//             id: json['id'],
//             name: json['name'],
//             status: json['status'],
//             updated_at: json['updated_at'],
//         );
//     }
//
//     Map<String, dynamic> toJson() {
//         final Map<String, dynamic> data = new Map<String, dynamic>();
//         data['created_at'] = this.created_at;
//         data['id'] = this.id;
//         data['name'] = this.name;
//         data['status'] = this.status;
//         data['updated_at'] = this.updated_at;
//         return data;
//     }
// }
//
// class Link {
//     bool active;
//     String label;
//     String? url;
//
//     Link({this.active, this.label, this.url});
//
//     factory Link.fromJson(Map<String, dynamic> json) {
//         return Link(
//             active: json['active'],
//             label: json['label'],
//             url: json['url'] != null ? String?.fromJson(json['url']) : null,
//         );
//     }
//
//     Map<String, dynamic> toJson() {
//         final Map<String, dynamic> data = new Map<String, dynamic>();
//         data['active'] = this.active;
//         data['label'] = this.label;
//         if (this.url != null) {
//             data['url'] = this.url.toJson();
//         }
//         return data;
//     }
// }