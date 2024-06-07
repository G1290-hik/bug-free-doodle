import 'package:flutter/material.dart';
import 'package:responsivev2/widgets/widgets.dart';
import 'favorite_screen.dart';
import 'package:responsivev2/views/create_new_screen.dart';

class SliverScreen extends StatelessWidget {
  const SliverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: Row(
        children: [
          if (screenWidth >= 600) const NavWidget(),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      'https://images.unsplash.com/photo-1634534906615-58387f990bd7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      fit: BoxFit.fill,
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    'Sliver App Bar',
                    style: TextStyle(
                      color: theme.colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: theme.buttonTheme.colorScheme!.onPrimary,
                        size: 30,
                      ),
                    ),
                  ],
                  pinned: true,
                  expandedHeight: 200.0,
                  backgroundColor: theme.colorScheme.primary,
                  elevation: 10,
                  shadowColor: Colors.black,
                  floating: true,
                ),
                SliverToBoxAdapter(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      double width = constraints.maxWidth / 2;
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                              );
                            },
                            child: AdapterRowWidget(
                              theme: theme,
                              width: width,
                              icon: Icons.star,
                              iconColor: theme.colorScheme.secondary,
                              title: 'Favorite',
                              subtitle: 'test',
                              align: CrossAxisAlignment.start,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CreateNewScreen()),
                                );
                              },
                              child: AdapterRowWidget(
                                icon: Icons.add,
                                iconColor: theme.colorScheme.secondary,
                                theme: theme,
                                width: width,
                                title: 'Create New',
                                align: CrossAxisAlignment.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const CompactWidget(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: screenWidth < 600 ? const NavWidget() : null,
    );
  }
}
