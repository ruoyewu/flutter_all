
import 'package:all/model/model/login_verify_model.dart';
import 'package:all/presenter/contract/login_contract.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/material.dart';

class LoginRegisterWidget extends StatelessWidget {
  LoginRegisterWidget(this.presenter);

  ILoginPresenter presenter;

  TextEditingController _userIdController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userPhoneController = TextEditingController();
  TextEditingController _userCodeController = TextEditingController();

  onRegisterTap() {
    presenter.startRegister(
        _userIdController.text,
        _userNameController.text,
        _userPasswordController.text,
        _userPhoneController.text,
        _userCodeController.text);
  }

  onSendCodeTap() {
    presenter.startSendVerifyCode(_userPhoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.blueGrey, primarySwatch: Colors.blueGrey),
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
//		      				  autofocus: true,
                  controller: _userIdController,
                  keyboardType: TextInputType.number,
//		  				  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "账号",
//			    				prefixIcon: Icon(Icons.person)
                  ),
                ),
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(labelText: '昵称'),
                ),
                TextField(
                  controller: _userPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: '手机'),
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _userCodeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: '验证码'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: Widgets.buttonBoxDecoration,
                          child: ProviderConsumer<LoginVerifyModel>(
                              presenter.loginVerifyModel, (context, model, _) {
                            final left = model.timeLeft;
                            final enable = left == 0;
                            final text = enable ? '发送' : left.toString();
                            return InkWell(
                              onTap: () {
                                if (enable) {
                                  onSendCodeTap();
                                }
                              },
                              child: Center(
                                child: Text(text),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  controller: _userPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "密码",
//			    				prefixIcon: Icon(Icons.lock)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    child: InkWell(
                      onTap: onRegisterTap,
                      child: Center(child: Text("注册")),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
