import 'package:flutter/material.dart';

import 'package:flutter_demo/screens/User%20Details/user_details_content.dart';
import '../../models/user_model.dart';


class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200, // Reduced height
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'user-${user.id}',
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.deepPurple[800]!,
                        Colors.deepPurple[400]!,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.account_circle,
                      size: 100, // Slightly smaller icon
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: UserDetailContent(user: user),
          ),
        ],
      ),
    );
  }
}