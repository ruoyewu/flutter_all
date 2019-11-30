
import 'package:all/presenter/contract/login_contract.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginLoginWidget extends StatelessWidget {
	LoginLoginWidget(this.presenter, {this.onRegisterTap});

	ILoginPresenter presenter;
	Function onRegisterTap;
	final _userIdController = TextEditingController();
	final _userPasswordController = TextEditingController();

	onLoginTap() {
		String id = _userIdController.text;
		String password = _userPasswordController.text;
		presenter.startLogin(id, password);
	}

	@override
  Widget build(BuildContext context) {
		return Theme(
			data: ThemeData(
				primaryColor: Colors.blueGrey,
			),
		  child: Center(
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
							      decoration: Widgets.buttonBoxDecoration,
							      child: InkWell(
								      onTap: onLoginTap,
								      child: Center(child: Text("登录")),
							      ),
						      ),
					      ),
					      Padding(
						      padding: const EdgeInsets.only(top: 30),
						      child: Container(
							      width: double.infinity,
							      height: 40,
							      decoration: Widgets.buttonBoxDecoration,
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
		);
  }
}