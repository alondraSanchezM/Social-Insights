import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_insights/views/home/home_view.dart';

import '/constants.dart';

import '/controllers/view_controller.dart';
import 'tool/tool_view.dart';
import 'us/us_view.dart';


class MainView extends StatelessWidget {

  const MainView({ 
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 4, vertical: defaultPadding * 2),
              child: Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Social Insights\n',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: primaryColor,
                        fontWeight: FontWeight.w600
                      ),
                      children: [
                        TextSpan(
                          text: 'por Solution Settlers',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ]
                    )
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/bbva_logo.png',
                    height: _size.height * 0.05,
                    fit: BoxFit.fitHeight,
                  )
                ],
              ),
            ),
            const Expanded(
              child: HomeView()
            ),
          ],
        ),
      ),
      
    );
  }
}