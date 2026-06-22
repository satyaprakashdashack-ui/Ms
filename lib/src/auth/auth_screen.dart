import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

class AuthScreen extends ConsumerStatefulWidget { const AuthScreen({super.key}); @override ConsumerState<AuthScreen> createState()=>_AuthScreenState(); }
class _AuthScreenState extends ConsumerState<AuthScreen>{
 final email=TextEditingController(); final pass=TextEditingController(); bool register=false;
 @override Widget build(BuildContext context)=>Scaffold(body:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:420),child:Card(child:Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[
  const Icon(Icons.family_restroom,size:56), const SizedBox(height:12), Text('Guardian Parent',style:Theme.of(context).textTheme.headlineMedium), const Text('Consent-first family safety'),
  TextField(controller:email,decoration:const InputDecoration(labelText:'Email')), TextField(controller:pass,obscureText:true,decoration:const InputDecoration(labelText:'Password')),
  const SizedBox(height:16), FilledButton(onPressed:() async{final s=ref.read(authServiceProvider); register?await s.registerWithEmail(email.text,pass.text):await s.signInWithEmail(email.text,pass.text);},child:Text(register?'Create account':'Sign in')),
  TextButton(onPressed:()=>setState(()=>register=!register),child:Text(register?'I already have an account':'Create email account')),
  OutlinedButton.icon(onPressed:()=>ref.read(authServiceProvider).signInWithGoogle(),icon:const Icon(Icons.login),label:const Text('Continue with Google')),
 ])))));
}
