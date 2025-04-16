import 'package:dental_care/src/data/model/dental_service.dart';
import 'package:dental_care/src/data/model/dental_service_type.dart';

import '../model/dental_center.dart';

class Repository {
  get getDentalServiceItems {
    const List<DentalService> dentalServiceItems = [
      DentalService(
        id: 1,
        image: "assets/images/caovoirang.png",
        name: "Cạo vôi răng",
        type: DentalServiceTypeEnum.scaling,
      ),
      DentalService(
        id: 2,
        image: "assets/images/danhbongrang.png",
        name: "Đánh bóng răng",
        type: DentalServiceTypeEnum.scaling,
      ),
      DentalService(
        id: 3,
        image: "assets/images/tramrangsau.png",
        name: "Trám răng sâu",
        type: DentalServiceTypeEnum.cavityTreatment,
      ),
      DentalService(
        id: 4,
        image: "assets/images/xulytuyrang.png",
        name: "Xử lý tủy răng",
        type: DentalServiceTypeEnum.cavityTreatment,
      ),
      DentalService(
        id: 5,
        image: "assets/images/daurangkhon.png",
        name: "Đau răng khôn",
        type: DentalServiceTypeEnum.wisdomTooth,
      ),
      DentalService(
        id: 6,
        image: "assets/images/daurangkhon.png",
        name: "Răng khôn mọc lệch",
        type: DentalServiceTypeEnum.wisdomTooth,
      ),
      DentalService(
        id: 7,
        image: "assets/images/nhachu.png",
        name: "Điều trị nha chu",
        type: DentalServiceTypeEnum.periodontal,
      ),
      DentalService(
        id: 8,
        image: "assets/images/niengrang.png",
        name: "Niềng răng thưa",
        type: DentalServiceTypeEnum.orthodontics,
      ),
      DentalService(
        id: 9,
        image: "assets/images/niengrang.png",
        name: "Niềng răng móm",
        type: DentalServiceTypeEnum.orthodontics,
      ),
      DentalService(
        id: 10,
        image: "assets/images/niengrang.png",
        name: "Niềng răng hô",
        type: DentalServiceTypeEnum.orthodontics,
      ),
      DentalService(
        id: 11,
        image: "assets/images/rang-gia-thao-lap.png",
        name: "Răng tháo lắp",
        type: DentalServiceTypeEnum.prosthodontics,
      ),
      DentalService(
        id: 12,
        image: "assets/images/trong-implant.png",
        name: "Trồng răng Implant",
        type: DentalServiceTypeEnum.prosthodontics,
      ),
      DentalService(
        id: 13,
        image: "assets/images/tay-trang-rang.png",
        name: "Tẩy trắng răng",
        type: DentalServiceTypeEnum.cosmeticDental,
      ),
      DentalService(
        id: 14,
        image: "assets/images/boc-rang-su.png",
        name: "Bọc răng sứ",
        type: DentalServiceTypeEnum.cosmeticDental,
      ),
    ];


    return dentalServiceItems;
  }

  get getCategories {
    const List<DentalServiceType> categories = [
      DentalServiceType(type: DentalServiceTypeEnum.all, isSelected: true),
      DentalServiceType(type: DentalServiceTypeEnum.scaling, isSelected: false),
      DentalServiceType(
          type: DentalServiceTypeEnum.cavityTreatment, isSelected: false),
      DentalServiceType(
          type: DentalServiceTypeEnum.wisdomTooth, isSelected: false),
      DentalServiceType(
          type: DentalServiceTypeEnum.periodontal, isSelected: false),
      DentalServiceType(
          type: DentalServiceTypeEnum.orthodontics, isSelected: false),
      DentalServiceType(
          type: DentalServiceTypeEnum.prosthodontics, isSelected: false),
      DentalServiceType(
          type: DentalServiceTypeEnum.cosmeticDental, isSelected: false),
    ];


    return categories;
  }

  get getDentalCentersByProvince {
    final Map<String, List<DentalCenter>> dentalCentersByProvince = {
      'Hà Nội': [
        DentalCenter(
          name: 'Nha Khoa Trẻ',
          address: '38 P. Ngụy Như Kon Tum, Thanh Xuân, Hà Nội',
          openingHours: '08:00 - 20:00',
          hotline: '0963 333 844',
        ),
        DentalCenter(
          name: 'Nha Khoa Paris',
          address: '99 Nguyễn Khánh Toàn, Cầu Giấy, Hà Nội',
          openingHours: '09:00 - 18:00',
          hotline: '024-5678-9101',
        ),
      ],
      'TP. Hồ Chí Minh': [
        DentalCenter(
          name: 'Nha Khoa Kim',
          address: '45 Nguyễn Văn Trỗi, Phú Nhuận, TP.HCM',
          openingHours: '07:30 - 19:30',
          hotline: '028-2345-6789',
        ),
        DentalCenter(
          name: 'Nha Khoa Đông Nam',
          address: '123 Lý Thường Kiệt, Q.10, TP.HCM',
          openingHours: '08:00 - 18:00',
          hotline: '028-9876-5432',
        ),
      ],
      'Đà Nẵng': [
        DentalCenter(
          name: 'Nha Khoa Tâm An',
          address: '456 Hoàng Diệu, Hải Châu, Đà Nẵng',
          openingHours: '07:00 - 19:00',
          hotline: '0236-6543-2109',
        ),
      ],
      'Huế': [
        DentalCenter(
          name: 'Nha Khoa Kim',
          address: '45 Nguyễn Văn Trỗi, Phú Nhuận, TP.HCM',
          openingHours: '07:30 - 19:30',
          hotline: '028-2345-6789',
        ),
        DentalCenter(
          name: 'Nha Khoa Đông Nam',
          address: '123 Lý Thường Kiệt, Q.10, TP.HCM',
          openingHours: '08:00 - 18:00',
          hotline: '028-9876-5432',
        ),
      ],
      'Cần Thơ': [
        DentalCenter(
          name: 'Nha Khoa Tây Đô',
          address: '789 30/4, Ninh Kiều, Cần Thơ',
          openingHours: '08:30 - 20:30',
          hotline: '0292-1234-5678',
        ),
      ],
    };

    return dentalCentersByProvince;
  }

}
