import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../signup/cubit/login_cubit.dart';
import '../pages/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../common/utils/constants.dart';
// import '../../../../common/utils/custom_otn_btn.dart';

// class PageTwo extends StatelessWidget {
//   const PageTwo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: Appconst.kHeight,
//       width: Appconst.kWidth,
//       color: Appconst.kBkDark,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30.w),
//             // child: Image.asset('assets/images/todo.png'),

//             child: const Icon(Icons.safety_check),
//           ),
//           const SizedBox(height: 50),
//           CustomOtlBtn(
//             width: Appconst.kWidth * 0.9,
//             height: Appconst.kHeight * 0.06,
//             color: Appconst.kLight,
//             text: 'Login with a phone number',
//             onTap: () {
//               // Navigator.pushReplacement(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => const LoginPage(),
//               //     ));
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
