import 'package:trackmeup/Constants/Strings.dart';
import 'package:flutter/material.dart';


class termpage extends StatefulWidget {
  const termpage({Key? key}) : super(key: key);

  @override
  State<termpage> createState() => _termpageState();
}

class _termpageState extends State<termpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Terms and conditions:-",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
                Text('Eligibility: Users must meet certain age and residency requirements to use the app.'
                    'User Accounts: Users are responsible for maintaining the confidentiality of their account information and password.'
                    'Product Listings: The platform may have guidelines for the type of products that can be listed for sale. Users are responsible for ensuring that their listings are accurate and comply with these guidelines.'
                    'Payment and Fees: The platform may charge fees for the use of its services, including listing fees and sales commissions. Users are responsible for paying these fees and for complying with any payment processing rules established by the platform.'
                    'Shipping and Delivery: The platform may have policies in place regarding shipping and delivery, including estimated delivery times and shipping costs.'
                    'Returns and Refunds: The platform may have a returns and refunds policy in place, which may include conditions for returning or exchanging items and the process for obtaining a refund.'
                    'User Accounts: Users are responsible for maintaining the confidentiality of their account information and password.'
                    'Prohibited Conduct: Users are prohibited from engaging in illegal or harmful activities while using the app. This includes, but is not limited to, the sale of counterfeit goods or the use of the app for fraudulent purposes.'
                    'Product Listings: The app may have guidelines for the type of products that can be listed for sale. Users are responsible for ensuring that their listings are accurate and comply with these guidelines.'
                    'Payment and Fees: The app may charge fees for the use of its services, including listing fees and sales commissions. Users are responsible for paying these fees and for complying with any payment processing rules established by the app.'
                    'Intellectual Property: The app respects the intellectual property rights of others and expects users to do the same. If a user believes that their intellectual property rights have been violated, they may file a complaint with the app.'
                    'Dispute Resolution: The app may have a dispute resolution process in place to help resolve disputes between users.'
                    'Limitation of Liability: The app is not responsible for the actions of its users or for any damages that may result from using the app.'
                    'Termination: The app may terminate a user\'s account at any time, with or without cause.'
                    'Changes to Terms: The app may change these terms and conditions at any time, and users are responsible for reviewing the terms periodically to ensure they are aware of any changes.',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.black),),

              ],
            ),
            
          ),
        ),
      ),
    );
  }
}
