import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsScreen extends StatelessWidget { const PermissionsScreen({super.key}); @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Permissions and consent')),body:ListView(padding:const EdgeInsets.all(16),children:[
 _PermissionTile('Accessibility Service','Used only to enforce disclosed app and web safety rules. The app must remain visible and user-controlled.',Icons.accessibility_new,()=>openAppSettings()),
 _PermissionTile('Location','Enables live location, history, geofencing, safe zones, and arrival/departure alerts.',Icons.location_on,()=>Permission.location.request()),
 _PermissionTile('Notifications','Sends safety alerts and child-visible status notifications.',Icons.notifications,()=>Permission.notification.request()),
 _PermissionTile('Usage Access','Reads app usage duration, daily screen time, and most-used apps.',Icons.query_stats,()=>openAppSettings()),
 _PermissionTile('Device Administration','Supports consented lock schedule and anti-tampering disclosure. Removal must follow Android policy.',Icons.admin_panel_settings,()=>openAppSettings()),
 _PermissionTile('Overlay Permission','Shows child-facing block screens and explanations when rules are active.',Icons.layers,()=>openAppSettings()),
 _PermissionTile('Background Activity','Keeps synchronization and safety alerts reliable.',Icons.sync,()=>openAppSettings()),
 ]));}}
class _PermissionTile extends StatelessWidget{ const _PermissionTile(this.title,this.subtitle,this.icon,this.onTap); final String title,subtitle; final IconData icon; final Future<void> Function() onTap; @override Widget build(BuildContext context)=>Card(child:ListTile(leading:Icon(icon),title:Text(title),subtitle:Text(subtitle),trailing:FilledButton(onPressed:onTap,child:const Text('Open'))));}
