import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class TermsAndConditionsUI extends StatelessWidget {
  const TermsAndConditionsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            children: [
              CustomText(
                  title: "ISMMART Terms and Conditions",
                  style: textTheme.headline3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getData().map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppConstant.spaceWidget(height: 8),
                      CustomText(
                        title: e['header'],
                        style: textTheme.headline6,
                      ),
                      Text(
                        e['body'],
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kWhiteColor,
        ),
      ),
      title: CustomText(
          title: 'terms_conditions'.tr,
          style: textTheme.headline6!.copyWith(color: kWhiteColor)),
    );
  }

  List getData() {
    String dot = "\u2022";
    return [
      {
        'header': 'Introduction',
        'body':
            'Welcome to ISMMART Stores, also hereby known as “we” and “us”. These terms and conditions govern your access to and use of our online platform/site, as well as any associated websites, apps, services, or resources. You acknowledge that you have read, understand, and agree to the terms and conditions listed below before using the ISMMART Stores. These terms and conditions may be changed, modified, added, or removed at any moment without previous notice by ISMMART Stores. If no further notification is given, changes become effective when they are posted on the website.'
      },
      {
        'header': 'How the contract is formed between you and ISMMART Stores?',
        'body': '$dot After placing an order, you will receive online notification from us acknowledging that we have received your order. Please note that this does not mean that your order has been accepted. Your order constitutes an offer to us to buy a product. All orders are subject to acceptance by us. The contract will only be formed when you receive the products ordered via this platform.'
            '\n$dot The contract will relate only to those Products which you receive. A contract for any other products which may have been part of your order will be formed when you receive those other.'
      },
      {
        'header': 'Your account',
        'body': '$dot To access certain services offered by the platform, we may require that you create an account with us or provide personal information to complete the creation of an account.\n'
            '$dot You are responsible for maintaining the confidentiality of your user identification, password, account details and related private information. You acknowledge that you have this obligation to maintain the security of your account at all times and to take all reasonable precautions to prevent unauthorized use of your account. You should inform us immediately if you have any reason to believe that your password has become known to anyone else, or if the password is being, or is likely to be, used in an unauthorized manner. You understand and agree that any use of the website, any related services provided, and/or any access to confidential data, information, or communications made possible through the use of your account and password shall be deemed to have been made by you, or as the case may be, to have been made by someone authorized by you.\n'
            '$dot In case of breach or any serious violation of these terms and conditions, we reserve the right to invalidate the username and/or password after serving notice and providing reasonable time to rectify the same or make amends as per terms of this contract.'
      },
      {
        'header': 'Your status',
        'body': 'By placing an order through our site/platform, you warrant that:\n'
            '\t $dot you are legally capable of entering into binding contracts.\n'
            '\t $dot you are at least 18 years old.\n'
            '\t $dot you are not resident in a country where making a payment to our site, in line with these terms and conditions would breach any law.'
      },
      {
        'header': 'Delivery of Products',
        'body':
            'In the case of products, your order will be fulfilled/made ready for receipt (as applicable) within a reasonable time of the date indicated at the time of ordering, unless there are exceptional circumstances.'
      },
      {
        'header': 'Warranty',
        'body':
            'We warrant to you that any product purchased from us through our site will, on delivery, conform to its description, be of satisfactory quality, and be reasonably fit for all the purposes for which products of that kind are commonly supplied. All other warranties, conditions or terms relating to fitness for purpose, merchantability, satisfactory quality or condition whether implied by stature or common law are excluded in so far as permitted by law.'
      },
      {
        'header': 'Cancellation rights',
        'body': '$dot In the case of products, if you are contracting as a consumer, you have a right to cancel your product order for any reason and receive a full refund. You will receive a full refund of the price paid for the products (excluding shipping costs). Your right to cancel a contract relating to the purchase of a product starts from the date when you receive the Product (when the contract is formed). If the products have been delivered to you, you may cancel at any time as per the Return Policy. In the event that you received a product that is damaged on delivery then please inform us in writing as soon as possible. If a product is returned to us damaged and you have not informed us that the product was damaged when you received it then we may refuse your right to cancel or receive.\n'
            '$dot You will not have any right to cancel a contract for the supply of any made-to-order or personalized products, periodicals or magazines, perishable goods, or software, DVDs or CDs which have had their security seal opened.\n'
            '$dot In the case of products, to cancel a contract, you must inform us in writing. If the products have been delivered to you, you must also return the products to us as soon as reasonably practicable, and at your own cost. You have a legal obligation to take reasonable care of the products while they are in your hands.'
      },
      {
        'header': 'Transfer of rights and obligations',
        'body': '$dot We may transfer our rights and obligations under these terms and conditions to another organization, but that will not affect your rights or our obligations under the contract.\n'
            '$dot You may only transfer your rights and obligations under your contract with us if we agree to this in writing.'
      },
      {
        'header': 'Price',
        'body': '$dot Price of the products and our delivery charges will be as quoted on our platform/site from time to time, except in cases of obvious.\n'
            '$dot Product prices include GST/FED/VAT, where applicable. However, if the rate of GST/FED/VAT changes between the date of your order and the date of delivery, we will adjust the price accordingly.\n'
            'Product prices and delivery charges are liable to change at any time, but changes will not affect orders for products which you then take steps to fulfil/receive within a reasonable time.'
      },
      {
        'header': 'Refunds',
        'body':
            'If an order is cancelled in accordance with paragraph 6 above, then we will refund the amounts owed in accordance with our Refund Policy.'
      },
      {
        'header': 'How we use your information?',
        'body':
            'Please read the Privacy Policy for details on how we will use your information. By agreeing and accepting these terms and conditions you hereby agree and accept the terms of our Privacy Policy.'
      },
      {
        'header': 'Our liability to a Business',
        'body': '$dot If we fail to comply with these terms and conditions, we shall only be liable to you for the purchase price of the products and not any losses that you will suffer as a result of our failure to comply (whether arising in contract, delict (including negligence), breach of statutory duty or otherwise).\n'
            '$dot We will not be liable for losses that result from our failure to comply with these terms and conditions that fall into the following categories even if such losses were in our contemplation as at the date that the contract constituted by these terms and conditions was formed between us of being a foreseeable consequence of our breach.\n'
            '$dot loss of income or revenue.\n'
            '$dot loss of business. \n'
            '$dot loss of profits.\n'
            '$dot loss of anticipated savings \n'
            '$dot loss of data\n'
            '$dot waste of management or office\n'
            'Note: This paragraph does not apply if you are contracting as a consumer.'
      },
      {
        'header': 'Our liability to a Consumer',
        'body': '$dot If we fail to comply with these terms and conditions, we are responsible for loss or damage you suffer that is a foreseeable result of our breach of the terms and conditions or our negligence. Loss or damage is foreseeable if it was an obvious consequence of our breach or it was otherwise contemplated by you and us at the time we entered into the relevant. \n'
            '$dot We only supply the products to you for domestic and private use. You agree not to use the product for any commercial, business or re-sale purposes, and we have no liability to you for any loss of profit, loss of business, business interruption, or loss of business.\n'
            'Note: This paragraph does not apply if you are contracting as a business.'
      },
      {
        'header': 'Our contract with you if you are a Business',
        'body': '$dot These terms and conditions and any document expressly referred to in them constitute the whole agreement between us and supersede all previous discussions, correspondence, negotiations, previous arrangement, understanding or agreement between us relating to the subject matter hereof. \n'
            '$dot We each acknowledge that, in entering into a contract, neither of us relies on, or will have any remedies in respect of, any representation or warranty (whether made innocently or negligently) that is not set out in these terms and conditions or the documents referred to in, \n'
            '$dot Each of us agrees that our only liability in respect of those representations and warranties that are set out in this agreement (whether made innocently or negligently) will be for breach of. \n'
            '$dot Nothing in this paragraph limits or excludes any liability for\n'
            'Note: If you are contracting as a consumer, this paragraph does not apply.'
      },
      {
        'header': 'Our contract with you if you are a consumer',
        'body': 'f you are contracting as a consumer, we intend to rely upon these terms and conditions and any document expressly referred to in them in relation to the subject matter of any contract. While we accept responsibility for statements and representations made by our duly authorized agents, please make sure you ask for any variations from these terms and conditions to be confirmed in writing.'
            'Note: If you are contracting in the course of business, this paragraph does not apply.'
      },
      {
        'header': 'Notices',
        'body': '$dot Any notice to be sent by you or by us in connection with these terms and condition can be sent by letter or by email. Notices to us should be sent to one of the following addresses:\n'
            '\t\t$dot 2nd Floor, Emirates Tower, F7 Markaz, Islamabad.\n'
            '\t\t$dot Email: businesses@shaukatmarwatgroup.com\n'
            '\t\t$dot We will send notices to you by email to the email address that you supplied at the time of signing up to our platform\n'
            '\t\t$dot Either of us can change the address for notices by telling the other in writing the new address, but the previous address will continue to remain valid for 7 days after the change is made.'
      },
      {
        'header': 'Third party rights',
        'body':
            'A person who is not party to these terms and conditions or a contract shall not have any rights under or in connection with them.'
      },
      {
        'header': 'Waiver',
        'body':
            'The failure of either party to exercise or enforce any right conferred on that party by these terms and conditions shall not be deemed to be a waiver of any such right or operate to bar the exercise or enforcement thereof at any time or times thereafter. No waiver by us of any of these terms and conditions will be effective unless it is expressly stated to be a waiver and is communicated to you in writing in accordance with paragraph 16 above.'
      },
      {
        'header': 'Severability',
        'body':
            'If any court or competent authority decides that any of the provisions of these terms and conditions or any provisions of a contract are invalid, unlawful or unenforceable to any extent, the term will, to that extent only, be severed from the remaining terms, which will continue to be valid to the fullest extent permitted by law.'
      },
      {
        'header': 'Force Majeure',
        'body':
            'We reserve the right to defer the date of delivery or to cancel a contract for all circumstances beyond its reasonable control, including but not limited to any strike, lockout, disorder, fire, explosion, accident or stoppage of or affecting our business or work and which prevents or hinders the delivery of the goods or the performance of service.'
      },
      {
        'header': 'Law and jurisdiction',
        'body': '$dot These terms and conditions and any dispute or claim arising out of or in connection with them or their subject matter or formation (including non-contractual disputes or claims) will be governed by Pakistan law. You should understand that by ordering any of our product, you agree to be bound by these terms and conditions.\n'
            '\tCategories for Registration: 1- Basic Membership- Free of Cost: Can be registered as free members.\n'
            '\t\t$dot Cannot sell anything on ISMMART platform.\n'
            '\t\t$dot Will have only access to the products and stores to visit that are opened by default or kept opened by the Vendors & Businesses to visit.\n'
            '\t\t$dot They can buy anything at their own as a direct customers with mutual understanding with the seller; ISMMART will not be responsible or back up in case of any issues in such deal.\n'
            '\tPremium Membership – Paid Membership: \n'
            '\t\t$dot 5 USD per month with a free one month trial. Yearly subscription charges are 99.5 USD.\n'
            '\t\t$dot Can sell anything on ISMMART platform.\n'
            '\t\t$dot Will have access to all products and stores to visit.\n'
            '\t\t$dot All deals by Premium Members on ISMMART will be backed up by ISMMART. We will be responsible for smooth transactions and delivery of products. ISMMART will guarantee to honor the mutual understanding that both Seller and Buyer have agreed upon.\n'
            '\t\t$dot Premium Members will have worry less access to all businesses worldwide, both as a Seller & Buyer as ISMMART will be directly guaranteeing and verifying such members and any deals they do.\n'
            '\t\t$dot As all Premium Members are scrutinized and are verified through ISMMART verification process, so all such members can do worry less trade with each other, anywhere in the World.\n'
            '\t\t$dot Unlimited deliveries on eligible items.\n'
            '\n\t\t\tNote: All members (Sellers & Buyers) are requested to follow all trading rules and procedures mentioned by ISMMART to avoid any kind of inconvenience in payment or delivery. Commission Fee Structure Transaction value below PKR100,000/- ~ 0.5% Commission Transaction value above PKR100,000/- and below PKR250,00,00/- ~ 1.00% Commission Transaction value above PKR250,00,00/- but below PKR250,00,000/- ~ 1.75% Commission Transaction value above PKR250,00,000/- flat 2.25% Commission For any wholesale transaction a flat 3.5% Commission will be charged.\n'
            '\t\t\tNote: Transaction value excludes shipping and insurance cost.'
      },
    ];
  }
}
