import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

class SettingsScreen extends ConsumerWidget { const SettingsScreen({super.key}); @override Widget build(BuildContext context, WidgetRef ref)=>Scaffold(appBar:AppBar(title:const Text('Settings')),body:ListView(children:[const ListTile(leading:Icon(Icons.lock),title:Text('PIN and biometric login'),subtitle:Text('Protect parent controls with local authentication.')),const ListTile(leading:Icon(Icons.security),title:Text('Encrypted communication'),subtitle:Text('Firebase Auth tokens, Firestore rules, and secure local storage are required.')),const ListTile(leading:Icon(Icons.sos),title:Text('Emergency SOS'),subtitle:Text('Child-visible emergency button and family alerts.')),ListTile(leading:const Icon(Icons.logout),title:const Text('Sign out'),onTap:()=>ref.read(authServiceProvider).signOut())]));}
