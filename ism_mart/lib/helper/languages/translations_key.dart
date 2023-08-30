//////////////////////////////////////////////////////////////////////
///Welcome
const getOnboard = 'getOnboard',
    createYourAccount = 'createYourAccount',
    continueWithSameEmail = 'continueWithSameEmail',
    continueWithDiffEmail = 'continueWithDiffEmail';

///Add Update Address
const updateShippingAdd = 'updateShippingAdd',
    addShippingAdd = 'addShippingAdd';

///answer_question_view
const addAnswer = 'addAnswer',
    viewProduct = 'viewProduct',
    answer = 'answer',
    updateAnswer = 'updateAnswer',
    deleteAnswer = 'deleteAnswer';

///product_questions_view
const addQuestion = 'addQuestion';

///
const questions = 'questions',
    updateQuestion = 'updateQuestion',
    deleteQuestion = 'deleteQuestion',
    deleteQuestionDialogDesc = 'deleteQuestionDialogDesc',
    question = 'question',
    topVendors = "topVendors";

///errors
const noInternetConnection = 'noInternetConnection',
    serverUnableToHandle = 'serverUnableToHandle',
    serverTakingTooLong = 'serverTakingTooLong';

///authController
const currentUserNotFound = "currentUserNotFound",
    wrongWithCredentials = 'wrongWithCredentials';

///email_input
const enterEmail = "enterEmail", emptyField = "emptyField";

///reset_password
const enterDetails = 'enterDetails';

///sign_in
const passwordRequired = 'passwordRequired';

///checkout
const standard = 'standard',
    toProceedWithPurchase = 'toProceedWithPurchase',
    preferredPayment = 'preferredPayment',
    cartMustNotEmpty = 'cartMustNotEmpty',
    delivery = 'delivery',
    daysCost = 'daysCost',
    freeShipping = 'freeShipping',
    zipCode = 'zipCode',
    zipCodeRequired = 'zipCodeRequired',
    addressRequired = 'addressRequired',
    selectCountry = 'selectCountry',
    chooseCountry = 'chooseCountry',
    selectCity = 'selectCity',
    chooseCity = 'chooseCity',
    success = 'success',
    disputeDeleted = 'disputeDeleted',
    recordDoNotExist = 'recordDoNotExist',
    fileMustBe = 'fileMustBe',
    invalidImageFormat = 'invalidImageFormat',
    minPriceShouldNotBe = 'minPriceShouldNotBe',
    plzSelectCountry = 'plzSelectCountry',
    shippingAddressDetail = 'shippingAddressDetail',
    cashOnDelivery = 'cashOnDelivery',
    creditCard = 'creditCard',
    wantToRedeem = 'wantToRedeem',
    coins = 'coins',
    needMoreCoins = 'needMoreCoins',
    items = 'items',
    shippingFee = 'shippingFee',
    inclusiveOfGst = 'inclusiveOfGst',
    subtotal = 'subtotal',
    continueShopping = 'continueShopping',
    orderId = 'orderId',
    paymentSuccessful = 'paymentSuccessful',
    orderNotCreated = 'orderNotCreated',
    orderInformation = 'orderInformation',
    moreAboutCost = 'moreAboutCost',
    feeChargesExplained = 'feeChargesExplained',
    serviceFee = 'serviceFee',
    deliveryFee = 'deliveryFee',
    supportCenter = 'supportCenter',
    costDesc1 = 'costDesc1',
    costDesc2 = 'costDesc2',
    costDesc3 = 'costDesc3',
    costDesc4 = 'costDesc4';

///sellerController
const imageSizeDesc = 'imageSizeDesc';

///singleCartItems
const availableStock = 'availableStock',
    itemPrice = 'itemPrice',
    features = 'features';

///dashboard'
const itemsFound = 'itemsFound',
    price = 'price',
    minPrice = 'minPrice',
    maxPrice = 'maxPrice',
    clear = 'clear',
    lowToHigh = 'lowToHigh',
    highToLow = 'highToLow',
    OFF = 'OFF';

///SingleOrderDetailsUI
const orderDetail = 'orderDetail';

///email_verification
const cancel = 'cancel',
    emailVerificationLink = 'emailVerificationLink',
    emailVerification = 'emailVerification',
    verifyEmail = 'verifyEmail',
    emailVerificationLinkSent = 'emailVerificationLinkSent';

///DisputeDetailView
const id = 'id';
const disputeDetail = 'disputeDetail';

///AllDisputeView
const disputes = 'disputes';

///settings
const frequentlyAsked = 'frequentlyAsked',
    forAnyQueryJust = 'forAnyQueryJust',
    youStoreHas = 'youStoreHas';

///Delete Confirmation Dialog
const areYouSure = 'areYouSure';
const deletionProcessDetail = 'processDetail';

///products
const addToCart = 'addToCart',
    added = 'added',
    noQuestionFound = 'noQuestionFound',
    productQuestions = 'productQuestions',
    askQuestion = 'askQuestion',
    peopleAlsoViewed = 'peopleAlsoViewed',
    color = 'color',
    size = 'size',
    quantity = 'quantity',
    next = 'next',
    questionBody = 'questionBody',
    storeDetail = 'storeDetail',
    sellerRating = 'sellerRating',
    customers = 'customers',
    totalProducts = 'totalProducts',
    soldItems = 'soldItems',
    thisStoreHasBeen = 'thisStoreHasBeen',
    topProducts = 'topProducts',
    finalPriceWould = 'finalPriceWould',
    afterPlatformFee = 'afterPlatformFee',
    yourDiscountShould = 'yourDiscountShould',
    outOfStock = 'outOfStock',
    productNotFound = 'productNotFound',
    uploadImageLessThan = 'uploadImageLessThan',
    weightAndDimension = "weightAndDimension",
    productVariant = 'productVariant';

///my_orders
const invoiceNo = 'invoiceNo',
    Date = 'Date',
    billingDetails = 'billingDetails',
    qty = 'qty',
    amount = 'amount',
    pending = 'Pending',
    accepted = 'Accepted',
    shipped = 'Shipped',
    delivered = 'Delivered',
    cancelled = 'Cancelled',
    action = 'action',
    reviews = 'reviews',
    rating = 'rating',
    addDisputes = 'addDisputes',
    deleteDisputes = 'deleteDisputes',
    deleteDisputesMsg = 'deleteDisputesMsg',
    disputeAlreadyAdded = 'disputeAlreadyAdded',
    viewDispute = 'viewDispute',
    paymentMethod = 'paymentMethod',
    deliveryDate = 'deliveryDate',
    totalPrice = 'totalPrice',
    claimCanBeMade = 'claimCanBeMade',
    clickHereToUpload = 'clickHereToUpload',
    userOrderDispute = 'userOrderDispute',
    disputeNotAddedYet = 'disputeNotAddedYet';

///profile
const updateProfile = 'updateProfile',
    pickImage = 'pickImage',
    gallery = 'gallery',
    camera = 'camera',
    pickFrom = 'pickFrom',
    yourCoverAndProfile = 'yourCoverAndProfile',
    updateVendorDetails = 'updateVendorDetails',
    emailIsRequired = 'emailIsRequired',
    passwordIsRequired = 'passwordIsRequired',
    passwordConfirmIsRequired = 'passwordConfirmIsRequired',
    fieldIsRequired = 'fieldIsRequired',
    isRequired = 'isRequired';

///general
const call = 'call',
    centralHeadquarters = 'centralHeadquarters',
    centralHeadquartersValue = 'centralHeadquartersValue',
    globalHeadquarters = 'globalHeadquarters',
    globalHeadquartersValue = 'globalHeadquartersValue',
    privacyHeader1 = 'privacyHeader1',
    privacyHeader2 = 'privacyHeader2',
    privacyHeader3 = 'privacyHeader3',
    privacyHeader4 = 'privacyHeader4',
    privacyHeader5 = 'privacyHeader5',
    privacyHeader6 = 'privacyHeader6',
    privacyHeader7 = 'privacyHeader7',
    privacyHeader8 = 'privacyHeader8',
    privacyHeader9 = 'privacyHeader9',
    privacyHeader10 = 'privacyHeader10',
    privacyHeader11 = 'privacyHeader11',
    privacyHeader12 = 'privacyHeader12',
    privacyHeader13 = 'privacyHeader13',
    privacyHeader14 = 'privacyHeader14',
    privacyHeader15 = 'privacyHeader15',
    privacyBody1 = 'privacyBody1',
    privacyBody2 = 'privacyBody2',
    privacyBody3 = 'privacyBody3',
    privacyBody4 = 'privacyBody4',
    privacyBody5 = 'privacyBody5',
    privacyBody6 = 'privacyBody6',
    privacyBody7 = 'privacyBody7',
    privacyBody8 = 'privacyBody8',
    privacyBody9 = 'privacyBody9',
    privacyBody10 = 'privacyBody10',
    privacyBody11 = 'privacyBody11',
    privacyBody12 = 'privacyBody12',
    privacyBody13 = 'privacyBody13',
    privacyBody14 = 'privacyBody14',
    privacyBody15 = 'privacyBody15',
    exchangeHeader1 = 'exchangeHeader1',
    exchangeHeader2 = 'exchangeHeader2',
    exchangeBody1 = 'exchangeBody1',
    exchangeBody2 = 'exchangeBody2';

///memberShip
const discountMinValue = 'discountMinValue',
    discountMaxValue = 'discountMaxValue',
    memPlan1Title = 'memPlan1Title',
    memPlan1Price = 'memPlan1Price',
    memPlan1Desc1 = 'memPlan1Desc1',
    memPlan1Desc2 = 'memPlan1Desc2',
    memPlan1Desc3 = 'memPlan1Desc3',
    memPlan1Desc4 = 'memPlan1Desc4',
    memPlan2Title = 'memPlan2Title',
    memPlan2Desc1 = 'memPlan2Desc1',
    memPlan2Desc2 = 'memPlan2Desc2',
    memPlan2Desc3 = 'memPlan2Desc3',
    memPlan2Desc4 = 'memPlan2Desc4',
    memPlan2Desc5 = 'memPlan2Desc5',
    memPlan2Desc6 = 'memPlan2Desc6',
    memPlan2Desc7 = 'memPlan2Desc7',
    memPlan3Title = 'memPlan3Title',
    memPlan3Desc1 = 'memPlan3Desc1',
    memPlan3Desc2 = 'memPlan3Desc2',
    memPlan3Desc3 = 'memPlan3Desc3',
    memPlan3Desc4 = 'memPlan3Desc4',
    memPlan3Desc5 = 'memPlan3Desc5',
    memPlan3Desc6 = 'memPlan3Desc6',
    memPlan3Desc7 = 'memPlan3Desc7',
    memPlan3Desc8 = 'memPlan3Desc8',
    memPlan3Desc9 = 'memPlan3Desc9';

//////////////////////////////////////////////////////////////////////
/**
 *
 *  Settings
 * */
const exitApp = "exitApp", exitDialogDesc = "exitDialogDesc";
const settings = "settings",
    general = "general",
    account = "account",
    welcome = "welcome",
    language = "language",
    currencyKey = "currencyKey",
    notifications = "notifications",
    appearance = "appearance",
    faqs = "faqs",
    logout = "logout",
    aboutUs = "aboutUs",
    contactUs = "contactUs",
    myAccount = "myAccount",
    privacyPolicy = "privacyPolicy",
    selectLanguage = "selectLanguage",
    selectCurrency = "selectCurrency",
    returnAndExchange = "returnAndExchange",
    termsAndConditions = "termsAndConditions",
    helpCenter = "helpCenter";

/**
 * Bottom nav bar
 *
 */

const home = "home",
    categories = "categories",
    deals = "deals",
    myCart = "myCart",
    menu = "menu";

/**
 *
 * Buyer Dashboard
 */

const topCategories = "topCategories",
    discountDeals = "discountDeals",
    seeAll = "seeAll",
    viewMore = "viewMore",
    viewAll = "viewAll";

///ProductDetail
const productDetails = "productDetails",
    productRejected = "productRejected",
    stockLimitReached = "stockLimitReached", availableInStock = "availableInStock" , addToCartText = 'addToCartText';

/// buyer Check out
const shipping = "shipping",
    shippingCost = "shippingCost",
    shippingDetails = "shippingDetails",
    orderSummary = "orderSummary",
    expectedDelivery = "expectedDelivery",
    paymentCardFailed = "paymentCardFailed",
    maxAddressLimitMsg = "maxAddressLimitMesg",
    orderTime = "orderTime";

/**
 * Vendor
 * */

const vendorDashboard = "vendorDashboard",
    vendorRegistration = "vendorRegistration",
    myOrders = "myOrders",
    myProducts = "myProducts",
    recentOrders = "recentOrders";

const completedOrder = "completedOrders",
    pendingOrders = "pendingOrders",
    processingOrders = "processingOrders",
    totalOrders = "totalOrders",
    totalEarning = "totalEarning",
    cMonthEarning = "cMonthEarning",
    pendingAmount = "pendingAmount",
    silverCoins = "sliverCoins",
    goldCoins = "goldCoins",
    wallet = "wallet",
    userOrders = "userOrders",
    vendorOrders = "vendorOrders";

///
/// Profile
///

const profile = "profile",
    vendorStoreDetails = "store",
    personalInfo = "profileInfo",
    storeInfo = "storeInfo",
    bankDetails = "bnkDetails",
    shopNameReq = 'shopNameReq',
    phone = "phone",
    phoneReq = "phoneRequired",
    firstName = "firstName",
    lastName = "lastName",
    address = "address",
    country = "country",
    city = "city",
    bankName = "bankName",
    bankNameReq = 'bankNameReq',
    branchCode = "branchCode",
    branchCodeReq = "branchCodeReq",
    bankAccountReq = 'bankAccountReq',
    bankAccountHolder = "bAccHolder",
    bankAccHolderReq = "bankAccReq",
    deActivateMsg = "deActivateMsg",
    FirstNameReq = "FirstNameReq",
    LastNameReq = "LastNameReq",
    legalDocument = "legalDocument",
    incorrectAccOrIbanNo = 'incorrectAccNo',
    incorrectBranchCode = 'incorrectBranchCode',
    enterBranchCode = 'enterBranchCode';

///
/// Add Product
///

const addProduct = "addProduct", updateProduct = "updateProduct";
const deleteProd = "deleteProd", delProdMsg = "delProdMsg";

///
/// Contact us
///
const subject = "subject",
    subjectReq = "subjectReq",
    message = "message",
    messageReq = "messageReq",
    sendMessage = "sendMessage";

///
/// Orders section
///

const titleKey = "title", titleReq = "titleReq";
/**
 *  Login and register and form validations text
 * */

const login = "login",
    register = "register",
    loginGreetings = "loginGreetings",
    registerGreetings = "registerGreetings",
    donTHaveAccount = "donTHaveAccount",
    send = "send",
    verification = "verification",
    optional = "optional",
    alreadyHaveAccount = "alreadyHaveAccount",
    signIn = "singIn",
    signUp = "singUp",
    or = 'or',
    becomeAVendor = 'becomeAVendor',
    joinOurMarketplace = 'joinOurMarketplace',
    seamlessShopping = 'seamlessShopping',
    createAnAccount = 'createAnAccount',
    getOnboardUser = 'getOnboardUser',
    phoneNumber = 'phoneNumber',
    termsAndConditionsCheckbox = 'termsAndConditionsCheckbox',
    frontSide = 'frontSide',
    frontSideReq = 'frontSideReq',
    backSide = 'backSide',
    backSideReq = 'backSideReq',
    chequeImage = 'chequeImage',
    chequeImageReq = 'chequeImageReq',
    storeLogoImage = 'storeLogoImage',
    storeLogoImageReq = 'storeLogoImageReq',
    business = 'business',
    information = 'information',
    vendorAccountCreation = 'vendorAccountCreation',
    vendorBankAccount = 'vendorBankAccount',
    profileStatus = 'profileStatus',
    shopName = 'shopName',
    enterStoreName = 'enterStoreName',
    storeAddress = 'storeAddress',
    enterShopAddress = 'youShopAddress',
    ifAvailable = 'ifAvailable',
    enterNTNNumber = 'enterShopNTNNumber',
    storeNumber = 'shopNumber',
    lessThanMb = 'lessThanMb',
    chooseFile = 'chooseFile',
    noFileChosen = 'noFileChosen',
    waitForVerification = 'waitForVerification',
    vendor = 'vendor',
    submitted = 'submitted',
    lastStep = 'lastStep',
    availAmazingDiscount = 'availAmazingDiscount',
    descriptionOfDiscount = 'descriptionOfDiscount',
    celebrateFreedomAndSavings = 'celebrateFreedomAndSavings',
    descriptionOfFreedomAndSavings = 'descriptionOfFreedomAndSavings',
    boostYourBusiness = 'boostYourBusiness',
    descriptionOfBoostYourBusiness = 'descriptionOfBoostYourBusiness',
    storeCountry = 'storeCountry',
    storeCity = 'storeCity',
    enterOwnerName = 'enterOwnerName',
    vendorCNIC = 'vendorCNIC',
    enterCNIC = 'enterCNIC',
    storeCategory = 'storeCategory',
    yourStoreCategory = 'yourStoreCategory',
    storeDescription = 'storeDescription',
    storeDescReq = 'storeDescReq',
    enterStoreDescription = 'enterShopDescription',
    storeImage = 'shopImage',
    storeCoverImage = 'shopCoverImage',
    enterBankName = 'enterBankName',
    enterAccountTitle = 'enterAccountTitle',
    accountTitle = 'accountTitle',
    bankAccountNumber = 'bankAccountNumber',
    enterAccountNumberOrIban = 'enterAccountNumberOrIban',
    ibanReq = 'ibanReq',
    chequeImageNote =
        'This cheque image should have the same bank details visible as you mentioned above',
    weightIsReq = 'weightIsReq',
    enterCorrectWeight = 'enterCorrectWeight',
    weight = 'weight',
    length = 'length',
    width = 'width',
    height = 'height';

///Chatbot

const connectionError = 'connectionError',
    enableLocation = 'enableLocation',
    locationAccessDenied = 'locationAccessDenied',
    locationAccessPermanentlyDenied = 'locationAccessPermanentlyDenied',
    couldNotGetLocation = 'couldNotGetLocation',
    productExists = 'productExists';

/**
 * Form Validations
 *
 */
const email = "email",
    emailReq = "emailReq",
    invalidEmail = "invalidEmail",
    password = "password",
    passwordLengthReq = "passwordReq",
    phoneValidate = "phonevalidate",
    otp = "otp",
    otpReq = "otpReq",
    fullName = "fullName",
    fName = "First Name",
    lName = "Last Name",
    fullNameReq = "fullNameReq",
    nameAlphabaticReq = "nameAlphabaticReq",
    newPassword = "newPassword",
    newPassReq = "newPassReq",
    confirmPass = "confirmPass",
    confirmPassReq = "confirmPassReq",
    resetPass = 'resetPass',
    passwordNotMatched = "passNotMatched",
    forgotPasswordDesc = 'forgotPasswordDesc',
    forgotPassword = "forgotPassword",
    proceed = 'proceed',
    currentPassword = 'currentPassword',
    changePasswordDesc = 'changePasswordDesc',
    countryReq = "countryReq",
    cityReq = "cityReq",
    incorrectAddress = 'incorrectAddress',
    incorrectNTN = 'incorrectNTN',
    incorrectCNIC = 'incorrectCNIC',
    cnicReq = 'cnicReq',
    categoryReq = 'categoryReq';

const storeName = "storeName",
    storeNameReq = "storeNameRequired",
    ownerName = "ownerName",
    ownerNameReq = "ownerNameReq",
    description = "description",
    descriptionReq = "descriptionRequired",
    shopAddressReq = 'shopAddressReq';

///Add Product
final productName = "productName",
    productNameReq = "productNameReq",
    prodPrice = "prodPrice",
    prodPriceReq = "prodPriceReq",
    prodStock = "prodStock",
    prodStockReq = "prodStockReq",
    prodDiscount = "prodDiscount",
    prodDiscountReq = "prodDiscountReq",
    prodSku = "prodSku",
    prodSkuReq = "prodSkuReq",
    selectCategory = "selectCategory",
    selectSubCategory = "selectSubCategory";

///Update Product
final productImageSection = 'productImageSection',
    productThumbnail = 'productThumbnail',
    uploadThumbnail = 'uploadThumbnail',
    productImages = 'productImages',
    addedImages = 'addedImages';

/**
 * Membership Plans
 *
 */

const membershipPlans = "membershipPlans",
    membershipDesc = "membershipDesc",
    subscribeBtn = "subscribe",
    subscribedBtn = "subscribed",
    popular = "popular",
    perMonth = "perMonth";

///free membership.
const titleStart = "titleS",
    free = "free",
    descS1 = "descS1",
    descS2 = "descS2",
    descS3 = "descS3",
    descS4 = "descS4";

///Pro Membership
const titlePro = "titleP",
    descP1 = "descP1",
    descP2 = "descP2",
    descP3 = "descP3",
    descP4 = "descP4",
    descP5 = "descP5",
    descP6 = "descP6",
    descP7 = "descP7";

///Business Membership
const titleBusiness = "titleB",
    descB1 = "descB1",
    descB2 = "descB2",
    descB3 = "descB3",
    descB4 = "descB4",
    descB5 = "descB5",
    descB6 = "descB6",
    descB7 = "descB7",
    descB8 = "descB8",
    descB9 = "descB9";

/**
 *
 * General buttons text, and short texts
 */

const add = "add",
    addNew = "addNew",
    updateBtn = "update",
    deleteBtn = "delete",
    deactivateBtn = "deActivate",
    changeBtn = "change",
    confirm = "confirm",
    sortBy = "sortBy",
    sortByPrice = "sortByPrice",
    filter = "filterBy",
    set = "set",
    submit = "submit",
    sold = "sold",
    stock = "stock",
    noBtn = "noBtn",
    cancelBtn = "cancelBtn",
    yesBtn = "yesBtn",
    order = "Order",
    active = "active",
    apply = "apply",
    total = "total",
    status = "status",
    details = "details",
    checkout = "checkout",
    search = "search",
    searchIn = "searchIn",
    confirmOrder = "confirmOrder",
    addNewAddress = "addNewAddress",
    addPayment = "addPayments",
    proceedToCheckOut = "proceedToCheckOut",
    redeemBtn = "redeem",
    recentSearches = "recentSearches";

/**
 * No Page found messages
 *  empty and descriptions
 *  no Data found
 */

const emptyCart = "emptyCart", emptyCartMsg = "emptyCartMsg";
const emptyProductSearch = "emptyProductSearch",
    emptyProductSearchMsg = "emptyProductSearchMsg";

const noProductFound = "noProductFound",
    noOrderFound = "noOrderFound",
    noAddressFound = "noAddressFound",
    noDefaultAddressFound = "noDefaultAddressFound",
    noCartItemFound = "noCartItemFound",
    noCategoryFound = "noCategoryFound",
    noSubCategoryFound = "noSubCategoryFound",
    noDataFound = "noDataFound";

/// Snack bar errors or success Messages

const errorTitle = "error",
    errorMsg = "errorMsg",
    successTitle = "success",
    successMsg = "successMsg";

///error messages
const plzSelectSubCategory = "plzSelectSubCategory",
    someThingWentWrong = "someThingWentWrong";

/// Alert Message
const updateInfoAlertMsg = 'updateInfoAlertDetails',
    skip = 'skip',
    updateInfoToProceed = 'updateInfoToProceed',
    updateInfo = "updateInfo";

/// AboutUS Text

const aboutHeader1 = "key.aboutHeader1",
    aboutHeader2 = "key.aboutHeader2",
    aboutHeader3 = "key.aboutHeader3",
    aboutHeader4 = "key.aboutHeader4",
    aboutHeader5 = "key.aboutHeader5",
    aboutHeader6 = "key.aboutHeader6",
    aboutHeader7 = "key.aboutHeader7";

const aboutBody1 = "key.aboutBody1",
    aboutBody2 = "key.aboutBody2",
    aboutBody3 = "key.aboutBody3",
    aboutBody4 = "key.aboutBody4",
    aboutBody5 = "key.aboutBody5",
    aboutBody6 = "key.aboutBody6",
    aboutBody7 = "key.aboutBody7";

const tCHeader1 = "key.tCHeader1",
    tCBody1 = "key.tCBody1",
    tCHeader2 = "key.tCHeader2",
    tCBody2 = "key.tCBody2",
    tCHeader3 = "key.tCHeader3",
    tCBody3 = "key.tCBody3",
    tCHeader4 = "key.tCHeader4",
    tCBody4 = "key.tCBody4",
    tCHeader5 = "key.tCHeader5",
    tCBody5 = "key.tCBody5",
    tCHeader6 = "key.tCHeader6",
    tCBody6 = "key.tCBody6",
    tCHeader7 = "key.tCHeader7",
    tCBody7 = "key.tCBody7",
    tCHeader8 = 'key.tCHeader8',
    tCBody8 = 'key.tCBody8',
    tCHeader9 = 'key.tCHeader9',
    tCBody9 = 'key.tCBody9',
    tCHeader10 = 'key.tCHeader10',
    tCBody10 = 'key.tCBody10',
    tCHeader11 = 'key.tCHeader11',
    tCBody11 = 'key.tCBody11',
    tCHeader12 = 'key.tCHeader12',
    tCBody12 = 'key.tCBody12',
    tCHeader13 = 'key.tCHeader13',
    tCBody13 = 'key.tCBody13',
    tCHeader14 = 'key.tCHeader14',
    tCBody14 = 'key.tCBody14',
    tCHeader15 = 'key.tCHeader15',
    tCBody15 = 'key.tCBody15',
    tCHeader16 = 'key.tCHeader16',
    tCBody16 = 'key.tCBody16',
    tCHeader17 = 'key.tCHeader17',
    tCBody17 = 'key.tCBody17',
    tCHeader18 = 'key.tCHeader18',
    tCBody18 = 'key.tCBody18',
    tCHeader19 = 'key.tCHeader19',
    tCBody19 = 'key.tCBody19',
    tCHeader20 = 'key.tCHeader20',
    tCBody20 = 'key.tCBody20',
    tCHeader21 = 'key.tCHeader21',
    tCBody21 = 'key.tCBody21',
    tCHeader22 = 'key.tCHeader22',
    tCBody22 = 'key.tCBody22';

const vendorHeader0 = 'vendorHeader0',
    vendorBody0 = 'vendorBody0',
    vendorHeader1 = 'vendorHeader1',
    vendorBody1 = 'vendorBody1',
    vendorHeader2 = 'vendorHeader2',
    vendorBody2 = 'vendorBody2',
    vendorHeader3 = 'vendorHeader3',
    vendorBody3 = 'vendorBody3',
    vendorHeader4 = 'vendorHeader4',
    vendorBody4 = 'vendorBody4',
    vendorHeader5 = 'vendorHeader5',
    vendorBody5 = 'vendorBody5',
    vendorHeader6 = 'vendorHeader6',
    vendorBody6 = 'vendorBody6',
    vendorHeader7 = 'vendorHeader7',
    vendorBody7 = 'vendorBody7',
    vendorHeader8 = 'vendorHeader8',
    vendorBody8 = 'vendorBody8',
    vendorHeader9 = 'vendorHeader9',
    vendorBody9 = 'vendorBody9',
    vendorHeader10 = 'vendorHeader10',
    vendorBody10 = 'vendorBody10',
    vendorHeader11 = 'vendorHeader11',
    vendorBody11 = 'vendorBody11',
    vendorHeader12 = 'vendorHeader12',
    vendorBody12 = 'vendorBody12',
    vendorHeader13 = 'vendorHeader13',
    vendorBody13 = 'vendorBody13',
    vendorHeader14 = 'vendorHeader14',
    vendorBody14 = 'vendorBody14',
    vendorHeader15 = 'vendorHeader15',
    vendorBody15 = 'vendorBody15',
    vendorHeader16 = 'vendorHeader16',
    vendorBody16 = 'vendorBody16',
    vendorHeader17 = 'vendorHeader17',
    vendorBody17 = 'vendorBody17',
    vendorHeader18 = 'vendorHeader18',
    vendorBody18 = 'vendorBody18',
    vendorHeader19 = 'vendorHeader19',
    vendorBody19 = 'vendorBody19',
    vendorHeader20 = 'vendorHeader20',
    vendorBody20 = 'vendorBody20',
    vendorHeader21 = 'vendorHeader21',
    vendorBody21 = 'vendorBody21',
    vendorHeader22 = 'vendorHeader22',
    vendorBody22 = 'vendorBody22',
    vendorHeader23 = 'vendorHeader23',
    vendorBody23 = 'vendorBody23',
    vendorHeader25 = 'vendorHeader25',
    vendorBody25 = 'vendorBody25',
    vendorHeader26 = 'vendorHeader26',
    vendorBody26 = 'vendorBody26',
    vendorHeader27 = 'vendorHeader27',
    vendorBody27 = 'vendorBody27',
    vendorHeader28 = 'vendorHeader28',
    vendorBody28 = 'vendorBody28',
    vendorHeader29 = 'vendorHeader29',
    vendorBody29 = 'vendorBody29',
    vendorHeader30 = 'vendorHeader30',
    vendorBody30 = 'vendorBody30',
    vendorHeader31 = 'vendorHeader31',
    vendorBody31 = 'vendorBody31';
