import 'package:flutter/material.dart';
import 'package:responsivev2/widgets/widgets.dart';

class SliverScreen extends StatelessWidget {
  const SliverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        body: Row(
          children: [
            if (screenWidth >= 600)
              NavWidget(),  // Add NavigationRail if screen width is greater than or equal to 600
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
                        double width = constraints.maxWidth;
                        return IntrinsicHeight(
                          child: Row(
                            children: [
                              Adapter_Row_Widget(
                                theme: theme,
                                width: width,
                                icon: Icons.star,
                                iconColor: theme.colorScheme.secondary,
                                title: 'Favorite',
                                subtitle: 'test',
                                align: CrossAxisAlignment.start,
                              ),
                              Adapter_Row_Widget(
                                icon: Icons.add,
                                iconColor: theme.colorScheme.secondary,
                                theme: theme,
                                width: width,
                                title: 'Create New',
                                align: CrossAxisAlignment.center,
                              ),
                            ],
                          ),
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
        bottomNavigationBar: screenWidth < 600 ? NavWidget() : null,  // Add BottomNavigationBar if screen width is less than 600
      ),
    );
  }
}