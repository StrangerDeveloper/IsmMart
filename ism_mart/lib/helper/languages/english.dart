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
        key.shopLogoImage: 'Shop Logo/Image',
        key.shopLogoImageReq: 'Shop logo/image is required',
        key.business: 'Business',
        key.information: 'Information',
        key.vendorAccountCreation: 'Vendor Account Creation',
        key.vendorBankAccount: 'Vendor Bank Account',
        key.profileStatus: 'Profile Status',
        key.shopName: 'Shop Name',
        key.enterShopName: 'Enter Shop Name',
        key.shopAddress: 'Shop Address',
        key.enterShopAddress: 'Enter Shop Address',
        key.ifAvailable: 'if available',
        key.enterNTNNumber: 'Enter NTN Number',
        key.shopNumber: 'Shop Number',
        key.lessThanMb: 'Less than 2MB',
        key.chooseFile: 'Choose File',
        key.noFileChosen: 'No file chosen',
        key.waitForVerification: 'Wait for verification',
        key.vendor: 'Vendor',
        key.submitted: 'submitted',
        key.lastStep: 'Last Step',
        key.shopCountry: 'Shop Country',
        key.shopCity: 'Shop City',
        key.enterOwnerName: 'Your Owner Name',
        key.vendorCNIC: 'Vendor CNIC',
        key.enterCNIC: 'Enter CNIC',
        key.shopCategory: 'Shop Category',
        key.yourShopCategory: 'Your Shop Category',
        key.shopDescription: 'Shop Description',
        key.shopDescReq: 'Shop description is required',
        key.enterShopDescription: 'Enter Shop Description',
        key.shopImage: 'Shop Image',
        key.shopCoverImage: 'Shop Cover Image',
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
        key.weightIsReq: 'Weight is required',
        key.enterCorrectWeight: 'Invalid value. Enter correct weight',
        key.weight: 'Weight',
        key.length: 'Length',
        key.width: 'Width',
        key.height: 'Height',

        ///Chatbot
        key.connectionError: 'Error establishing connection. Try again.',
        key.enableLocation: 'Enable Location.',
        key.locationAccessDenied: 'Location access denied',
        key.locationAccessPermanentlyDenied: 'Location access permanently denied',
        key.couldNotGetLocation: 'Could not get location. Try again.',

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
        key.tCHeader1: '1. Introduction',
        key.tCBody1:
            'Welcome to ISMMART Stores, also hereby known as “we” and “us”. These terms and conditions govern your access to and use of our online platform/site, as well as any associated websites, apps, services, or resources. You acknowledge that you have read, understand, and agree to the terms and conditions listed below before using the ISMMART Stores. These terms and conditions may be changed, modified, added, or removed at any moment without previous notice by ISMMART Stores. If no further notification is given, changes become effective when they are posted on the website.',
        key.tCHeader2:
            '2. How the contract is formed between you and ISMMART Stores?',
        key.tCBody2:
            '• After placing an order, you will receive online notification from us acknowledging that we have received your order. Please note that this does not mean that your order has been accepted. Your order constitutes an offer to us to buy a product. All orders are subject to acceptance by us. The contract will only be formed when you receive the products ordered via this platform. \n • The contract will relate only to those Products which you receive. A contract for any other products which may have been part of your order will be formed when you receive those other.',
        key.tCHeader3: '3. Your account',
        key.tCBody3:
            '• To access certain services offered by the platform, we may require that you create an account with us or provide personal information to complete the creation of an account.'
                '\n• You are responsible for maintaining the confidentiality of your user identification, password, account details and related private information. You acknowledge that you have this obligation to maintain the security of your account at all times and to take all reasonable precautions to prevent unauthorized use of your account. You should inform us immediately if you have any reason to believe that your password has become known to anyone else, or if the password is being, or is likely to be, used in an unauthorized manner. You understand and agree that any use of the website, any related services provided, and/or any access to confidential data, information, or communications made possible through the use of your account and password shall be deemed to have been made by you, or as the case may be, to have been made by someone authorized by you.'
                '\n• In case of breach or any serious violation of these terms and conditions, we reserve the right to invalidate the username and/or password after serving notice and providing reasonable time to rectify the same or make amends as per terms of this contract.',
        key.tCHeader4: '4. Your status',
        key.tCBody4:
            'By placing an order through our site/platform, you warrant that:'
                '\n• You are legally capable of entering into binding contracts.'
                '\n• You are at least 18 years old.'
                '\n• You are not resident in a country where making a payment to our site, in line with these terms and conditions would breach any law.',
        key.tCHeader5: '5. Delivery of Products',
        key.tCBody5:
            'In the case of products, your order will be fulfilled/made ready for receipt (as applicable) within a reasonable time of the date indicated at the time of ordering, unless there are exceptional circumstances.',
        key.tCHeader6: '6. Warranty',
        key.tCBody6:
            'We warrant to you that any product purchased from us through our site will, on delivery, conform to its description, be of satisfactory quality, and be reasonably fit for all the purposes for which products of that kind are commonly supplied. All other warranties, conditions or terms relating to fitness for purpose, merchantability, satisfactory quality or condition whether implied by stature or common law are excluded in so far as permitted by law.',
        key.tCHeader7: '7. Cancellation rights',
        key.tCBody7:
            '• In the case of products, if you are contracting as a consumer, you have a right to cancel your product order for any reason and receive a full refund. You will receive a full refund of the price paid for the products (excluding shipping costs). Your right to cancel a contract relating to the purchase of a product starts from the date when you receive the Product (when the contract is formed). If the products have been delivered to you, you may cancel at any time as per the Return Policy. In the event that you received a product that is damaged on delivery then please inform us in writing as soon as possible. If a product is returned to us damaged and you have not informed us that the product was damaged when you received it then we may refuse your right to cancel or receive.'
                '\n• You will not have any right to cancel a contract for the supply of any made-to-order or personalized products, periodicals or magazines, perishable goods, or software, DVDs or CDs which have had their security seal opened.'
                '\n• In the case of products, to cancel a contract, you must inform us in writing. If the products have been delivered to you, you must also return the products to us as soon as reasonably practicable, and at your own cost. You have a legal obligation to take reasonable care of the products while they are in your hands.',
        key.tCHeader8: '8. Transfer of rights and obligations',
        key.tCBody8:
            '• We may transfer our rights and obligations under these terms and conditions to another organization, but that will not affect your rights or our obligations under the contract.'
                '\n• You may only transfer your rights and obligations under your contract with us if we agree to this in writing.',
        key.tCHeader9: '9. Price',
        key.tCBody9:
            '• Price of the products and our delivery charges will be as quoted on our platform/site from time to time, except in cases of obvious.'
                '\n• Product prices include GST/FED/VAT, where applicable. However, if the rate of GST/FED/VAT changes between the date of your order and the date of delivery, we will adjust the price accordingly.'
                '\n• Product prices and delivery charges are liable to change at any time, but changes will not affect orders for products which you then take steps to fulfil/receive within a reasonable time.',
        key.tCHeader10: '10. Refunds',
        key.tCBody10:
            'If an order is cancelled in accordance with paragraph 6 above, then we will refund the amounts owed in accordance with our Refund Policy.',
        key.tCHeader11: '11. How we use your information?',
        key.tCBody11:
            'Please read the Privacy Policy for details on how we will use your information. By agreeing and accepting these terms and conditions you hereby agree and accept the terms of our Privacy Policy.',
        key.tCHeader12: '12. Our liability to a Business',
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
        key.tCHeader13: '13. Our liability to a Consumer',
        key.tCBody13:
            '• If we fail to comply with these terms and conditions, we are responsible for loss or damage you suffer that is a foreseeable result of our breach of the terms and conditions or our negligence. Loss or damage is foreseeable if it was an obvious consequence of our breach or it was otherwise contemplated by you and us at the time we entered into the relevant.'
                '\n• We only supply the products to you for domestic and private use. You agree not to use the product for any commercial, business or re-sale purposes, and we have no liability to you for any loss of profit, loss of business, business interruption, or loss of business.'
                '\nNote: This paragraph does not apply if you are contracting as a business.',
        key.tCHeader14: '14. Our contract with you if you are a Business',
        key.tCBody14: '• These terms and conditions and any document expressly referred to in them constitute the whole agreement between us and supersede all previous discussions, correspondence, negotiations, previous arrangement, understanding or agreement between us relating to the subject matter hereof.'
            '\n• We each acknowledge that, in entering into a contract, neither of us relies on, or will have any remedies in respect of, any representation or warranty (whether made innocently or negligently) that is not set out in these terms and conditions.'
            '\n• Each of us agrees that our only liability in respect of those representations and warranties that are set out in this agreement (whether made innocently or negligently) will be for breach of contract.'
            '\n• Nothing in this paragraph limits or excludes any liability.'
            '\nIf you are contracting as a consumer, this paragraph does not apply',
        key.tCHeader15: '15. Our contract with you if you are a consumer',
        key.tCBody15:
            'If you are contracting as a consumer, we intend to rely upon these terms and conditions and any document expressly referred to in them in relation to the subject matter of any contract. While we accept responsibility for statements and representations made by our duly authorized agents, please make sure you ask for any variations from these terms and conditions to be confirmed in writing.'
                '\nNote: If you are contracting in the course of business, this paragraph does not apply.',
        key.tCHeader16: '16. Notices',
        key.tCBody16:
            '• Any notice to be sent by you or by us in connection with these terms and condition can be sent by letter or by email. Notices to us should be sent to one of the following addresses:'
                '\n > 2nd Floor, Emirates Tower, F7 Markaz, Islamabad.'
                '\n > Email: businesses@shaukatmarwatgroup.com'
                '\n• We will send notices to you by email to the email address that you supplied at the time of signing up to our platform'
                '\n• Either of us can change the address for notices by telling the other in writing the new address, but the previous address will continue to remain valid for 7 days after the change is made.',
        key.tCHeader17: '17. Third party rights',
        key.tCBody17:
            'A person who is not party to these terms and conditions or a contract shall not have any rights under or in connection with them.',
        key.tCHeader18: '18. Waiver',
        key.tCBody18:
            'The failure of either party to exercise or enforce any right conferred on that party by these terms and conditions shall not be deemed to be a waiver of any such right or operate to bar the exercise or enforcement thereof at any time or times thereafter. No waiver by us of any of these terms and conditions will be effective unless it is expressly stated to be a waiver and is communicated to you in writing in accordance with paragraph 16 above.',
        key.tCHeader19: '19. Severability',
        key.tCBody19:
            'If any court or competent authority decides that any of the provisions of these terms and conditions or any provisions of a contract are invalid, unlawful or unenforceable to any extent, the term will, to that extent only, be severed from the remaining terms, which will continue to be valid to the fullest extent permitted by law.',
        key.tCHeader20: '20. Force majeure',
        key.tCBody20:
            'We reserve the right to defer the date of delivery or to cancel a contract for all circumstances beyond its reasonable control, including but not limited to any strike, lockout, disorder, fire, explosion, accident or stoppage of or affecting our business or work and which prevents or hinders the delivery of the goods or the performance of service.',
        key.tCHeader21: '21. Law and jurisdiction',
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
