import 'translations_key.dart' as key;

class Arabic {
  Map<String, String> get translations => {
        ///settings screen
        key.settings: 'الإعدادات',
        key.general: 'جنرال لواء',
        key.account: 'الحساب',
        key.myAccount: 'حسابي',
        key.welcome: 'مرحبا',
        key.language: 'اللغة',
        key.notifications: 'إشعارات',
        key.aboutUs: 'معلومات عنا',
        key.contactUs: 'اتصال نحن',
        key.appearance: 'ظهور',
        key.termsAndConditions: 'الأحكام والشروط',
        key.privacyPolicy: 'سياسة الخصوصية',
        key.returnAndExchange: 'العودة والاستبدال',
        key.faqs: 'أسئلة مكررة',
        key.selectLanguage: 'اختار اللغة',
        key.logout: 'تسجيل خروج',

        ///Login and register
        key.login: 'دخول',
        key.register: 'تسجيل',
        key.signIn: 'الدخول',
        key.signUp: 'تسجيل',
        key.loginGreetings:
            'تحيات! مرحبًا بك مرة أخرى! \ n سجّل الدخول إلى حسابك',
        key.forgotPassword: 'هل نسيت كلمة السر؟',
        key.donTHaveAccount: "ليس لديك حساب؟",
        key.send: "إرسال",
        key.verification: 'تأكيد الحقيقة',
        key.optional: 'اختياري',
        key.alreadyHaveAccount: 'هل لديك حساب!',

        ///bottom bar
        key.home: 'لوحة القيادة',
        key.categories: 'التصنيفات',
        key.deals: 'صفقات',
        key.menu: 'قائمة',
        key.myCart: 'عربة التسوق',

        ///buyer dashboard
        key.topCategories: 'أعلى الفئات',
        key.discountDeals: 'صفقات الخصم',
        key.seeAll: 'مشاهدة الكل',
        key.viewAll: 'مشاهدة الكل',
        key.viewMore: 'مشاهدة المزيد',

        ///buyer checkout
        key.orderSummary: 'ملخص الطلب',
        key.shippingDetails: 'تفاصيل الشحن',
        key.orderTime: 'وقت الطلب',
        key.expectedDelivery: 'توصيلة متوقعة',
        key.shipping: 'الشحن',

        ///vendor section
        key.vendorDashboard: 'لوحة معلومات البائع',
        key.vendorRegistration: 'تسجيل البائع',
        key.myOrders: 'طلباتي',
        key.myProducts: 'منتجاتي',
        key.recentOrders: 'الطلبيات الأخيرة',
        key.completedOrder: 'الطلبات المنجزة',
        key.processingOrders: 'أوامر المعالجة',
        key.userOrders: 'أوامر المستخدم',
        key.vendorOrders: 'أوامر البائعين',
        key.pendingOrders: 'أوامر معلقة',
        key.totalOrders: 'إجمالي الطلبات',
        key.deleteProd: 'حذف المنتج',

        ///profile
        key.profile: 'حساب تعريفي',
        key.personalInfo: 'معلومات شخصية',
        key.phone: 'هاتف',
        key.firstName: 'الاسم الاول',
        key.lastName: 'الكنية',
        key.address: 'تبوك',

        ///member ship
        key.membershipPlans: 'خطط العضوية',
        key.membershipDesc:
            'احصل على المزيد من الإيرادات ، وادعم المنتجات أو نماذج الأعمال الجديدة ، واقبل المدفوعات المتكررة على مستوى العالم',
        key.subscribeBtn: 'الإشتراك',
        key.subscribedBtn: 'مشترك',
        key.popular: 'شائع',

        /// general button or else texts
        key.searchIn: 'ابحث عن المنتج',
        key.active: 'فعال',
        key.order: 'ترتيب',
        key.checkout: 'الخروج',
        key.changeBtn: 'تغيير',
        key.updateBtn: 'تحديث',
        key.deleteBtn: 'حذف',
        key.confirm: 'يتأكد',
        key.set: 'تعيين',
        key.add: 'أضف',
        key.apply: 'يتقدم',
        key.addNew: 'إضافة جديد',
        key.total: 'المجموع',
        key.details: 'تفاصيل',
        key.sortBy: 'ترتيب حسب',
        key.filter: 'مصنف بواسطة',
        key.search: 'تفتيش',
        key.status: 'حالة',
        key.addNewAddress: 'إضافة عنوان جديد',
        key.confirmOrder: 'تأكيد الطلب',
        key.proceedToCheckOut: 'الشروع في الخروج',
        key.addProduct: 'أضف منتج',

        ///Form Validations
        key.storeName: 'اسم المحل',
        key.storeNameReq: 'اسم المحل مطلوب',
        key.description: 'تفصيل',
        key.descriptionReq: 'الوصف مطلوب',
        key.ownerName: 'اسم المالك',
        key.ownerNameReq: 'مطلوب اسم المالك',
        key.phoneReq: 'رقم الهاتف مطلوب',

        key.productName: 'اسم المنتج',
        key.productNameReq: 'اسم المنتج مطلوب',
        key.prodPrice: 'سعر المنتج',
        key.prodPriceReq: 'سعر المنتج مطلوب',
        key.prodStock: 'مخزون المنتج',
        key.prodStockReq: 'مخزون المنتج مطلوب',
        key.prodDiscount: 'تخفيض',
        key.prodDiscountReq: 'الخصم مطلوب',
        key.prodSku: 'المنتج SKU',
        key.prodSkuReq: 'مطلوب SKU',

        key.email: "بريد إلكتروني",
        key.emailReq: 'تنسيق البريد الإلكتروني غير صالح؟',
        key.password: 'كلمة المرور',
        key.passwordLengthReq: 'الرقم السري يجب الا يقل عن ستة احرف على الاقل؟',
        key.fullName: 'الاسم بالكامل',
        key.fullNameReq: 'الإسم الكامل ضروري',
        key.registerGreetings: 'قم بإنشاء حساب ISMMART!',
        key.otp: "OTP",
        key.otpReq: 'مطلوب OTP',
        key.newPassword: 'كلمة سر جديدة',
        key.newPassReq: 'مطلوب كلمة مرور جديدة',
        key.confirmPass: 'تأكيد كلمة المرور',
        key.confirmPassReq: 'تأكيد كلمة المرور مطلوب',
        key.passwordNotMatched: 'كلمة المرور غير متطابقة!',

        ///empty screens
        key.emptyCart: 'عربة التسوق فارغة',
        key.emptyCartMsg:
            'لم يتم إضافة أي عناصر إلى سلة التسوق الخاصة بك. الرجاء إضافة المنتج إلى عربة التسوق الخاصة بك',
        key.emptyProductSearch: 'لم يتم العثور على منتج بحث',
        key.emptyProductSearchMsg:
            "آسف! بحثك لم يطابق أي منتجات. حاول مرة اخرى",

        ///no data found
        key.noProductFound: 'لم تقم بإضافة منتجات بعد!',
        key.noOrderFound: 'ليس لديك أوامر حتى الآن!',
        key.noAddressFound: 'لم يتم العثور على عنوان',
        key.noDefaultAddressFound: 'لم يتم العثور على عنوان افتراضي',
        key.noCartItemFound: 'لم يتم العثور على عناصر سلة التسوق',
        key.noCategoryFound: 'لم يتم العثور على فئة',
        key.noSubCategoryFound: 'لم يتم العثور على فئات فرعية',
        key.noDataFound: 'لم يتم العثور على بيانات',

        ///with Params
        key.titleReq: "@title مطلوب",

        ///Errors and Messages
        key.errorTitle: "error",
        key.plzSelectSubCategory: 'الرجاء تحديد فئة فرعية',
        key.someThingWentWrong: 'هناك خطأ ما',
        key.delProdMsg: 'هل أنت متأكد أنك تريد حذف؟',
      };
}
