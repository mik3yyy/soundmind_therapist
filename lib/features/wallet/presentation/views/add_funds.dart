import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterwave_standard_smart/core/flutterwave.dart';
import 'package:flutterwave_standard_smart/models/requests/customer.dart';
import 'package:flutterwave_standard_smart/models/requests/customizations.dart';
import 'package:flutterwave_standard_smart/models/responses/charge_response.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/top_up/topup_wallet_cubit.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:sound_mind/features/wallet/presentation/views/paystack.dart';

class AddFundsPage extends StatefulWidget {
  const AddFundsPage({super.key});

  @override
  State<AddFundsPage> createState() => _AddFundsPageState();
}

class _AddFundsPageState extends State<AddFundsPage> {
  TextEditingController textEditingController = TextEditingController();
  var publicKey = dotenv.env['NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!;
  final plugin = PaystackPlugin();
  handlePaymentInitialization(
      {required String amout,
      required String ref,
      required BuildContext context}) async {
    var user = (context.read<AuthenticationBloc>().state as UserAccount).user;

    Charge charge = Charge()
      ..amount = amout.toInt() * 100
      ..reference = ref
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = user.email;
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status) {
      context
          .read<TopUpCubit>()
          .confirmTopUp(response.reference!, response.reference!);
    }
  }

  handlePaymentInitialization1(
      {required String amout,
      required String ref,
      required BuildContext context}) async {
    print(dotenv.env['NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!);

    var user = (context.read<AuthenticationBloc>().state as UserAccount).user;
    print('https://checkout.paystack.com/${ref}');
    // PaystackStandard(context)
    //     .checkout(checkoutUrl: "https://checkout.paystack.com/${ref}");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentWebViewPage(
          amount: amout,
          refrence: ref,
          email: user.email,
          paystackPublicKey: dotenv.env['NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!,
          successUrl: "https://michaelokpechi.netlify.app",
        ),
      ),
    );

    // if (response.status) {
    //   context
    //       .read<TopUpCubit>()
    //       .confirmTopUp(response.reference!, response.reference!);
    // }
  }
  // Navigate to the payment WebView page.
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => PaymentWebViewPage()),
  // );

  handlePaymentInitialization2(
      {required String amout, required String ref}) async {
    print(dotenv.env['NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!);

    var user = (context.read<AuthenticationBloc>().state as UserAccount).user;

    final Customer customer = Customer(
        name: user.lastName + user.firstName,
        phoneNumber: user.phoneNumber,
        email: user.email);
    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: dotenv.env['NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!,
      currency: "NGN",
      redirectUrl: "https://michaelokpechi.netlify.app",
      txRef: ref,
      amount: amout,
      customer: customer,
      paymentOptions: "ussd, card, barter, payattitude",
      customization: Customization(title: "My Payment"),
      isTestMode: true,
    );
    final ChargeResponse response = await flutterwave.charge();

    if (response.status != null) {
      if (response.status == 'completed') {
        context
            .read<TopUpCubit>()
            .confirmTopUp(response.txRef!, response.transactionId!);
        context.pop();
      }
    }
    // if(response.success){}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        centerTitle: false,
        title: const Text("Add Funds"),
      ),
      body: BlocListener<TopUpCubit, TopUpState>(
        listener: (context, state) {
          if (state is TopUpInitiated) {
            handlePaymentInitialization(
                amout: textEditingController.text,
                ref: state.topUpDetails['data'],
                context: context);
          }
          if (state is TopUpError) {
            Future.delayed(Duration(milliseconds: 100), () {
              if (mounted) {
                context.showSnackBar(state.message);
              }
            });
          }
        },
        child: Column(
          children: [
            CustomTextField(
              controller: textEditingController,
              hintText: "1000",
              titleText: "Amount",
              keyboardType: TextInputType.number,
            ),
            const Gap(20),
            BlocBuilder<TopUpCubit, TopUpState>(
              builder: (context, state) {
                return CustomButton(
                    label: "Top Up",
                    notifier: ValueNotifier(state is TopUpLoading),
                    onPressed: () {
                      context.read<TopUpCubit>().initiateTopUp(
                          double.parse(textEditingController.text));
                    });
              },
            )
          ],
        ),
      ).withSafeArea().withCustomPadding(),
    );
  }
}

class AddFundsPage2 extends StatefulWidget {
  const AddFundsPage2({super.key});

  @override
  State<AddFundsPage2> createState() => _AddFundsPage2State();
}

class _AddFundsPage2State extends State<AddFundsPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        centerTitle: false,
        title: Text("Add Funds"),
      ),
      body: SizedBox(
        height: context.screenHeight * .5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Gap(10),
            CircleAvatar(
                radius: 30,
                backgroundColor: context.secondaryColor,
                child: Icon(
                  Icons.house,
                  color: context.primaryColor,
                  size: 30,
                )),
            Text(
              "Wallet Account Number",
              style: context.textTheme.displayMedium,
            ),
            const Text(
              "Make a transfer to this account number and your wallet will be funded.",
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bank Name"),
                  Text(
                    "GT Bank",
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Account number"),
                      Text(
                        "07728468590",
                        style: context.textTheme.titleLarge,
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.copy,
                        color: context.primaryColor,
                      ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account name"),
                  Text(
                    "SoundMind inc",
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ).withSafeArea().withCustomPadding(),
      ),
    );
  }
}
