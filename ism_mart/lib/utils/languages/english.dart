import 'translations_key.dart' as key;

class English {
  Map<String, String> get translations => {
        ///authController
        key.currentUserNotFound: 'Current User not found',
        key.wrongWithCredentials: 'Something went wrong with credentials',

        ///email_input
        key.enterEmail: 'Enter Email To Receive OTP',
        key.emptyField: 'Empty field',
        key.free: "Free",

        ///reset_password
        key.enterDetails: 'Enter Details To Create New Password',

        ///sign_in
        key.passwordRequired: 'Password is required!.',
        key.nameAlphabaticReq: 'Alphabatics required only',

        ///checkout
        key.standard: "Standard",
        key.toProceedWithPurchase:
            'To proceed with your purchase, kindly note that the minimum order amount required is Rs 1000.',
        key.preferredPayment:
            'Please choose your preferred payment method to complete your order.',
        key.cartMustNotEmpty: 'Cart must not be empty',
        key.delivery: 'Delivery',
        key.daysCost: 'Days Cost',
        key.freeShipping: 'FREE SHIPPING ON ALL ORDERS ABOVE',
        key.zipCode: 'Zip Code',
        key.zipCodeRequired: 'Zip code required!',
        key.addressRequired: 'Address is required!',
        key.selectCountry: 'Select Country',
        key.chooseCountry: 'Choose Country',
        key.selectCity: 'Select City',
        key.chooseCity: 'Choose City',
        key.success: 'Success',
        key.disputeDeleted: 'Dispute deleted successfully',
        key.recordDoNotExist: 'Record do not exist',
        key.fileMustBe: 'Each file must be up to',
        key.invalidImageFormat: 'Invalid Image format!',
        key.minPriceShouldNotBe:
            'Min. Price should not be greater than Max. price!',
        key.plzSelectCountry: 'Please select country and city',
        key.shippingAddressDetail: 'Shipping address details',
        key.cashOnDelivery: 'Cash On Delivery (Not Available)',
        key.creditCard: 'Credit Card',
        key.wantToRedeem: 'Want to redeem',
        key.coins: 'coins',
        key.needMoreCoins: 'Need more Coins to redeem',
        key.subtotal: 'Subtotal',
        key.items: 'Items',
        key.shippingFee: 'Shipping Fee',
        key.inclusiveOfGst: 'Inclusive of GST',
        key.continueShopping: 'Continue Shopping',
        key.orderId: 'OrderID',
        key.paymentSuccessful:
            'Payment Successful!, You\'re Order has been Placed!',
        key.orderInformation: 'Order Information',
        key.orderNotCreated: 'Something went wrong! Order Not created',
        key.phoneValidate: 'Phone numbers should be in a format of 11 to 14 digits.',
        key.moreAboutCost: 'More about cost',
        key.feeChargesExplained: 'Fee charges Explained!',
        key.serviceFee: 'Service Fee',
        key.deliveryFee: 'Delivery Fee',
        key.supportCenter: '24/7 Support center',
        key.costDesc1 : 'We strive to keep our service and delivery fees as low as possible while still providing you with the best possible service.',
        key.costDesc2 : 'is a percentage-based fee that helps us cover the costs of maintaining our platform, ensuring quality control, and providing customer support. The service fee is only 5% on each product uploaded by our prestiogius vendor.',
        key.costDesc3 : 'The delivery fee is a flat fee that covers the cost of delivering your order to your location. The Delivery Fee is 250 Rupees only on each order.',
        key.costDesc4 : 'If you have any questions or concerns about our fees, please don\'t hesitate to reach out to our customer support team. Thank you for choosing our service!',

        ///sellerController
        key.imageSizeDesc: 'Image must be up to',

        ///singleCartItems
        key.availableStock: 'Available Stock',
        key.itemPrice: 'Item Price',
        key.features: 'Features',

        ///dashboard
        key.itemsFound: 'Items found',
        key.price: 'Price',
        key.minPrice: 'Min Price',
        key.maxPrice: 'Max Price',
        key.clear: 'Clear',
        key.lowToHigh: 'Low to High',
        key.highToLow: 'High to Low',
        key.OFF: 'OFF',

        ///SingleOrderDetailsUI
        key.orderDetail: 'Order Details',

        ///email_verification
        key.cancel: 'Cancel',
        key.emailVerificationLink: 'Enter Email To Receive Verification Link',

        ///DisputeDetailView
        key.id: 'Id',
        key.disputeDetail: 'Dispute Detail',

        ///AllDisputeView
        key.disputes: 'Disputes',

        ///setting
        key.frequentlyAsked: 'Frequently Asked Questions',
        key.forAnyQueryJust: 'For any support just send your query',
        key.youStoreHas: 'Your store has been disabled',

        ///products
        key.addToCart: 'Added to Cart',
        key.added: 'Added!',
        key.noQuestionFound: 'No questions found',
        key.productQuestions: 'Product Questions',
        key.askQuestion: 'Ask Question',
        key.peopleAlsoViewed: 'People Also Viewed',
        key.color: 'Color',
        key.size: 'Size',
        key.quantity: 'Quantity',
        key.next: 'Next',
        key.questionBody: 'Question body',
        key.storeDetail: 'Store Details',
        key.sellerRating: 'Seller Rating',
        key.customers: 'Customers',
        key.totalProducts: 'Total Products',
        key.soldItems: 'Sold Items',
        key.thisStoreHasBeen: 'This store has been open since',
        key.topProducts: 'Top Products',
        key.finalPriceWould: 'Final price would be Rs',
        key.afterPlatformFee: 'After platform fee of',
        key.yourDiscountShould:
            'Your discount should be between 10 and 90 percent. Please try again!',
        key.uploadImageLessThan: 'Upload images less than',
        key.outOfStock: 'Out of stock',
        key.productNotFound: 'Product Not Found',

        ///my_orders
        key.invoiceNo: 'INVOICE NO',
        key.billingDetails: 'Billing Details',
        key.qty: 'Qty',
        key.amount: 'Amount',
        key.action: 'Action',
        key.reviews: 'Reviews',
        key.rating: 'Rating',
        key.addDisputes: 'Add Disputes',
        key.deleteDisputes: 'Delete Disputes',
        key.deleteDisputesMsg: 'Are you sure you want to delete dispute?',
        key.disputeAlreadyAdded: 'Dispute Already Added',
        key.viewDispute: 'View Dispute',
        key.disputeNotAddedYet: 'Dispute Not Added Yet',
        key.paymentMethod: 'Payment Method',
        key.deliveryDate: 'Delivery Date',
        key.totalPrice: 'Total Price',
        key.claimCanBeMade:
            'Claims can be made only in the event of the loss or damage of a parcel',
        key.clickHereToUpload: 'Click Here To Upload',
        key.userOrderDispute: 'User Order Dispute',
        key.pending: 'Pending',
        key.accepted: 'Accepted',
        key.shipped: 'Shipped',
        key.delivered: 'Delivered',
        key.cancelled: 'Cancelled',

        ///profile
        key.gallery: 'Gallery',
        key.camera: 'Camera',
        key.pickFrom: 'Pick from',
        key.yourCoverAndProfile:
            'Your cover and profile must be a PNG or JPG, up to',
        key.updateVendorDetails: 'Update Vendor Details',
        key.fieldIsRequired: 'Field is required',

        ///faq
        key.q1: 'How does the ISMMART work?',
        key.q2: 'Can I cancel my subscription anytime?',
        key.q3: 'Which payment method you should accept?',
        key.q4: 'What are the benefits of using ISMMART affiliate?',
        key.q5:
            'What is fleet management and how is it different from dynamic scaling?',
        key.ans1:
            'The system will provide a virtual space/store to the sellers who wish to sell something to the market. They can be individual vendors, or some established brands who want to enhance their presence in the digital world. Our vendors will register themselves with us on some Monthly Subscription Charges/ Platform fees. We shall verify the authenticity of vendors by taking their basic information and prepare an agreement with them. Similarly our customers/buyers shall also be registered with us on our ecommerce store. The customers will be able to see the vendor profile, rate them (after getting services), make their purchases and keep themselves updated with the products in the market. For instance we have a vendor/store registered as Ali Electronics which deals with all kind of home appliances. Let say, Ayesha wants to buy an electric kettle and she upon searching finds her desired product on Ali Electronics. She will place her order and make her payment in advance which will be in Company’s Account until the order is completed. Ali Electronics will receive a notification about the order. He will pack the relevant product and will dispatch it through our service (Our defined courier services through our account). Once Miss Ayesha receives the product and verifies that she got the desired product, the payment will be released and will reach the vendor account in defined period of time (15 days).',
        key.ans2:
            'Yes. You can cancel your subscription anytime. Your subscription will continue to be active until the end of your current term (month or year) but it will not auto-renew. Unless you delete your account manually, your account and all data will be deleted 60 days from the day your subscription becomes inactive.',
        key.ans3:
            'Holistic engage sticky niche markets before collaborative collaboration and idea-sharing. Phosphorescently facilitate parallel applications with unique imperatives. Proactively plagiarize functionality deliverables via inexpensive solutions. Collaboratively embrace web-enabled intermediaries rather than diverse testing procedures.',
        key.ans4:
            'Continually impact seamless imperatives for best-of-breed best practices. Phosphorescently facilitate parallel applications with unique imperatives. Proactively plagiarize functionality deliverables via inexpensive solutions. Collaboratively embrace web-enabled intermediaries rather than diverse testing procedures.',
        key.ans5:
            'Distinctively initiate error-free channels with highly efficient ROI. Intrinsic envision world-class data via best-of-breed best practices. Efficiently enable empowered e-tilers after cross-unit services. Uniquely expedite seamless retailers via cooperative interfaces. Monotonically myocardial customer directed meta-services whereas error-free scenarios.',

        ///general
        key.call: 'call',
        key.centralHeadquarters: 'Central Headquarters',
        key.centralHeadquartersValue:
            '2nd Floor, Emirates Tower, M-13, F7 Markaz, Islamabad. Pakistan',
        key.globalHeadquarters: 'Global Headquarters',
        key.globalHeadquartersValue:
            'Tower 42, 25 Old Broad St, Cornhill, London, United Kingdom',
        key.privacyHeader1: '',
        key.privacyHeader2: 'Use of Your Personal information',
        key.privacyHeader3: 'What data we collect and how we collect it?',
        key.privacyHeader4: 'Information you provide:',
        key.privacyHeader5: 'Automatic information:',
        key.privacyHeader6: 'Information from other sources:',
        key.privacyHeader7: 'General data:',
        key.privacyHeader8: 'Profile data:',
        key.privacyHeader9: 'Log files:',
        key.privacyHeader10: 'Analytics:',
        key.privacyHeader11: 'Location information:',
        key.privacyHeader12: 'Cookies:',
        key.privacyHeader13: 'How secure is my information?',
        key.privacyHeader14: 'What information can I access?',
        key.privacyHeader15: 'Changes to this Privacy Policy',

        key.privacyBody1:
            '\t\t\tISMMART Stores respect your privacy and want to protect your personal information. This privacy statement aims to explain to you how we handle the personal data that we get from users of our platform or site and the services made available on the site. This policy also outlines your options for how your personal information will be collected, used, and disclosed. You agree to the procedures outlined in this Privacy Policy if you access this platform or site directly or through another website. Please read this Privacy Policy for more information. ISMMART Stores collect your personal data so that we can offer and constantly improve our products and services.',
        key.privacyBody2: '\t\t\tIn general, personal information you submit to us is used either to respond to requests that you make, aid us in serving you better, or market our services. We use your personal information in the following ways:'
            '\n\t• Take orders, deliver products, process payments, and communicate with you about orders, products and services, and promotional offerings. Update you on the delivery of the products;'
            '\n\t• Collect and use your personal information to comply with certain laws.'
            '\n\t• Operate, maintain, and improve our site, products, and services'
            '\n\t• Respond to comments and inquiries and provide customer service'
            '\n\t• Link or combine user information with other personal information we receive from third parties in order to better understand your needs and offer you better service'
            '\n\t• Develop, improve, and enhance marketing for products.'
            '\n\t• Identify you as a user in our system through your account/personal profile or other means.'
            '\n\t• Conduct automated decision-making processes in accordance with any of these purposes.'
            '\n\t• Verify and carry out financial transactions in relation to payments you make and audit the downloading of data from our site.'
            '\n\t\t\t We may store and process your personal information on servers located in various locations. We may also create anonymous data records from your personal information by completely excluding information that would otherwise make the data personally identifiable to you. We use this anonymous data to analyze request and usage patterns so that we may improve the content of our services and optimize site functionality.'
            '\n\t\t\t In addition to this, we reserve the right to share anonymous data with third parties and may use it for any purpose. Users who have had good experiences with our products and services may provide us with testimonials and remarks. We might publish such material. We may use our users’ first and last names to identify them when we post such content. Prior to publishing this data along with the testimonial, we will obtain the user’s consent.'
            '\n\t\t\t We will use this information for any other purpose to which your consent has been obtained; and to conduct automated decision-making processes in accordance with any of these purposes',
        key.privacyBody3: '',
        key.privacyBody4:
            'ISMMART Stores receive and store data you give us through your account profile when using our services.',
        key.privacyBody5:
            'When you use our services, we automatically gather and retain some types of information, including data on how you interact with the products, information, and services offered at ISMMART Stores. When your web browser or device accesses our website, we, like many other websites, utilise “cookies” and other unique identifiers to collect specific sorts of information.',
        key.privacyBody6:
            'ISMMART Stores may obtain information about you from other sources. For example, our carriers may provide us with updated delivery and address data, which we utilise to update our records and make it simpler to deliver your subsequent purchases.',
        key.privacyBody7:
            'Information will be automatically created when using our services. When you use our services, for instance, we may collect information about your general location, the kind of device you use, the Open Device Identification Number, the date and time of your visit, the unique device identifier, the type of browser you are using, the operating system, the Internet Protocol (IP) address, and the domain name. Generally speaking, we utilise this information to operate and enhance the site, as well as to ensure that you receive the most pertinent information possible.',
        key.privacyBody8:
            'Your username and password, orders related to you, your interests, preferences, feedback and survey responses.',
        key.privacyBody9:
            'As is true of most websites, we gather certain information automatically and store it in log files. This information includes IP addresses, browser type, Internet service provider (ISP), referring/exit pages, operating system, date/time stamp, and click stream data. We use this information to maintain and improve the performance services.',
        key.privacyBody10:
            'To better understand how people interact with the website, we employ analytics services, such as but not restricted to Google Analytics. Cookies are used by analytics services to collect data such as how frequently users visit the site, and we utilise this data to enhance our services and website. The terms of use and privacy policies of the analytics services, which you should consult for further information about how these companies use this information, place limitations on how they can use and distribute the information they gather.',
        key.privacyBody11:
            'If you have enabled location services on your devices, we may collect your location information to improve the services we offer. If you do not want this information collected, you can disable location services on your device.',
        key.privacyBody12:
            'Cookies are small pieces of information that a website sends to your computer’s hard drive while you are viewing the website. These text files can be used by websites to make the users experience more efficient. We may store these cookies on your device if they are strictly necessary for the operation of this site. For all other types of cookies we need your permission. To that end, this site uses different types of cookies. Some cookies are placed by third party services that appear on our pages. We and some third parties may use both session Cookies (which expire once you close your web browser) and persistent Cookies (which stay on your computer until you delete them) to provide you with a more personal and interactive experience on our services and to market our products. Marketing cookies are used to track visitors across websites. The intention is to display ads that are relevant and engaging for the individual user and thereby more valuable for publishers and third party advertisers. This tracking is done on an anonymous basis.',
        key.privacyBody13:
            'We consider your security and privacy when designing our solutions. By utilising encryption protocols and software, we try to keep the security of your personal information throughout transmission. When handling credit/debit cards / bank details, we adhere to best industry practices and keep customer personal information secure using physical, electronic, and procedural measures. Because of our security measures, we can require you to prove your identity before giving you access to personal data. It is important for you to protect against unauthorized access to your password and to your computers, devices, and applications. We recommend using a unique password for your account that is not used for other online accounts. Be sure to sign off when finished using a shared computer.',
        key.privacyBody14:
            'You can access your information, including your name, address, payment options, profile information and purchase history in the account section.',
        key.privacyBody15:
            'This Privacy Policy is effective as of 10th October 2022 and will remain in effect except with respect to any changes in its provisions in the future, which will be in effect immediately after being posted on this page. We reserve the right to update or change our Privacy Policy at any time and you should check this Privacy Policy periodically. \t Note: If you have any questions about this Privacy Policy, please contact us.',
        key.exchangeHeader1: '',
        key.exchangeHeader2: 'How to return?',
        key.exchangeBody1: '\tCustomer satisfaction is guaranteed!! We guarantee the quality of the products sold through ISMMART Stores, and if you are not happy with your purchase, we will make it right. With the exception of a few conditions listed below, any item purchased from ISMMART Stores may be returned within 14 calendar days from the date shipment is received.'
            '• Discounted goods/products cannot be exchanged or returned for a refund. It can be exchanged or returned only if an obvious flaw is found.'
            '\n• Items being returned must be unworn, in its original packaging, with all safety seals and labels still intact/attached. The return will not be qualified for a refund or exchange if these conditions are not met'
            '\n• ISMMart Stores reserve the exclusive right/ authority to make exceptions in some circumstances.'
            '\n• If an item is returned due to obvious error that comes into our returns policy, customer will not be charged for courier services.'
            '\n•t The return period for mobile phones, accessories, and other electrical and electronic products is only 5 calendar days beginning on the day the package is received. A replacement item will be given without charge if a flaw is found during the return window. Standard warranties from the manufacturer or supplier will be in effect after the return window has expired.',
        key.exchangeBody2:
            'Please get in touch with our customer support centre if an item meets all the requirements specified above.',

        ///memberShip
        key.discountMinValue: 'Discount should be greater or equal to 10',
        key.discountMaxValue: 'Discount should not be greater than 90',

        key.memPlan1Title: 'START',
        key.memPlan1Price: 'Free',
        key.memPlan1Desc1: 'Anyone can be registered as free members.',
        key.memPlan1Desc2: 'Can sell up to 3 Products on ISMMART platform.',
        key.memPlan1Desc3:
            'Will have only access to the products and stores to visit that are opened by default or kept opened by the Vendors & Businesses to visit.',
        key.memPlan1Desc4:
            'They can buy anything at their own as a direct customers with mutual understanding with the seller; ISMMART will not be responsible or back up in case of any issues in such deal.',

        key.memPlan2Title: 'PRO',
        key.memPlan2Desc1: 'A free one month trial',
        key.memPlan2Desc2: 'Can sell anything on ISMMART platform',
        key.memPlan2Desc3:
            'Will have access to all products and stores to visit.',
        key.memPlan2Desc4:
            'All deals by Premium Members on ISMMART will be backed up by ISMMART. We will be responsible for smooth transactions and delivery of products. ISMMART will guarantee to honor the mutual understanding that both Seller and Buyer have agreed upon.',
        key.memPlan2Desc5: 'Unlimited deliveries on eligible items.',
        key.memPlan2Desc6:
            'Premium Members will have worry less access to all businesses worldwide, both as a Seller & Buyer as ISMMART will be directly guaranteeing and verifying such members and any deals they do.',
        key.memPlan2Desc7:
            'As all Premium Members are scrutinized and are verified through ISMMART verification process, so all such members can do worry less trade with each other, anywhere in the World.',

        key.memPlan3Title: 'BUSINESS',
        key.memPlan3Desc1: '2 month free trial',
        key.memPlan3Desc2: 'B2B Opportunities',
        key.memPlan3Desc3: 'Unlimited free deliveries',
        key.memPlan3Desc4: 'Unlimited Promotional Tools',
        key.memPlan3Desc5: 'Wholesale shipping',
        key.memPlan3Desc6:
            'Get a chance to place products in our physical stores.',
        key.memPlan3Desc7: 'Unlimited deliveries on eligible items.',
        key.memPlan3Desc8:
            'Premium Members will have worry less access to all businesses worldwide, both as a Seller & Buyer as ISMMART will be directly guaranteeing and verifying such members and any deals they do.',
        key.memPlan3Desc9:
            'As all Premium Members are scrutinized and are verified through ISMMART verification process, so all such members can do worry less trade with each other, anywhere in the World.',

        key.exitApp: 'Exit App',
        key.exitDialogDesc: 'Are you sure you want to exit?',
        key.resetPass: 'Reset Password',

        ///settings screen
        key.settings: 'Settings',
        key.general: 'General',
        key.account: 'Account',
        key.myAccount: 'My Account',
        key.welcome: 'Welcome',
        key.language: 'Language',
        key.notifications: 'Notifications',
        key.aboutUs: 'About Us',
        key.contactUs: 'Contact Us',
        key.appearance: 'Appearance',
        key.termsAndConditions: 'Terms & Conditions',
        key.privacyPolicy: 'Privacy Policy',
        key.returnAndExchange: 'Return & Exchange',
        key.faqs: 'FAQs',
        key.selectLanguage: 'Select Language',
        key.logout: 'Log out',
        key.selectCurrency: 'Select Currency',
        key.currencyKey: "Currency",

        ///Login and register
        key.login: 'Login',
        key.register: 'Register',
        key.signIn: 'Sign In',
        key.signUp: 'Sign Up',
        key.loginGreetings: 'Greetings! Welcome back!\nSign in to your Account',
        key.forgotPassword: 'Forgot Password?',
        key.donTHaveAccount: "Don't have an Account?",
        key.send: 'Send',
        key.optional: 'Optional',
        key.verification: 'Verification',
        key.alreadyHaveAccount: 'Already have an Account!',

        ///bottom bar
        key.home: 'Home',
        key.categories: 'Categories',
        key.deals: 'Deals',
        key.menu: 'More',
        key.myCart: 'My Cart',

        ///buyer dashboard
        key.topCategories: 'Top Categories',
        key.discountDeals: 'Discount Deals',
        key.seeAll: 'See All',
        key.viewAll: 'View All',
        key.viewMore: 'View more',

        ///buyer checkout
        key.orderSummary: 'Order Summary',
        key.shippingDetails: 'Shipping Details',
        key.orderTime: 'Order Time',
        key.expectedDelivery: 'Expected Delivery',
        key.shipping: 'Shipping',
        key.shippingCost: 'Shipping Cost',

        ///vendor section
        key.vendorDashboard: 'Dashboard',
        key.vendorRegistration: 'Vendor Registration',
        key.myOrders: 'My Orders',
        key.myProducts: 'My Products',
        key.recentOrders: 'Recent Orders',
        key.completedOrder: 'Completed Orders',
        key.processingOrders: 'Processing Orders',
        key.totalEarning: 'Total Earning',
        key.cMonthEarning: 'Current Month Earning',
        key.pendingAmount: 'Pending Amount',
        key.wallet: 'Wallet',
        key.userOrders: 'User Orders',
        key.vendorOrders: 'Vendor Orders',
        key.pendingOrders: 'Pending Orders',
        key.totalOrders: 'Total Orders',
        key.goldCoins: 'Gold Coins',
        key.silverCoins: 'Silver Coins',

        key.deleteProd: 'Delete Product',
        key.selectCategory: 'Select Category',
        key.selectSubCategory: 'Select Sub Category',

        ///profile
        key.profile: 'Profile',
        key.vendorStoreDetails: 'Vendor Details',
        key.personalInfo: 'Personal Information',
        key.storeInfo: 'Store Information',
        key.phone: 'Phone',
        key.firstName: 'First Name',
        key.lastName: 'Last Name',
        key.address: 'Address',
        key.country: 'Country',
        key.city: 'City',
        key.deActivateMsg: 'Are you sure to de-activate your account?',

        key.bankDetails: 'Bank Details',
        key.bankName: 'Bank Name',
        key.bankNameReq: 'Bank name required!',
        key.bankAccount: 'Account Number',
        key.bankAccountReq: 'Bank Account Number Required',
        key.bankAccountHolder: 'Account Title',
        key.bankAccHolderReq: 'Account title required',

        ///contact us
        key.subject: 'Subject',
        key.subjectReq: 'Subject is required',
        key.message: 'Message',
        key.messageReq: 'Message body is required',

        ///member ship
        key.membershipPlans: 'Membership Plans',
        key.membershipDesc:
            'Capture more revenue, support new products or business models, and accept recurring payments globally.',
        key.subscribeBtn: 'Subscribe',
        key.subscribedBtn: 'Subscribed',
        key.popular: 'POPULAR',

        /// general button or else texts
        key.searchIn: 'What are you looking for?',
        key.active: 'Active',
        key.order: 'Order',
        key.checkout: 'Checkout',
        key.changeBtn: 'Change',
        key.updateBtn: 'Update',
        key.deleteBtn: 'Delete',
        key.deactivateBtn: 'Delete Account',
        key.confirm: 'Confirm',
        key.set: 'Set',
        key.yesBtn: 'Yes',
        key.noBtn: 'No',
        key.sold: 'Sold',
        key.submit: 'Submit',
        key.cancelBtn: 'Cancel',
        key.add: 'Add',
        key.apply: 'Apply',
        key.addNew: 'Add New',
        key.total: 'Total',
        key.details: 'Details',
        key.sortBy: 'Sort',
        key.sortByPrice: 'Sort By Price',
        key.filter: 'Filter',
        key.search: 'Search',
        key.status: 'Status',
        key.addNewAddress: 'Add new address',
        key.addPayment: 'Add Payment',
        key.confirmOrder: 'Confirm Order',
        key.proceedToCheckOut: 'Proceed To Checkout',
        key.addProduct: 'Add Product',
        key.redeemBtn: 'Redeem',

        ///Form Validations
        key.storeName: 'Store Name',
        key.storeNameReq: 'Store name is required',
        key.description: 'Description',
        key.descriptionReq: 'Description is required',
        key.ownerName: 'Owner Name',
        key.ownerNameReq: 'Owner name required',
        key.phoneReq: 'Phone is required',

        key.productName: 'Product Name',
        key.productNameReq: 'Product name required',
        key.prodPrice: 'Product Price',
        key.prodPriceReq: 'Price is required',
        key.prodStock: 'Product Stock',
        key.prodStockReq: 'Stock is required',
        key.prodDiscount: 'Discount',
        key.prodDiscountReq: 'Discount is required',
        key.prodSku: 'Product SKU',
        key.prodSkuReq: 'Product sku required',

        key.email: "Email",
        key.emailReq: 'Email is required!.',
        key.invalidEmail: 'Invalid Email Format?',
        key.password: 'Password',
        key.passwordLengthReq: 'Password must be at least 8 characters long?',
        key.fullName: 'Full Name',
        key.fullNameReq: 'Name is required',
        key.registerGreetings: 'Create an ISMMART Account!',
        key.otp: "OTP",
        key.otpReq: 'Otp is required',
        key.newPassword: 'New Password',
        key.newPassReq: 'New Password is required',
        key.confirmPass: 'Confirm Password',
        key.confirmPassReq: 'Confirm Password is required',
        key.passwordNotMatched: 'Password not matched!',
        key.titleKey: 'Title',
        key.titleReq: 'Title is required',
        key.updateProduct: 'Update Product',
        key.stock: 'Stock',

        ///empty screens
        key.emptyCart: 'Your cart is empty',
        key.emptyCartMsg:
            'No items have been added to your cart. Please add the product to your cart.',
        key.emptyProductSearch: 'No search product found',
        key.emptyProductSearchMsg:
            "Sorry! Your search didn't match any products \n please try again",

        ///no data found
        key.noProductFound: 'You have not added products Yet!',
        key.noOrderFound: 'You have no orders Yet!',
        key.noAddressFound: 'No address found',
        key.noDefaultAddressFound: 'No default address found',
        key.noCartItemFound: 'No Cart Item Found',
        key.noCategoryFound: 'No categories found',
        key.noSubCategoryFound: 'No Sub Categories Found',
        key.noDataFound: 'No data found',

        ///Errors and Messages
        key.errorTitle: "error",
        key.plzSelectSubCategory: 'Plz select Sub Category',
        key.someThingWentWrong: 'Something went wrong',
        key.delProdMsg: 'Are you sure to Delete this?',

        ///About US
        key.aboutHeader1: 'What is ISMMART?',
        key.aboutHeader2: 'Our Mission',
        key.aboutHeader3: 'Our Vision',
        key.aboutHeader4: 'How will the system work?',
        key.aboutHeader5: 'Refund Policy',
        key.aboutHeader6: 'What makes us Different?',
        key.aboutBody1:
            'ISMMART is an ecommerce platform providing a virtual space to sellers/vendors where they can advertise, market and sell their products or services. The concept of ISMMART was established when we saw a huge trust deficit between sellers and buyers. Considering that problem, we at Shaukat Marwat wanted to provide people with a reliable and trust worthy platform which will ensure utmost security of buyers’ money and services.',
        key.aboutBody2:
            'Our Mission is to bring a secure platform where sellers can connect with buyers without any hesitation. We aim to become one of its kind ecommerce stores where people can explore all kind of products and service under one platform. We also intent to create a forum which will enable thousands of individuals to have their own business and create more work force in the country.',
        key.aboutBody3:
            'Our vision is to bring a trustworthy store targeting global market and connecting businesses to bring them under one umbrella, as a unit.',
        key.aboutBody4:
            'The system will provide a virtual space/store to the sellers who wish to sell something to the market. They can be individual vendors, or some established brands who want to enhance their presence in the digital world. Our vendors will register themselves with us on some Monthly Subscription Charges/ Platform fees. We shall verify the authenticity of vendors by taking their basic information and prepare an agreement with them. Similarly our customers/buyers shall also be registered with us on our ecommerce store. The customers will be able to see the vendor profile, rate them (after getting services), make their purchases and keep themselves updated with the products in the market. For instance we have a vendor/store registered as Ali Electronics which deals with all kind of home appliances. Let say, Ayesha wants to buy an electric kettle and she upon searching finds her desired product on Ali Electronics. She will place her order and make her payment in advance which will be in Company’s Account until the order is completed. Ali Electronics will receive a notification about the order. He will pack the relevant product and will dispatch it through our service (Our defined courier services through our account). Once Miss Ayesha receives the product and verifies that she got the desired product, the payment will be released and will reach the vendor account in defined period of time (15 days).\nNote: Non Verified & Unregistered Members can only surf the products on ISMMART stores but are not allowed to trade. To ensure quality trading, all customers will need to register before any sale / purchase.\'',
        key.aboutBody5:
            'ISMMART Stores typically process returns within 3 business days once the courier returns the item to our Return Centre. Our customer service team will provide the shipping label as soon as they get your written complaint in accordance with the return policy. The item will be received, and the appropriate quality check will be done, before the refund is completed.\nPlease note that depending on the payment method, refund times can vary. It can take three to fourteen business days. Along with the money you paid for the returned product, the shipping cost is also repaid.\nFor example, when Ayesha receives the product, she finds it faulty. She will lodge a complaint at our complaint center, where we shall contact with the vendor for resolution. If her claim is proven right, she will return the faulty item back to the vendor, and her payment (which was kept on hold by ISMMART will be retrieved back to her. Some Products/Services will be nonrefundable and will be defined in the description of the product/service.',
        key.aboutBody6:
            'ISMMART is a unique platform which offers 100 percent security to both the buyer and the vendor. \nIt provides a virtual space to display, market and sell your products or services under one platform unlike stores that offer only products selling.\nFor buyers, it is an exclusive forum where they can shop with confident that their money will not be wasted. Our unique return policy ensures that no fraudulent activity happens with the buyer or seller. We have devised different subscription/membership offers for vendors of different categories.',

        ///Terms And Conditions
        key.tCHeader1: 'Introduction',
        key.tCBody1:
            'Welcome to ISMMART Stores, also hereby known as “we” and “us”. These terms and conditions govern your access to and use of our online platform/site, as well as any associated websites, apps, services, or resources. You acknowledge that you have read, understand, and agree to the terms and conditions listed below before using the ISMMART Stores. These terms and conditions may be changed, modified, added, or removed at any moment without previous notice by ISMMART Stores. If no further notification is given, changes become effective when they are posted on the website.',
        key.tCHeader2:
            'How the contract is formed between you and ISMMART Stores?',
        key.tCBody2:
            '• After placing an order, you will receive online notification from us acknowledging that we have received your order. Please note that this does not mean that your order has been accepted. Your order constitutes an offer to us to buy a product. All orders are subject to acceptance by us. The contract will only be formed when you receive the products ordered via this platform. \n • The contract will relate only to those Products which you receive. A contract for any other products which may have been part of your order will be formed when you receive those other.',
        key.tCHeader3: 'Your account',
        key.tCBody3:
            '• To access certain services offered by the platform, we may require that you create an account with us or provide personal information to complete the creation of an account.'
                '\n• You are responsible for maintaining the confidentiality of your user identification, password, account details and related private information. You acknowledge that you have this obligation to maintain the security of your account at all times and to take all reasonable precautions to prevent unauthorized use of your account. You should inform us immediately if you have any reason to believe that your password has become known to anyone else, or if the password is being, or is likely to be, used in an unauthorized manner. You understand and agree that any use of the website, any related services provided, and/or any access to confidential data, information, or communications made possible through the use of your account and password shall be deemed to have been made by you, or as the case may be, to have been made by someone authorized by you.'
                '\n• In case of breach or any serious violation of these terms and conditions, we reserve the right to invalidate the username and/or password after serving notice and providing reasonable time to rectify the same or make amends as per terms of this contract.',
        key.tCHeader4: 'Your status',
        key.tCBody4:
            'By placing an order through our site/platform, you warrant that:'
                '\n• you are legally capable of entering into binding contracts.'
                '\n• you are at least 18 years old.'
                '\n• you are not resident in a country where making a payment to our site, in line with these terms and conditions would breach any law.',
        key.tCHeader5: 'Delivery of Products',
        key.tCBody5:
            'In the case of products, your order will be fulfilled/made ready for receipt (as applicable) within a reasonable time of the date indicated at the time of ordering, unless there are exceptional circumstances.',
        key.tCHeader6: 'Warranty',
        key.tCBody6:
            'We warrant to you that any product purchased from us through our site will, on delivery, conform to its description, be of satisfactory quality, and be reasonably fit for all the purposes for which products of that kind are commonly supplied. All other warranties, conditions or terms relating to fitness for purpose, merchantability, satisfactory quality or condition whether implied by stature or common law are excluded in so far as permitted by law.',
        key.tCHeader7: 'Cancellation rights',
        key.tCBody7:
            '• In the case of products, if you are contracting as a consumer, you have a right to cancel your product order for any reason and receive a full refund. You will receive a full refund of the price paid for the products (excluding shipping costs). Your right to cancel a contract relating to the purchase of a product starts from the date when you receive the Product (when the contract is formed). If the products have been delivered to you, you may cancel at any time as per the Return Policy. In the event that you received a product that is damaged on delivery then please inform us in writing as soon as possible. If a product is returned to us damaged and you have not informed us that the product was damaged when you received it then we may refuse your right to cancel or receive.'
                '\n• You will not have any right to cancel a contract for the supply of any made-to-order or personalized products, periodicals or magazines, perishable goods, or software, DVDs or CDs which have had their security seal opened.'
                '\n• In the case of products, to cancel a contract, you must inform us in writing. If the products have been delivered to you, you must also return the products to us as soon as reasonably practicable, and at your own cost. You have a legal obligation to take reasonable care of the products while they are in your hands.',
        key.tCHeader8: 'Transfer of rights and obligations',
        key.tCBody8:
            '• We may transfer our rights and obligations under these terms and conditions to another organization, but that will not affect your rights or our obligations under the contract.'
                '\n• You may only transfer your rights and obligations under your contract with us if we agree to this in writing.',
        key.tCHeader9: 'Price',
        key.tCBody9:
            '• Price of the products and our delivery charges will be as quoted on our platform/site from time to time, except in cases of obvious.'
                '\n• Product prices include GST/FED/VAT, where applicable. However, if the rate of GST/FED/VAT changes between the date of your order and the date of delivery, we will adjust the price accordingly.'
                '\n• Product prices and delivery charges are liable to change at any time, but changes will not affect orders for products which you then take steps to fulfil/receive within a reasonable time.',
        key.tCHeader10: 'Refunds',
        key.tCBody10:
            'If an order is cancelled in accordance with paragraph 6 above, then we will refund the amounts owed in accordance with our Refund Policy.',
        key.tCHeader11: 'How we use your information?',
        key.tCBody11:
            'Please read the Privacy Policy for details on how we will use your information. By agreeing and accepting these terms and conditions you hereby agree and accept the terms of our Privacy Policy.',
        key.tCHeader12: 'Our liability to a Business',
        key.tCBody12:
            '• If we fail to comply with these terms and conditions, we shall only be liable to you for the purchase price of the products and not any losses that you will suffer as a result of our failure to comply (whether arising in contract, delict (including negligence), breach of statutory duty or otherwise).'
                '\n• We will not be liable for losses that result from our failure to comply with these terms and conditions that fall into the following categories even if such losses were in our contemplation as at the date that the contract constituted by these terms and conditions was formed between us of being a foreseeable consequence of our breach.'
                '\n• Loss of income or revenue.'
                '\n• Loss of business. '
                '\n• Loss of profits.'
                '\n• Loss of anticipated savings'
                '\n• Loss of data'
                '\n• Waste of management or office'
                '\nNote: This paragraph does not apply if you are contracting as a consumer.',
        key.tCHeader13: 'Our liability to a Consumer',
        key.tCBody13:
            '• If we fail to comply with these terms and conditions, we are responsible for loss or damage you suffer that is a foreseeable result of our breach of the terms and conditions or our negligence. Loss or damage is foreseeable if it was an obvious consequence of our breach or it was otherwise contemplated by you and us at the time we entered into the relevant.'
                '\n• We only supply the products to you for domestic and private use. You agree not to use the product for any commercial, business or re-sale purposes, and we have no liability to you for any loss of profit, loss of business, business interruption, or loss of business.'
                '\nNote: This paragraph does not apply if you are contracting as a business.',
        key.tCHeader14: 'Our contract with you if you are a Business',
        key.tCBody14: '• These terms and conditions and any document expressly referred to in them constitute the whole agreement between us and supersede all previous discussions, correspondence, negotiations, previous arrangement, understanding or agreement between us relating to the subject matter hereof.'
            '\n• We each acknowledge that, in entering into a contract, neither of us relies on, or will have any remedies in respect of, any representation or warranty (whether made innocently or negligently) that is not set out in these terms and conditions.'
            '\n• Each of us agrees that our only liability in respect of those representations and warranties that are set out in this agreement (whether made innocently or negligently) will be for breach of contract.'
            '\n• Nothing in this paragraph limits or excludes any liability.'
            '\nIf you are contracting as a consumer, this paragraph does not apply',
        key.tCHeader15: 'Our contract with you if you are a consumer',
        key.tCBody15:
            'If you are contracting as a consumer, we intend to rely upon these terms and conditions and any document expressly referred to in them in relation to the subject matter of any contract. While we accept responsibility for statements and representations made by our duly authorized agents, please make sure you ask for any variations from these terms and conditions to be confirmed in writing.'
                '\nNote: If you are contracting in the course of business, this paragraph does not apply.',
        key.tCHeader16: 'Notices',
        key.tCBody16:
            '• Any notice to be sent by you or by us in connection with these terms and condition can be sent by letter or by email. Notices to us should be sent to one of the following addresses:'
                '\n > 2nd Floor, Emirates Tower, F7 Markaz, Islamabad.'
                '\n > Email: businesses@shaukatmarwatgroup.com'
                '\n• We will send notices to you by email to the email address that you supplied at the time of signing up to our platform'
                '\n• Either of us can change the address for notices by telling the other in writing the new address, but the previous address will continue to remain valid for 7 days after the change is made.',
        key.tCHeader17: 'Third party rights',
        key.tCBody17:
            'A person who is not party to these terms and conditions or a contract shall not have any rights under or in connection with them.',
        key.tCHeader18: 'Waiver',
        key.tCBody18:
            'The failure of either party to exercise or enforce any right conferred on that party by these terms and conditions shall not be deemed to be a waiver of any such right or operate to bar the exercise or enforcement thereof at any time or times thereafter. No waiver by us of any of these terms and conditions will be effective unless it is expressly stated to be a waiver and is communicated to you in writing in accordance with paragraph 16 above.',
        key.tCHeader19: 'Severability',
        key.tCBody19:
            'If any court or competent authority decides that any of the provisions of these terms and conditions or any provisions of a contract are invalid, unlawful or unenforceable to any extent, the term will, to that extent only, be severed from the remaining terms, which will continue to be valid to the fullest extent permitted by law.',
        key.tCHeader20: 'Force majeure',
        key.tCBody20:
            'We reserve the right to defer the date of delivery or to cancel a contract for all circumstances beyond its reasonable control, including but not limited to any strike, lockout, disorder, fire, explosion, accident or stoppage of or affecting our business or work and which prevents or hinders the delivery of the goods or the performance of service.',
        key.tCHeader21: 'Law and jurisdiction',
        key.tCBody21: 'These terms and conditions and any dispute or claim arising out of or in connection with them or their subject matter or formation (including non-contractual disputes or claims) will be governed by Pakistan law. You should understand that by ordering any of our product, you agree to be bound by these terms and conditions.'
            '\nCategories for Registration:'
            '\n 1- Basic Membership- Free of Cost: Can be registered as free members.'
            '\n  • Cannot sell anything on ISMMART platform.'
            '\n  • Will have only access to the products and stores to visit that are opened by default or kept opened by the Vendors & Businesses to visit.'
            '\n  • They can buy anything at their own as a direct customers with mutual understanding with the seller; ISMMART will not be responsible or back up in case of any issues in such deal.'
            '\n 2- Premium Membership – Paid Membership:'
            '\n  • 5 USD per month with a free one month trial. Yearly subscription charges are 99.5 USD.'
            '\n  • Can sell anything on ISMMART platform. '
            '\n  • Will have access to all products and stores to visit.'
            '\n  • All deals by Premium Members on ISMMART will be backed up by ISMMART. We will be responsible for smooth transactions and delivery of products. ISMMART will guarantee to honor the mutual understanding that both Seller and Buyer have agreed upon.'
            '\n  • Premium Members will have worry less access to all businesses worldwide, both as a Seller & Buyer as ISMMART will be directly guaranteeing and verifying such members and any deals they do.'
            '\n  • As all Premium Members are scrutinized and are verified through ISMMART verification process, so all such members can do worry less trade with each other, anywhere in the World.'
            '\n  • Unlimited deliveries on eligible items.\n'
            '\nNote: All members (Sellers & Buyers) are requested to follow all trading rules and procedures mentioned by ISMMART to avoid any kind of inconvenience in payment or delivery. Commission Fee Structure Transaction value below PKR100,000/- ~ 0.5% Commission Transaction value above PKR100,000/- and below PKR250,00,00/- ~ 1.00% Commission Transaction value above PKR250,00,00/- but below PKR250,00,000/- ~ 1.75% Commission Transaction value above PKR250,00,000/- flat 2.25% Commission For any wholesale transaction a flat 3.5% Commission will be charged.'
            '\nNote: Transaction value excludes shipping and insurance cost.',
      };
}
