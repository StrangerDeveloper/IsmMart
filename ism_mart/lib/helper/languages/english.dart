import 'translations_key.dart' as key;

class English {
  Map<String, String> get translations => {
        ///Welcome
        key.getOnboard: 'Get onboard',
        key.createYourAccount: 'Create your account',
        key.continueWithSameEmail: 'Continue with same email',
        key.continueWithDiffEmail: 'With different email',

        ///Add Update Address
        key.updateShippingAdd: 'Update Shipping Address',
        key.addShippingAdd: 'Add Shipping Address',

        ///change password
        key.currentPassword: 'Current Password is required',
        key.changePasswordDesc: 'Fill the following details to change password',

        ///answer_question_view
        key.addAnswer: 'Add Answer',
        key.viewProduct: 'View Product',
        key.answer: 'Answer',
        key.updateAnswer: 'Update Answer',
        key.deleteAnswer: 'Delete Answer',

        ///product_questions_view
        key.addQuestion: 'Add Question',

        ///single_product_view
        key.questions: 'Questions',
        key.updateQuestion: 'Update Question',
        key.deleteQuestion: 'Delete Question',
        key.deleteQuestionDialogDesc:
            'Are you sure you want to delete question?',
        key.question: 'Question',
        key.topVendors: 'Top Vendors',
        key.productVariant: 'Product Variants',
        key.productDetails: 'Product Details',
        key.weightAndDimension: 'Weight & Dimensions',

        ///errors
        key.serverUnableToHandle: 'server is unable to handle request',
        key.serverTakingTooLong: 'server is taking too long to respond',
        key.noInternetConnection: 'No internet connection',

        ///authController
        key.currentUserNotFound: 'Current User not found',
        key.wrongWithCredentials: 'Something went wrong with credentials',

        ///Delete Confirmation Dialog
        key.areYouSure: 'Are You Sure?',
        key.deletionProcessDetail:
            'Do you really want to delete this record? This process cannot be undone.',

        ///email_input
        key.enterEmail: 'Enter Email To Receive OTP',
        key.emptyField: 'Empty field',
        key.free: "Free",

        ///reset_password
        key.enterDetails: 'Enter Details To Create New Password',
        key.proceed: 'Proceed',

        ///sign_in
        key.passwordRequired: 'Password is required!.',
        key.nameAlphabaticReq: 'Only Alphabets required!',
        key.maxAddressLimitMsg:
            'Maximum address limit reached. Please Update/Delete address to proceed.',

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
        key.shippingAddressDetail: 'Shipping Address Details',
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
        key.phoneValidate: 'Phone numbers should be 7 to 16 digits long.',
        key.moreAboutCost: 'More about cost',
        key.feeChargesExplained: 'Fee charges Explained!',
        key.serviceFee: 'Service Fee',
        key.deliveryFee: 'Delivery Fee',
        key.supportCenter: '24/7 Support center',
        key.costDesc1:
            'We strive to keep our service and delivery fees as low as possible while still providing you with the best possible service.',
        key.costDesc2:
            'is a percentage-based fee that helps us cover the costs of maintaining our platform, ensuring quality control, and providing customer support. The service fee is only 5% on each product uploaded by our prestiogius vendor.',
        key.costDesc3:
            'The delivery fee is a flat fee that covers the cost of delivering your order to your location. The Delivery Fee is 250 Rupees only on each order.',
        key.costDesc4:
            'If you have any questions or concerns about our fees, please don\'t hesitate to reach out to our customer support team. Thank you for choosing our service!',

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
        key.emailVerification: 'Email Verification',
        key.emailVerificationLinkSent:
            'An Email Verification link has already been sent to your email',
        key.verifyEmail: 'Verify Email',

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
        key.height: 'Height',
        key.weight: 'Weight',
        key.width: 'Width',
        key.length: 'Length',
        key.weightIsReq: 'Weight is required',

        ///update_product
        key.productImageSection: 'Update Product Images',
        key.productThumbnail: 'Product Thumbnail',
        key.uploadThumbnail: 'Upload Thumbnail Image',
        key.productImages: 'Product Images',
        key.addedImages: 'Added Images',

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
        key.updateProfile: 'Update Account',
        key.pickImage: 'Pick Image',
        key.gallery: 'Gallery',
        key.camera: 'Camera',
        key.pickFrom: 'Pick from',
        key.yourCoverAndProfile:
            'Your cover and profile must be a PNG or JPG, up to',
        key.updateVendorDetails: 'Update Vendor Details',
        key.emailIsRequired: 'Email is required',
        key.passwordIsRequired: 'Password is required',
        key.passwordConfirmIsRequired: 'Confirm Password is required',
        key.fieldIsRequired: 'Field is required',
        key.isRequired: 'is required',
        key.shopNameReq: 'Shop name is required',
        key.shopAddressReq: 'Shop address is required',

        ///general
        key.call: 'call',
        key.centralHeadquarters: 'Central Headquarters',
        key.centralHeadquartersValue:
            'Plot No. 60, Street 12, G-8/1, Islamabad Capital Territory 44080 Pakistan',
        key.globalHeadquarters: 'Global Headquarters',
        key.globalHeadquartersValue:
            'Office 1005-1006, 10th Floor, Citadel Tower, Business Bay, Dubai',
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
            '\n\t\t\tWe may store and process your personal information on servers located in various locations. We may also create anonymous data records from your personal information by completely excluding information that would otherwise make the data personally identifiable to you. We use this anonymous data to analyze request and usage patterns so that we may improve the content of our services and optimize site functionality.'
            '\n\t\t\tIn addition to this, we reserve the right to share anonymous data with third parties and may use it for any purpose. Users who have had good experiences with our products and services may provide us with testimonials and remarks. We might publish such material. We may use our users’ first and last names to identify them when we post such content. Prior to publishing this data along with the testimonial, we will obtain the user’s consent.'
            '\n\t\t\tWe will use this information for any other purpose to which your consent has been obtained; and to conduct automated decision-making processes in accordance with any of these purposes',
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
        key.helpCenter: "Help Center",

        ///Login and register
        key.login: 'Login',
        key.register: 'Register',
        key.signIn: 'Sign In',
        key.signUp: 'Sign Up',
        key.loginGreetings: 'Greetings! Welcome back!\nSign in to your Account',
        key.forgotPassword: 'Forgot Password',
        key.forgotPasswordDesc:
            'Enter your email to receive an email\nwith the OTP Code.',
        key.donTHaveAccount: "Don't have an Account?",
        key.send: 'Send',
        key.optional: 'Optional',
        key.verification: 'Verification',
        key.alreadyHaveAccount: 'Already have an Account?',
        key.or: 'or',
        key.becomeAVendor: 'Become a vendor',
        key.joinOurMarketplace:
            'Join our marketplace and start selling your products today!',
        key.seamlessShopping: 'Enter details for seamless shopping experience',
        key.createAnAccount: 'Create an account',
        key.getOnboardUser: 'Get onboard as a user',
        key.phoneNumber: 'Phone Number',
        key.termsAndConditionsCheckbox:
            'By creating your account you have to agree with our terms & conditions.',
        key.frontSide: 'Front Side',
        key.frontSideReq: 'CNIC front side image is required',
        key.backSide: 'Back Side',
        key.backSideReq: 'CNIC back side image is required',
        key.chequeImage: 'Bank Cheque Image',
        key.chequeImageReq: 'Bank cheque image is required',
        key.storeLogoImage: 'Store Logo/Image',
        key.storeLogoImageReq: 'Store logo/image is required',
        key.business: 'Business',
        key.information: 'Information',
        key.vendorAccountCreation: 'Vendor Account Creation',
        key.vendorBankAccount: 'Vendor Bank Account',
        key.profileStatus: 'Profile Status',
        key.shopName: 'Store Name',
        key.enterStoreName: 'Enter Store Name',
        key.storeAddress: 'Store Address',
        key.enterShopAddress: 'Enter Store Address',
        key.ifAvailable: 'if available',
        key.enterNTNNumber: 'Enter NTN Number',
        key.storeNumber: 'Store Number',
        key.lessThanMb: 'Less than 2MB',
        key.chooseFile: 'Choose File',
        key.noFileChosen: 'No file chosen',
        key.waitForVerification: 'Wait for verification',
        key.vendor: 'Vendor',
        key.submitted: 'submitted',
        key.lastStep: 'Last Step',
        key.storeCountry: 'Store Country',
        key.storeCity: 'Store City',
        key.enterOwnerName: 'Your Owner Name',
        key.vendorCNIC: 'Vendor CNIC',
        key.enterCNIC: 'Enter CNIC',
        key.storeCategory: 'Store Category',
        key.yourStoreCategory: 'Your Store Category',
        key.storeDescription: 'Store Description',
        key.storeDescReq: 'Store description is required',
        key.enterStoreDescription: 'Enter Store Description',
        key.storeImage: 'Store Image',
        key.storeCoverImage: 'Store Cover Image',
        key.enterBankName: 'Enter Bank Name',
        key.enterAccountTitle: 'Enter Account Title',
        key.accountTitle: 'Bank Account Title',
        key.bankAccountNumber: 'Bank Account Number / IBAN',
        key.enterAccountNumberOrIban: 'Enter Account Number / IBAN',

        //onboard screen
        key.availAmazingDiscount: 'Avail amazing discounts',
        key.descriptionOfDiscount: 'Save big with 30% off on all our products!',
        key.celebrateFreedomAndSavings: 'Celebrate freedom and savings',
        key.descriptionOfFreedomAndSavings:
            'Exclusive offers for Independence Day!',
        key.boostYourBusiness: 'Boost your business with ISMMART',
        key.descriptionOfBoostYourBusiness:
            'Zero platform registration fee for vendors!',

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
        key.deActivateMsg: 'Are you sure you want to de-activate your account?',

        key.bankDetails: 'Bank Details',
        key.bankName: 'Bank Name',
        key.bankNameReq: 'Bank name is required',
        key.branchCode: 'Branch Code',
        key.bankAccountHolder: 'Account Title',
        key.bankAccHolderReq: 'Account title is required',
        key.FirstNameReq: 'First name is required',
        key.LastNameReq: 'Last name is required',
        key.incorrectBranchCode: 'Enter correct branch code',
        key.enterBranchCode: 'Enter branch code',
        key.bankAccountReq: 'Bank account number is required',
        key.incorrectAccOrIbanNo: 'Enter correct account number or IBAN',
        key.ibanReq: 'Enter correct IBAN',
        key.chequeImageNote:
            'This cheque image should have the same bank details visible as you mentioned above',
        // key.weightIsReq: 'Weight is required',
        key.enterCorrectWeight: 'Invalid value. Enter correct weight',
        // key.weight: 'Weight',
        // key.length: 'Length',
        // key.width: 'Width',
        // key.height: 'Height',

        ///Chatbot
        key.connectionError: 'Error establishing connection. Try again.',
        key.enableLocation: 'Enable Location.',
        key.locationAccessDenied: 'Location access denied',
        key.locationAccessPermanentlyDenied:
            'Location access permanently denied',
        key.couldNotGetLocation: 'Could not get location. Try again.',
        key.productExists: 'Product already exists',

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
        key.recentSearches: 'Recent Searches',

        ///Form Validations
        key.storeName: 'Store Name',
        key.storeNameReq: 'Store name is required',
        key.description: 'Description',
        key.descriptionReq: 'Description is required',
        key.ownerName: 'Owner Name',
        key.ownerNameReq: 'Owner name required',
        key.phoneReq: 'Phone number is required',
        key.incorrectAddress: 'Enter correct address',
        key.incorrectNTN: 'Enter correct NTN',
        key.incorrectCNIC: 'Enter correct CNIC',
        key.cnicReq: 'CNIC is required',
        key.categoryReq: 'Select Category',

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
        key.cityReq: 'Select City',
        key.countryReq: 'Select Country',

        key.email: "Email",
        key.emailReq: 'Email is required!.',
        key.invalidEmail: 'Invalid Email Format',
        key.password: 'Password',
        key.passwordLengthReq: 'Password must be at least 8 characters long!',
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
        key.updateInfoToProceed: 'Update information to proceed',

        ///Alert Message
        key.updateInfo: 'Update Information',
        key.updateInfoAlertMsg:
            'Our terms and conditions have been updated. To ensure a seamless business relationship, kindly tap on proceed',
        key.skip: 'Skip',

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
        key.tCHeader1: '',
        key.tCBody1: 'All of the references, forms, policies, and regulations detailed in these Terms, or available via the Platform or any connected hyperlink (collectively the "Terms"), govern your utilization of ISMMART Group of Industries (Private) Limited websites and mobile applications (hereafter referred to as the “Platform”). The "Services" our Platform provides include, but are not limited to, the Platform itself and all services provided by the Platform or by ISMMART which are accessible via the Platform. Additionally, all newly-added features included with the Services shall be subject to these Terms. They dictate the conditions for your utilization of the Services given by ISMMART.'
            '\nIt is important to give careful consideration to the terms of this agreement. Should you decide to access and utilize the platform, it will be understood that you have read, understood, and accepted the terms of this agreement as well as agreeing to the handling of your personal data in accordance with the terms set out in the Privacy Policy (https://ismmart.com/privacypolicy). Should you disagree with the conditions of the agreement, we kindly ask that you refrain from accessing or using the platform or its services.'
            '\nIndividuals who have attained the age of eighteen are authorized to utilize the Platform, as well as any existing corporate entities, such as companies. In instances where it is applicable, these Terms must be in accordance with local laws.'
            '\nAnyone under the age of 18 must get consent from their parent or legal guardian before they can use the Platform. By agreeing to these Terms, the parent or legal guardian will take responsibility for the actions and payments of the user. If consent has not been obtained, the user must cease using the Platform without delay.'
            '\nISMMART has the right to engage third parties to do ongoing Background Checks on you, and these can include investigations of any sanctions, legal disputes, or adverse news connected to you. If ISMMART does not approve of the Background Check results, your account may be cancelled and you may no longer be able to use the Platform.'
            '\nThe ISMMART retains the ability to amend these Terms (as well as any additional regulations or policies included on the Platform) at any given moment. It is suggested that you regularly look over the Terms, and by carrying on your utilization of the Platform after the date of the revised Terms being uploaded, you are assumed to have given consent to them, regardless of whether or not you have read them.'
            '\nPictures and visuals of the items exhibited on the Platform are exclusively for reference and may be diverse from the actual Goods.',
        key.tCHeader2: '1. ISMMART',
        key.tCBody2: '1.1. Who we are?'
            '\nDepending on the region of the world from which this Platform is utilized, the Terms of Agreement between you and ISMMART may vary.'
            '\n1.2. What we do?'
            '\nThrough our platform, ISMMART offers a link to different vendors so that customers may purchase a selection of goods, including ready-made meals, catering, beverages, raw ingredients, and various non-food items. When you make a purchase (referred to as an “order”), ISMMART works as an agent for the vendor, assisting in the order and subsequent delivery. Our vendors can either be third-party vendors, affiliates, or part of our own company. Where the vendor is third-party, we are licensed to receive payment and GST (if applicable to GST-registered vendors) on their behalf.'
            '\n1.3. How to contact us?'
            '\nOur customer support team is available to assist you through our customer support number or via the support@ismmartindustries.com email.',
        key.tCHeader3: '2. Use of the Platform and ISMMART Account',
        key.tCBody3: '2.1. In order to use ISMMART, you must create an account. During registration, you will be asked to enter some of your personal details, such as an email address, mobile number, and a private password. To buy something from the platform, you might be asked to provide your credit card details, depending on your payment method. It is essential that you keep your password a secret and that you are solely responsible for its safety. Unless the cause of fraud or abuse can be traced to something else, you are held accountable for all transactions made on your ISMMART account.'
            '\n2.2. ISMMART will not take responsibility for any Orders that have issues in delivery resulting from any incorrect, missing, or incomplete data provided by you. It is essential that all details be precise, authentic, and accurate for the efficient handling of the Order, particularly your delivery address and contact information.'
            '\n2.3. To remove your ISMMART account, please send us an email to ask for it. We may need to restrict, suspend, or end your account or using the Platform if we believe it is necessary.'
            '\n\t\t2.3.1. It appears that somebody other than you is utilizing your ISMMART account.'
            '\n\t\t2.3.2. If we suspect or find that you have participated in any actions or practices which go against these Terms, our policies and instructions, or are involved in something which we individually judge as misusing the Platform, then it shall be considered a violation.'
            '\n\t\t2.3.3. The continual failure to meet the standards of the Background Checks cannot be tolerated.',
        key.tCHeader4: '3. Restrictions',
        key.tCBody4: '3.1. Activities Prohibited on the Platform'
            '\nBelow is a short collection of activities that are either against the law or disallowed by ISMMART on its Platform. In case someone partakes in any of these disallowed activities, as determined solely by ISMMART, an inquiry will be conducted and legal action may be taken. Examples of the forbidden practices include, but are not limited to the following:'
            '\n\t\t3.1.1. The Platform cannot be used for any activity that goes against the local, state, or federal regulations, particularly any intention that is deceptive, fraudulent, or deceptive in nature.'
            '\n\t\t3.1.2. Posting any material that breaches the proprietary rights, private liberties, exposure rights, trade secret entitlements, or any other privileges of anyone.'
            '\n\t\t3.1.3. Posting any content that is viewed as unlawful, crude, slanderous, menacing, hostile, offensive, libelous, detestable, or mortifying to any individual or organization, as determined solely by ISMMART or in keeping with local norms.'
            '\n\t\t3.1.4. Publishing material that ISMMART has identified as cyberbullying, using their sole judgement.'
            '\n\t\t3.1.5. Posting of material that portrays risky and potentially life-threatening behavior is strictly prohibited.'
            '\n\t\t3.1.6. Refrain from sharing any individuals telephone numbers, street addresses, or last names.'
            '\n\t\t3.1.7. Submitting web links to external sites, as well as any kind of HTML or programming code, is not allowed.'
            '\n\t\t3.1.8. Posting anything that ISMMART views as "spam", as is solely determined by the company.'
            '\n\t\t3.1.9. Impersonating someone else while putting out content online.'
            '\n\t\t3.1.10. Obtaining information such as email addresses from others without authorization is not permitted.'
            '\n\t\t3.1.11 Not permitting any individual or entity to employ your authentication for displaying or viewing comments.'
            '\n\t\t3.1.12. harassing, threatening, stalking, or abusing any person on the Platform.'
            '\n\t\t3.1.13. Doing anything that would impede someone else from using or taking advantage of the Platform, or putting ISMMART, its clients, suppliers, or other parties in harms way, either in the opinion of ISMMART or otherwise, is strictly prohibited.'
            '\n\t\t3.1.14 Discouraging anyone from taking part in activities that are forbidden by these guidelines.'
            '\n3.2. ISMMART possesses the authority, although not obliged, to do one or more of the following'
            '\n\t\t3.2.1. Upon being made aware of any claim that any content on the Platform is not in accordance with these Terms, it shall be within the exclusive purview of the Platform to probe into the allegation and make the decision to either delete the content or demand that the content be taken down.'
            '\n\t\t3.2.2. All content which violates the Terms must be removed, including any content which is illegal, disruptive, or abusive.'
            '\n\t\t3.2.3. In the event of any violation of these Terms, we reserve the right to suspend or terminate a users access to the Platform or their ISMMART account.'
            '\n\t\t3.2.4. supervise, revise, or make public any material present on the Platform;'
            '\n\t\t3.2.5. The Platform has the right to edit or erase any content shared, regardless of whether it abides by these guidelines.',
        key.tCHeader5: '4. Intellectual Property',
        key.tCBody5:
            'All trademarks, logos, images, and service marks, including these Terms as displayed on the Platform or in our marketing material, whether registered or unregistered, are the intellectual property of ISMMART and/or third parties who have authorized us with their use (collectively, the “Trademarks”). You may not use, copy, reproduce, republish, upload, post, transmit, distribute, or modify these trademarks in any way without our prior express written consent. The use of the trademarks on any other website not approved by us is strictly prohibited. ISMMART will aggressively enforce its intellectual property rights to the fullest extent of the law, including criminal prosecution. ISMMART neither warrants nor represents that your use of materials displayed on the Platform will not infringe the rights of third parties not owned by or affiliated with ISMMART. Use of any materials on the platform is at your own risk.',
        key.tCHeader6: '5. Restrictions on Goods',
        key.tCBody6: '5.1. Our platform sells a range of products, a few of which are restricted by laws and regulations of the country from which they are bought. This may include an age restriction for cigarettes, tobacco, and other items which we can decline to provide based on the statutory standards active at that time. When you purchase these goods, you are confirming that you satisfy the legal qualifications to buy them.'
            '\n5.2 Cigarettes/Tobacco Products (“Tobacco”)'
            '\nWe may, where permitted by law, supply Tobacco on some of our Platforms. We are not trying to advance, support, or persuade the purchase or utilization of Tobacco in any capacity. Only people of the lawfully established age can buy Tobacco. ISMMART, the Vendor, and the delivery personnel have the authority to reject an order in their exclusive discretion.'
            '\n\t\t5.2.1. Before dispensing Tobacco, it is necessary to obtain proper documentation to verify age, such as an identification card.'
            '\n\t\t5.2.2. Proof of legal age must be presented in order to accept the delivery; failure to do so will result in refusal of delivery.'
            '\n\t\t5.2.3. No individual will be granted the delivery of any items, regardless of the rationale.'
            '\n\t\t5.2.4. Any proposal for Tobacco on the Platform will be deemed invalid in the event that it is illegal.',
        key.tCHeader7: '6. Orders',
        key.tCBody7: '6.1. Once an Order is placed through ISMMART, you will be provided with a confirmation email containing the Order receipt. This receipt will also cover any relevant delivery fees or taxes such as GST.'
            '\n6.2. Our Vendors require a set minimum order value to be reached before an Order can be completed and shipped to you. If an Order fails to meet the set minimum order value, you may choose to pay the remaining amount needed to fulfill the minimum order value, or add additional Goods to the Order.'
            '\n6.3. ISMMART and the Vendor will make every effort to honor your special instructions for an Order. Nonetheless, in situations where it is not feasible, plausible, or practical, ISMMART and/or the Vendor will proceed with creating the Order according to typical practices. Neither ISMMART nor the Vendor shall be obligated to compensate for or replace an Order that fails to meet the individual requests specified by you.'
            '\n6.4. ISMMART has no obligation to disclose the ingredients or allergens used in the Goods featured on the Platform. We do not ensure the Goods are allergen-free unless the law states otherwise. Therefore, those with allergies, adverse reactions to certain foods, or particular dietary needs must consult with the Vendor before making a purchase on our Platform.'
            '\n6.5. It is imperative to remember that your Order could be subjected to extra stipulations given by the Vendor.'
            '\n6.6. Prior to placing the Order'
            '\n\t\t6.6.1. To be able to view Vendors available for delivery in your area, it is essential for you to provide the delivery address.'
            '\n\t\t6.6.2. After you choose a Vendor, you will be guided to their menu page, from which you can choose and add the desired products to the cart.'
            '\n6.7. Placing the Order'
            '\n\t\tTo successfully place an Order, kindly observe the prompts displayed when you press "Checkout". You might have to offer extra information in order for us to conclude the Order. Ensure that all the information given, including the costs, delivery particulars, personal particulars, payment data, and voucher codes (if pertinent) are precise, accurate, and finished before you hit “PLACE ORDER”. When you get an email acknowledgment having your Order receipt from us, you will have successfully placed your Order.'
            '\n6.8. Cancelling an Order'
            '\n\t\tTo withdraw your Order once it has been submitted, visit the Assistance Centre on the Platform. If the Vendor has not yet accepted the Order, you may still exercise your right to cancel.'
            '\n6.9. Refunds'
            '\n\t 6.9.1. Online Payment Orders'
            '\n\t\tYou may be granted a refund if you cancel your Order before it has been accepted by the Vendor; yet, if the Vendor has already accepted your Order and you decide to cancel, you will not receive a refund in whole or in part and you will forfeit the delivery of your cancelled Order.'
            '\n\t 6.9.2. Cash-on-Delivery Orders'
            '\n\t\tYour ability to cancel your Order is limited to those orders that have not been accepted by a Vendor. If you opt to withdraw an Order that has been approved, you are not eligible for any cash-on-delivery reimbursements and delivery of your cancelled Order is also forfeited. This particular refund option does not apply when working with our affiliate delivery partners.'
            '\n\t\tBefore processing any type of refund, we may need to request extra information or documents that serve as proof of a physical receipt of accepted Orders. Should you fail to provide us with the asked details or records, we have the right to reject the request for the refund.'
            '\n\t\tIn the event that you do not get the refund, we recommend that you double-check your bank account, get in touch with your bank or credit card company, as it can take some time for the amount to be refunded. If the previously mentioned methods are followed and you still do not get the refund, please get in touch with our customer support team using one of the communication methods in Clause 1.3.'
            '\n6.10. If ISMMART has a good faith belief that there has been fraudulent activity connected to your ISMMART account, your Order, or both, it reserves the right to cancel any Order, suspend, deactivate, or terminate your ISMMART account.',
        key.tCHeader8: '7. Prices and Payments',
        key.tCBody8: '7.1. The rates stated on the Platform shall be given in local money, with any required tax included. You acknowledge that the charges and proposals on the Platform could be distinct from the costs and deals available from our Suppliers in other locations (like their own websites, mobile apps, or physical stores).'
            '\n7.2. The prices of the Goods that we show on our Platform can fluctuate contingent on the Vendor, and, if required by applicable legislation, they can also differ.'
            '\n\t\t7.2.1. Vendors who are registered with the Goods and Services Tax shall be required to include such tax, or any other applicable equivalent.'
            '\n\t\t7.2.2 For Vendors who have not registered for the Goods and Services Tax, no such taxes are to be included.'
            '\n7.3. For every Order placed, a delivery fee will be incurred unless the following conditions are met'
            '\n\t\t7.3.1. you have a valid promotional or discount voucher and apply it at checkout; or'
            '\n\t\t7.3.2. it is stated otherwise.'
            '\n7.4.  At the time of placing each order, the prices and other fees (such as delivery, minimum order or service fees) as displayed on the Platform may be subject to variation.'
            '\n7.5. Before confirming the checkout, you will be given an overview of the prices, delivery fees, and other related costs. Once you place the order, you agree to the totals as well as the extra fees, all of which have been provided for you.'
            '\n7.6. You are given the choice of several payment options when paying for an Order through the Platform, such as Master Card, Visa Card, or Cash-on-Delivery.'
            '\n7.7. Your ISMMART account can provide a way to cover some or all of the expenses for your order, should there be any available credits or valid promotional or discount vouchers.'
            '\n7.8. After an Order is successfully placed, you will receive an email confirmation from us with your Order receipt.'
            '\n7.9. Payment Methods: ISMMART holds the authority to present more payment methods and/or withdraw current payment systems whenever it decides. When you opt to pay via a web payment system, the remittance will be managed by our third-party payment supplier(s). Upon your agreement, your credit card / payment information will be kept with our third-party payment supplier(s) for potential transactions. ISMMART does not store any of your credit card or payment information.'
            '\n7.10 To ensure a successful payment of your Order, please make sure that you have enough money available on your debit or credit card. If needed, ISMMART is responsible for all payments on our Platform, including returns, chargebacks, annulments, and resolving any disputes as long as they are fair and in line with the terms and conditions of our website.',
        key.tCHeader9: '8. Delivery and Partner Delivery',
        key.tCBody9: '8.1. Delivery Areas'
            '\n\t It is clear that our Vendors range of Goods is specific to each delivery area, and they differ from area to area. If you enter your delivery address in the Platform, you can check out the Vendors that are available to you then. Note that delivery areas are subject to change due to the effects of weather, traffic, and force majeure.'
            '\n8.2. Delivery Time'
            '\n\t ISMMART shall deliver your Order to the given address. We will send an approximate delivery date to your email; however, due to external factors that we are unable to control (e.g. quantity of order, location, time of day, weather conditions, traffic conditions, etc.), the actual delivery time may differ from the estimate. We recommend that either you or someone you trust is present at the delivery location when the Order arrives. In the event that the Order contains Tobacco (if applicable) and the recipient is below the legal age or fails to provide proper identification, ISMMART has the right to refuse delivery.'
            '\n8.3. Unsuccessful or Failed Deliveries'
            '\n\t 8.3.1. Despite any other stipulations present in these Terms, in the event that we make an effort to furnish an Order, yet, are unsuccessful due to conditions induced by you, for example, but not restricted to:'
            '\n\t\t(i) no one was present or available to receive the Order;'
            '\n\t\t(ii) customer was uncontactable despite attempts to reach the customer via the phone number provided;'
            '\n\t\t(iii) lack of appropriate or sufficient access to deliver the Order successfully;'
            '\n\t\t(iv) lack of a suitable or secure location to leave the Order; or'
            '\n\t\t(v) in the case of Restricted Goods, customer did not meet the statutory age requirements or delivery did not deem it safe or appropriate for the customer to receive the Restricted Goods.'
            '\n\t\tISMMART holds the privilege of canceling the order without granting you a reimbursement or solution if contact with you is unsuccessful via means such as a call, message, or email to inform of delivery issues and the following measures.'
            '\n\t 8.3.2. No-show Cancellations'
            '\n\t\tIn the event of your unavailability or incapability of receiving the Order within a span of 10 minutes of it arriving at the delivery address, ISMMART will be authorized to cancel the Order without offering any reimbursement or alternative.'
            '\n8.4. Wrong Order, Missing Items, Defective Goods'
            '\n\t If after receiving your Order, it is found that there are issues (e.g., incorrect order, defective order, or missing items), kindly reach out to our customer support using one of the available communication methods mentioned in Clause 1.3 of our policy. On some occasions, ISMMART may require photographic evidence and further details to completely analyze the issue with your order. Should it be established that the order and/or products delivered are of subpar condition or quality, we will give compensation for the order or some of its elements.'
            '\n8.5. Partner Delivery'
            '\n\t At times, orders may be delivered to you through one of our partners (“Partner Delivery”). Although we do our best to give you prior warning regarding partner delivery, that might not always be achievable. When partner delivery is utilized, you might be requested to get in touch with the partner directly if there are issues or hold-ups with your delivery. ISMMART will not be liable in any way for orders or products delivered by partners.',
        key.tCHeader10: '9. Vouchers, Discounts and Promotions',
        key.tCBody10: '9.1. ISMMART occasionally launches marketing and promotional activities featuring voucher codes, discounts, and other offers for the Platform (referred to as "Vouchers"). Vouchers come with time limits, redemption windows, use limits, availability, and other criteria.'
            '\n9.2. Vouchers cannot be combined with other deals, discounts, or coupons for use.'
            '\n9.3. Unless there is a stipulation that suggests otherwise, Vouchers may only be used within our Platform.'
            '\n9.4. Vouchers are neither transferrable nor exchangeable, non-refundable, and can not be exchanged for any type of monetary compensation.'
            '\n9.5. ISMMART reserves the right to make changes to any relevant conditions regarding the Vouchers without prior warning. They may even revoke, discontinue, or decline the use of a Voucher without advance notice.'
            '\n9.6. At any point in time, ISMMART may, completely at their discretion, choose to void, reject, and/or bar you or particular Vendors from using Vouchers without previous notification.',
        key.tCHeader11:
            '10. Representations, Warranties and Limitation of Liabilities',
        key.tCBody11: '10.1 Representations and Warranties'
            '\n\t You agree that all content on the Platform is "as is" and "as available" and you understand that any access or utilization of the Platform and any associated products, goods, and services is at your own risk.'
            '\n\t Furthermore, all product images are just for representation and could look differently than the actual product. ISMMART makes every effort to keep the Platform accessible and functioning, however, they cannot guarantee the service is secure, timely, without errors, technical issues, or viruses. Temporary service outages can be expected due to system maintenance or force majeure events'
            '\n10.2 Limitation of Liability'
            '\n\t As stipulated by the law, ISMMART (along with its staff, supervisors, representatives, associates, and mother or father firm) disclaims all responsibility (regardless of whether developing from an arrangement, in carelessness or otherwise) for misfortune or harm that you or some other individual may go through in association with our Platform, Services, and any connected sites, alongside any substance or material posted there. Your exclusive choice in regards to the utilization of the Platform is to stop such use. The ISMMART organizations, their operators, representatives, and service suppliers wont be answerable for any circuitous, extraordinary, coincidental, backhanded, or incredible harms emerging from your utilization of the Platform or for any other claim in any capacity identified with your utilization of the Platform.These dismissals of circuitous, uncommon, backhanded, and extraordinary harms incorporate, without limitation, harms for lost benefits, lost information, misfortune of benevolence, work interruption, PC disappointment, or deficiency, or some other business harms or misfortunes, regardless of whether the ISMMART substances, their operators, representatives, and service suppliers had been educated regarding the probability thereof and independent of the lawful or equivalent theory on which the claim depends.Since certain states or purviews do not permit the preclusion or the impediment of risk for backhanded or accidental harms, in such states or purviews, ISMMART, the ISMMART elements, its operators, delegates and service suppliers risk shall be limited to the degree allowed by the law.'
            '\n10.3 Vendor’s representations'
            '\n\t ISMMART shall not be held responsible for either your or the Vendors actions in regards to the Goods delivered; furthermore, they do not take responsibility for the quality, condition or any other attribute of the Goods or services, or guarantee the accuracy of any menu information, photos, and/or images displayed on the Vendors listing/offering. It is to be noted, however, that no clauses within these Terms of Service absolve the Vendor from liability in cases of death or personal injury resulting from their own negligence or malicious behavior.',
        key.tCHeader12: '11. Vendor Liability',
        key.tCBody12:
            'The vendors have the complete accountability for the preparedness, condition, and caliber of the products sold to you. In the case of third-party deliveries, these partners are in charge of transporting the items and/or orders. ISMMART has no duty for any deficit, harm, expenditure, charge, or penalty that may come from the contractual bond with the partner.',
        key.tCHeader13: '12. Personal Data (Personal Information) Protection',
        key.tCBody13:
            'By accepting these Terms, you are giving your express approval for ISMMART and its related companies to gather, use, process and divulge your Personal Data, as specified in our Privacy Policy. This document is attached as part of these Terms and is available for viewing at (https://ismmart.com/privacypolicy) or from the links on our Platform.',
        key.tCHeader14: '13. Indemnity',
        key.tCBody14: '13.1 use of the Platform;'
            '\n13.2 use of the Services; or'
            '\n13.3 breach of these Terms.',
        key.tCHeader15: '14. Third Party Links and Websites',
        key.tCBody15:
            'We cannot take responsibility for any damage or loss you may incur from clicking on third party links that are included on the Platform. These links may take you to products, websites, services and offers not owned or managed by us. We cannot vouch for the content, functionality, security, services, privacy policies, or any other aspect of these third party websites. Thus, we cannot be held liable for any loss or damage related to your access and use of these third party links.',
        key.tCHeader16: '15. Termination',
        key.tCBody16:
            'ISMMART holds the authority to deactivate, suspend, or cancel your account and also to forbid your access to or use of the Platform, which also encompasses any type of delivery service given to you regarding an Order. This can be due to any number of reasons, such as, but not restricted to, if ISMMART deems your usage to be inadequate, or the results of Background Checks to be unsatisfactory, or perceives or finds out that you are associated with any kind of activity or conduct that contravenes the Terms. ISMMART might, but is not required to, alert you in advance of restricting your use of the Platform.',
        key.tCHeader17: '16. Amendments',
        key.tCBody17:
            'At any point in time, ISMMART reserves the right to revise the present Terms at its discretion. Such amendments come into effect as soon as they are published on the website, within the boundaries of applicable legislation. Consequently, it is your duty to ensure that you are familiar with the current version of the Terms. If you are unhappy with the amendments, whether in full or in part, you must refrain from using the Platform immediately.',
        key.tCHeader18: '17. Severability',
        key.tCBody18:
            'Should any portion of these Terms be deemed unlawful by any competent court of jurisdiction, the remaining stipulations shall remain intact. Furthermore, a waiver of any provision of these Terms shall not be construed as a subsequent or continuing waiver of the said or any other provision.',
        key.tCHeader19: '18. Governing Law',
        key.tCBody19:
            'The legislation of the nation wherein the applicable ISMMART establishment is established shall have authority over and shape the understanding of these Terms.',
        key.tCHeader20: '19. Contact US',
        key.tCBody20:
            'If you have any queries or opinions that you would like to share with us, kindly call our support number as stated on the website.',
        key.tCHeader21: '20.Prevailing Language',
        key.tCBody21:
            'In the case of any discrepancy between the terms, the English version will be binding. The English language edition of these terms shall be deemed supreme and any differences in comparison to the translated versions shall be disregarded.',

        ///Vendor Terms&Conditions
        key.vendorHeader0: '',
        key.vendorBody0:
            'The Provider (ISMMART Group of Industries PVT LTD. Pakistan) and the Vendor (defined as third-party vendors) shall collectively be referred to as “Parties” and individually as “Party”, as the case may be.\n\nWHEREAS, Provider acts as an independent contractor of the Vendor, who, through this agreement, grants Provider full authority to conclude and negotiate contracts with customers in the name and for the account of the Vendor, as well as for the offers of the Vendor, made via Provider’s online platform www.ismmart.com (“Website”) and mobile applications (where applicable). It is understood that the Provider does not act on behalf of the customers.\n\nWHEREAS, all contracts concluded by the Provider in its function as agent on behalf of the Vendor with customers via the Provider\'s online marketplace will be based on the General Terms and Conditions with the customers as found on the Website.\n\nWHEREAS, these terms and conditions form part of this agreement under which Provider, provides an online product ordering platform to the Vendor, and, where applicable, shipment services to the customer.\n\nWHEREAS Parties shall provide each other with their NTN# and STN#. In case of any change, the same shall also be communicated to the other party.',

        key.vendorHeader1: '1. Provider Rights, Obligations and Duties:',
        key.vendorBody1:
            '1.1: The Provider shall be transferring the order(s) through Vendor Dashboard or phone call (Only in case, if the website is not working) to the respective outlet(s).\n\n1.2: The Provider shall transmit an order placed by a customer on the platform to the Vendor through the website or via call (when the website is not working) and accept the customer\'s payment online or in cash.\n\n1.3: In the event of the Provider performing the delivery services, have the right to charge the customer a delivery fee (“ISMMART Delivery Fee”), and determine a minimum order value, at its own discretion; In order to perform the Services, Provider shall:\n\t1.3.1 Ensure that the delivery time stated on the Website complies with the delivery time actually required.\n1.3.2 Ensure that all ordered items will be delivered in a state that a customer would expect for that type of item, provided that Vendor complies with the obligation in clause 2.7.\n\t1.3.3 The Revenue transfer to the vendor generated for such orders minus the Agency Fee/commission is as per clause 6 of these terms.\n\t1.3.4 Inform the Vendor in writing of any changes implemented to the procedures by the Provider at least two (2) days before the intended change takes place, and the Vendor shall comply with all such change(s).\n\t1.3.5 Have the right to alter, at its sole discretion, any services related to delivery, including delivery areas and operational timing, without prior notice.\n\t1.3.6 The Provider shall provide contact details of the relevant stakeholder/point of contact for the Vendor. In case, the Provider intends to update the contact information, the same shall be notified to the Vendor seven (7) days before the effective date of change of contact information.',

        key.vendorHeader2:
            '2 Third-Party Vendor Rights, Obligations and Duties:',
        key.vendorBody2:
            'The vendor shall:\n\n2.1 Provide the Provider with a list of all items “Item List” as agreed on with Provider. Item List to be made available for display on the website.\n\n2.2 Should the Vendor wish to make any changes to the Item List, the product(s) status shall be changed to "Pending". The Provider will review the changes and approve or disapprove the changes according to the Provider\'s product policies within two (2) business days.\n\n2.3 Comply with all local Laws and Regulations and obtain and maintain all necessary licenses, permissions, and consents (which may be required in order to perform its obligations under this Agreement)\n2.4 Provide the Provider, and its Rider’s (defined as the Provider’s own rider and/or our delivery partners, i.e., TCS,Fedex & DHL) access to the Vendor\'s premises as reasonably required by the Provider to perform the Services.\n\n2.5 Provide the Provider with a clear acceptance or rejection of order(s), no later than 12 hours from the time, the order was made available to the Vendor, provided that the order must be completed within the specified time period as given by the Provider. If the Vendor neither accepts or rejects the order, it will automatically be rejected by the Provider.\n\n2.6 In case, the Vendor providing Provider with a rejection as per clause 2.5, the Vendor should clearly state the reason(s) for such rejection, no later than 12 hours from the time the order was made available to the Vendor.\n\n2.7 Upon accepting an order, prepare and pack the order without delay in it at no less than the common standard of the Vendor, and transfer it to the Provider\'s delivery person or the Customer (in case of Vendor delivery).\n\n2.8 Ensure that all ordered items provided to its indirect customers availing Provider’s services shall be of the same quality as provided by the Vendor to its direct customers.\n\n2.9 Vendor accepts, acknowledges and undertakes that:\n\n2.9.1 The Vendor will not deliver items that have reached/and or crossed their expiry/best-before date as printed on the packaging by the manufacturer.\n\n2.9.2 The Vendor will not alter, change, amend, and/or remove the expiry/best-before date as printed on the packaging by the manufacturer of the item.\n\n2.9.3 In the event of a breach of clause 2.9.1, the Vendor shall be liable and responsible for any health conditions developed by the customer as a result of consuming/using expired items as delivered by the Vendor and will be held responsible for all acts of the customer including litigation.\n\n2.9.4 Be solely responsible and liable for any and all customer queries, claims, and/or complaints in respect of the contents, missing items, wrong items, and quality of the items and any consequential effects thereof.\n\n2.10  Ensure that the Vendor, at all times, has sufficient capacity (including staff, items and equipment) available to process all orders in accordance with the average delivery time provided to the customers.\n\n2.11 Immediately update the stock on Vendor Dashboard on the platform in case of unavailability of a product.',

        key.vendorHeader3: '2.12 Prices:',
        key.vendorBody3:
            '2.12.1 Vendor hereby warrants that the prices made available to the Provider are identical to the real-time prices offered to customers when placing orders by the platform.\n\n2.12.2 If the Vendor intends any price reduction, promotion or discount for any of the items ordered through the platform, Vendor shall notify the Provider at least seven (7) days in advance stating the extent of the price reduction, promotions or discounts, the respective effective date and the duration thereof.\n\n2.13 Treat Provider’s riders in case the Vendor uses Provider’s Delivery system in a respectful and civilized manner, which includes but is not limited to the prohibition of the use of abusive language, abusive behavior, harassment, assault, and battery. Training shall be provided to the Vendor and its staff in this regard. Breach of this clause shall constitute a breach of this agreement.\n\n2.14 The vendor agrees to accept Electronic Vouchers issued by the Provider to customers to be used while order check-out. The payment of all such vouchers will be reimbursed by the Provider in the monthly/weekly invoice in the registered bank account of the Vendor.\n\n2.15 Perform the vendor obligations, under this agreement, at all times in a competent, professional, and businesslike manner, within established industry standards, practices, and principles, and within the time deadlines set forth herein.\n\n2.16 The Vendor shall provide contact information and address as required by the Provider. In case, the Vendor intends to update the provided information, the Vendor shall notify the Provider seven (7) days prior to the effective date of change in contact information.',

        key.vendorHeader4: '3. Customer recovery charge – Damages/Penalty:',
        key.vendorBody4:
            '3.1 The Vendor acknowledges that the Provider is a reputable company in Pakistan, which seeks to provide convenience, reliability, and quality to its customers. As Provider’s systems and operations are heavily dependent on customer experience and feedback, the Vendor confirms and agrees with the Provider that in the event the Vendor fails to observe or comply with the Provider’s operational standards, the Vendor shall pay the Provider such sum as shall be determined by the Provider as liquidated damages (“Customer Recovery Charge”). The aforesaid Customer Recovery Charge shall not prejudice the right of the Provider to claim damages for the costs and expense of taking such steps as deemed necessary by the Provider to rectify such non-observation and/or non-compliance with such operational standards.\n\n3.2 Vendor acknowledges that it has read, understood, and agrees with the provisions of clause 3 and also agrees that the application of the provisions of clause 3 shall be applicable until notification of suspension by the Provider, provided that Vendor is given a minimum of seven (7) days written notice.\n\n3.3 Any feedback received by the Provider from a customer in relation to the delivered order shall be considered as an inspection performed by the Provider and the Vendor shall accept any such outcome without contest. Furthermore, despite the payment of the liquidated damages, the Provider shall reserve all its rights at law in relation to the breaches.',

        key.vendorHeader5: '4 Suspension:',
        key.vendorBody5:
            '4.1 Provider shall have the right to temporarily suspend the Vendor from the platform, without penalty, if:\n\n4.1.1 The Vendor has failed to pay the Provider invoices that have become due.\n\n4.1.2 In its reasonable opinion, the Vendor is in breach of any terms of this agreement or may be negatively affecting the Provider’s business.\n\n4.2 To avoid any doubts, any suspension shall not result in the termination of this agreement, the provisions of which shall remain fully applicable.',

        key.vendorHeader6: '5 Indemnification from Third Party Claims:',
        key.vendorBody6:
            '5.1 Either party shall at its expense, defend any of the following types of third party claims brought against the other Party, its directors, officers, or agents (collectively, “Indemnitees”) and indemnify against:\n\n5.1.1 Any claim that, if true, would constitute a breach of this agreement by either Party, its employees, agents, or representatives.\n\n5.1.2 Any claim related to injury to or death of any person or damage to any property arising out of or related to either Parties obligations arising out of this agreement; or arising from the negligence, acts, or failures to act, of either Party its employees, agents, or representatives.\n\n5.1.3 Either Party shall indemnify and hold harmless the Indemnitees from any costs, losses, claims, damages, and fees (including reasonable legal fees) incurred by any of them that are attributable to any such claim.',

        key.vendorHeader7: '6 Fees, Payment and Collection of Funds:',
        key.vendorBody7:
            '6.1 The Vendor grants the Provider authority to receive any funds in the name, and for the account, of the Vendor paid by the customers, whether by online means or in cash.\n\n6.2 In the event of cash payment by the customer at delivery, the Provider shall be responsible for collecting the cash payment and reconciling with the other Party in accordance with the provisions of clause 6.\n\n6.3 In the event of online payment, the Provider shall collect money and reconcile in accordance with the provisions of clause 6.\n\n6.4 The Parties agree and accept that the revenue generated, the commission Fee and the delivery fee will be calculated and payable in the amount agreed to, in this agreement and that no other fees or charges shall apply between the Parties or towards the customers, except as provided for in this agreement. The vendor specifically accepts that, if applicable, the Provider may set off the Agency/Aggregator Fee against the revenue generated.\n\n6.5 The Parties agree and accept to pay the Vendor his dues, within ten (10) business days from the time of order delivery.',

        key.vendorHeader8: '6.6 Invoicing & Payments – Provider Delivery:',
        key.vendorBody8:
            '6.6.1 The Provider will collect all orders on credit and will invoice (“Order Statement”) the Vendor on a bimonthly basis through email.\n\n6.6.2 The Provider within three (3) days of invoice will do weekly reimbursements after deducting commissions and all applicable taxes on a weekly basis to the registered bank account of the Vendor.\n\n6.6.3 The Provider will be sending a monthly/weekly order summary and payment notification to Vendor’s registered e-mail address.\n\n6.6.4 Bank Service fee  according to the  _Bank_% , will be charged to the Vendor against all order received on Online Payments.',

        key.vendorHeader9: '6.7 Online Ordering and Corporate Orders:',
        key.vendorBody9:
            '6.7.1 All Online Payments will be transferred and treated as regular orders and will be paid out to the Vendor.\n\n6.8 Saving the provisions of clause 3.1, the Provider shall also issue the Vendor with an outline of liquidated damages due by the Vendor to the Provider (“Notification of Damages”).\n\n6.9 The Vendor shall have the right to appeal the Order Statement and Notification of Damages in accordance with the below:\n\n6.9.1 The Vendor shall object in writing within five (5) business days of the issuing date of the relevant Order Statement or Notification of Damages and shall clearly state all the reasons for the appeal, including any supporting documentation.\n\n6.9.2 The Provider shall review the objection within three (3) business days from being notified of the Vendor’s objection and:\n\ni. If agreed with, the Provider shall adjust the Order Statement or Notification of Damages accordingly.\n\nii. If the Provider disagrees with the Vendor, it shall inform Vendor of such and the Parties will attempt in good faith to resolve any dispute or claim arising out of or in relation to this agreement through negotiations between a director or authorized representative of each of the Parties with authority to settle the relevant dispute.\n\n6.9.3 If the dispute cannot be settled amicably within fourteen (14) days of receipt of the appeal either Party shall be entitled to apply the provisions of clause 19 and/or 24 respectively.',

        key.vendorHeader10: '7 Commencement of Services:',
        key.vendorBody10:
            'The Vendor shall only be listed on the platform after the receipt of all information requested by Provider including, but not limited to the Item List; a logo and approved images of products. Provider shall inform the Vendor, of the starting date of the Services (“Commencement Date”), which notification shall be annexed to this Agreement.',

        key.vendorHeader11: '8. Policy and Procedure Compliance:',
        key.vendorBody11:
            '8.1 The Vendor understands that the Provider may suspend Vendor’s services with or without notice in case of complaint (quality and/or delivery/pickup complaints) ratio exceeds 2% of the total orders arriving at the Vendor’s business which may result in reorder rate to lower than average.\n\n8.2 The Vendor accepts that upon rejection of order(s), his outlet will be deactivated from the platform for a duration as per Provider’s discretion.\n\n8.3 The vendor will ensure to provide discount vouchers to the customers where applicable in case of genuine complaint of the customer.\n\n8.4 In case of customer complaints, the Vendor shall in no case complain about or incriminate the Provider in any manner whatsoever.\n\n8.5 The Vendor agrees not to pay any discount/commissions to the Provider’s delivery person.',

        key.vendorHeader12: '9. Warranties:',
        key.vendorBody12:
            'The Vendor represents, warrants and undertakes that the use by the Vendor of its intellectual property shall not infringe upon, misappropriate or otherwise come in conflict with any intellectual property rights of the third-party. The Vendor shall indemnify in full the Provider against any IP right infringement claims brought against them by the Third party as per Clause 5 stated above.',

        key.vendorHeader13: '10. Confidentiality:',
        key.vendorBody13:
            '10.1 A party ("Receiving Party") shall keep in strict confidence all technical or commercial know-how, specifications, inventions, processes, or initiatives which are of a confidential nature and have been disclosed to the Receiving Party by the other party ("Disclosing Party"), and any other confidential information concerning the Disclosing Party\'s business, its products, and services which the receiving party may obtain.\n\n10.2 The Receiving Party shall only disclose such confidential information to those of its employees, agents, and subcontractors who need to know it for the purpose of discharging the Receiving Party\'s obligations under this agreement.\n\n10.3 Parties shall keep all information relating to ordering and delivery procedures confidential and shall at no time disclose any information to customers.\n\n10.4 In case the details are required to be disclosed by law, any governmental or regulatory authority or by a court of competent jurisdiction to any governmental body or regulatory authority, the same shall be communicated to the other party in advance in writing.\n\n10.5 This clause 10 shall survive termination of this agreement.',

        key.vendorHeader14: '11. No Partnership',
        key.vendorBody14:
            'Nothing in this agreement is intended to or shall be deemed to, establish any corporate partnership or joint venture between the Parties.',

        key.vendorHeader15: '12. Amendments:',
        key.vendorBody15:
            '12.1 The Provider shall have the right to increase the success fee at any time as per the Provider’s discretion. The same shall be informed to the Vendor through an official email and/or through Vendor dashboard.\n\n12.2 The Provider shall have the right to amend, remove, correct and/or add any commitments, obligations, and responsibility for itself and/or on part of the Vendor by a way of an addendum. The same shall be informed to the Vendor through an official email and/or via the Vendor dashboard.\n\n12.3 In the event of the Vendor disagreeing with such amendments, he/she shall have the right to terminate this agreement in accordance with the provisions of clause 18.\n\n12.4 It is specifically agreed that all amendments shall be effective between the Parties with effect from the date notified by the Provider in accordance with clause 12.2.',

        key.vendorHeader16: '13. Force Majeure:',
        key.vendorBody16:
            'For the purposes of this agreement, "Force Majeure Event" means an event beyond the reasonable control of either party including but not limited to acts of God, war, riot, civil commotion, or terrorist action. Neither Party shall be liable to the other Party as a direct result of any delay or failure to perform its obligations under this agreement as a result of a Force Majeure	Event.',

        key.vendorHeader17: '14. Third Parties:',
        key.vendorBody17:
            'A person who is not a party to this agreement shall not have any rights to enforce its terms.',

        key.vendorHeader18: '15. Notices:',
        key.vendorBody18:
            '15.1 All notices under this agreement shall be in writing, addressed to the agreed contact person/address as per this agreement, and be deemed duly given on the same day when agreed upon during the Vendor Registration process.',

        key.vendorHeader19: '16. Assignment:',
        key.vendorBody19:
            '16.1 The Provider may at any time assign, transfer, mortgage, charge, subcontract, or deal in any other manner with all or any of its rights under this agreement and may subcontract or delegate in any manner any or all of its obligations under this agreement to any third party or agent.\n\n16.2 The Vendor shall not, without the prior written consent of the Provider, which shall not be unreasonably withheld, assign, transfer, mortgage, charge, subcontract, or declare a trust over or deal in any other manner with any or all of its rights or obligations under this agreement.',

        key.vendorHeader20: '17. Waiver:',
        key.vendorBody20:
            'A waiver of any right under this agreement or law is only effective if it is in writing and shall not be deemed to be a waiver of any subsequent breach or default. No failure in exercising any right or remedy provided under this agreement or by law shall constitute a waiver of any right or remedy, nor shall it prevent or restrict its further exercise of that or any other right or remedy.',

        key.vendorHeader21: '18. Term and Termination:',
        key.vendorBody21:
            '18.1 This agreement shall commence on the Commencement Date and will continue for an indefinite period, unless terminated earlier in accordance with this clause 18.1 . This agreement may be terminated:\n\n(a) by either Party for convenience by giving not less than five (5) days prior written notice.\n\n(b) with immediate effect upon the provision of written notice by either Party in the event of material breach of this agreement by the other party.\n\n(c) at any time by mutual written agreement between the Parties.\n\n18.2 The Provider shall have the right to terminate this agreement, with immediate effect and without any liability, in the event of a breach of section 2.12 and 2.13, where the Vendor has failed to remedy the breach within a maximum period of two (2) business days from notification.',

        key.vendorHeader22: '19. Limitation of Liability:',
        key.vendorBody22:
            '19.1 Nothing in this agreement shall limit or exclude either Party’s liability for death or personal injury caused by its negligence, or the negligence of its employees, agents, or subcontractors.\n\n19.2 Subject to clause 19.1, neither Party shall be liable to the other Party, whether in contract, tort (including negligence), breach of statutory duty, or otherwise, for any loss of profit, or any indirect or consequential loss or damages arising under or in connection with this agreement.\n\n19.3 This clause shall survive termination of this agreement.',

        key.vendorHeader23: '20. Conflicting Terms:',
        key.vendorBody23:
            'To the extent that any of these Terms conflict with the terms stated on the Vendor Registration Form (including, without limitation, any Special Conditions detailed on the Vendor Registration Form), the terms of the Vendor Registration Form shall prevail.',

        key.vendorHeader25: '21. Entire Agreement:',
        key.vendorBody25:
            'To the extent that any of these Terms conflict with the terms stated on the Vendor Registration Form (including, without limitation, any Special Conditions detailed on the Vendor Registration Form), the terms of the Vendor Registration Form shall prevail.',

        key.vendorHeader26: '22. Severability:',
        key.vendorBody26:
            'If any provision or part-provision of this Agreement is or becomes invalid, illegal, or unenforceable, it shall be deemed modified to the minimum extent necessary to make it valid, legal, and enforceable. If such modification is not possible, the relevant provision or part-provision shall be deemed deleted. Any modification to or deletion of a provision or part-provision under this clause shall not affect the validity and enforceability of the rest of this agreement.',

        key.vendorHeader27: '23. Governing Law and Jurisdiction:',
        key.vendorBody27:
            '23.1 This agreement, and any dispute or claim arising out of or in connection with it or its subject matter or formation (including non-contractual disputes or claims), shall be governed by, and construed in accordance with the laws of Pakistan.\n\n23.2 Each Party agrees that any dispute arising out of this agreement shall be subject to the non-exclusive jurisdiction of the courts of Pakistan, who shall settle any dispute or claim arising out of or in connection with this agreement or its subject matter or formation (including non-contractual disputes or claims).\n\nPerformance of this agreement shall continue during any court proceedings or any other dispute resolution mechanism. No payment due or payable by the Vendor or amount to be transferred by the Provider shall be withheld on account of a pending court dispute or other dispute resolution mechanism except to the extent that such payment is the subject of such disputes.',
      };
}
