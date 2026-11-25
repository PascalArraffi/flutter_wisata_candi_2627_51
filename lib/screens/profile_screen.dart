import 'package:flutter/material.dart';
import 'package:flutter_wisata_candi_2627_51/providers/auth_provider.dart';
import 'package:flutter_wisata_candi_2627_51/providers/favorite_provider.dart';
import 'package:flutter_wisata_candi_2627_51/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final favoriteCount = context.watch<FavoriteProvider>().count;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Column(
            children: [
              //Todo 2 Profile Header
              Align(
                alignment: AlignmentGeometry.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top : 200-50),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.purple),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('images/placeholder_image.png'),
                        ),
                      ),
                      if (auth.isSignedIn)
                        IconButton(
                          onPressed: () {
                            
                          }, 
                          icon: Icon(Icons.camera_alt, color : Colors.deepPurple))
                    ],
                  ),
                ),
              ),
              //Todo 3 Profile Info
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child : Row(children: [
                      Icon(Icons.lock, color: Colors.amber,),
                      SizedBox(width: 8,),
                      Text("Pengguna", style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),)
                    ],)
                  ),
                  Expanded(
                    child: Text(
                      ' : ${auth.username}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              SizedBox(height: 4,),
              Divider(color: Colors.deepPurple,),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child : Row(children: [
                      Icon(Icons.person, color: Colors.blue,),
                      SizedBox(width: 8,),
                      Text("Nama", style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),)
                    ],)
                  ),
                  const Expanded(
                    child: Text(' : Rachmadi.', style: TextStyle(fontSize: 18)),
                  ),
                  if (auth.isSignedIn) const Icon(Icons.edit)
                ],
              ),
              SizedBox(height: 4,),
              Divider(color: Colors.deepPurple,),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child : Row(children: [
                      Icon(Icons.favorite, color: Colors.blue,),
                      SizedBox(width: 8,),
                      Text("Favorit", style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),)
                    ],)
                  ),
                  Expanded(child: Text(favoriteCount > 0 ? '$favoriteCount' : '', style: TextStyle(fontSize: 18),))
                ],
              ),
              SizedBox(height: 4,),
              Divider(color: Colors.deepPurple,),
              SizedBox(height: 16,),
              auth.isSignedIn
                  ? TextButton(
                      onPressed: () {
                        context.read<AuthProvider>().signOut();
                        context.read<FavoriteProvider>().clearAll();
                      },
                      child: const Text('Sign Out'),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text('Sign In'),
                    )
              //Todo 4 Profile Action
            ],
          ),
        ],
      ),
    );
  }
}