// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui';
import 'dart:ui_web' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A stateful widget that allows users to display an image from a URL
/// and interact with fullscreen functionality.
class HomePage extends StatefulWidget {
  /// Creates a [HomePage] instance.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Controller for handling text input of the image URL.
  final TextEditingController imageController = TextEditingController();

  /// The URL of the image to be displayed.
  String imageUrl = '';

  /// Tracks whether the menu is open.
  bool _menuOpen = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      ui.platformViewRegistry.registerViewFactory(
        'custom-html-img',
        (int viewId) {
          final img = html.ImageElement()
            ..src = imageUrl
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.borderRadius = '12px';

          // Adds a double-click event listener to enter fullscreen mode.
          img.onDoubleClick.listen((_) => _toggleFullScreen());

          return img;
        },
      );
    }
  }

  /// Updates the image URL from the text field and displays it.
  void _showImage() {
    setState(() {
      imageUrl = imageController.text;
    });

    if (kIsWeb) {
      final imgElement = html.document.getElementById('custom-html-img');
      imgElement?.setAttribute('src', imageUrl);
    }
  }

  /// Toggles the visibility of the menu.
  void _toggleMenu() {
    setState(() {
      _menuOpen = !_menuOpen;
    });
  }

  /// Closes the menu.
  void _closeMenu() {
    setState(() {
      _menuOpen = false;
    });
  }

  /// Toggles fullscreen mode.
  void _toggleFullScreen() {
    if (kIsWeb) {
      js.context.callMethod('eval', [
        '''
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen();
        } else {
            document.exitFullscreen();
        }
        '''
      ]);
    }
  }

  /// Enters fullscreen mode.
  void _enterFullScreen() {
    if (kIsWeb) {
      js.context.callMethod('eval', [
        '''
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen();
        }
        '''
      ]);
      _closeMenu();
    }
  }

  /// Exits fullscreen mode.
  void _exitFullScreen() {
    if (kIsWeb) {
      js.context.callMethod('eval', [
        '''
        if (document.fullscreenElement) {
            document.exitFullscreen();
        }
        '''
      ]);
      _closeMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _closeMenu,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: imageUrl.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        )
                      : const HtmlElementView(viewType: 'custom-html-img'),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: imageController,
                      decoration: const InputDecoration(hintText: 'Image URL'),
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: _showImage,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Visibility(
                visible: _menuOpen,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          _buildMenuButton(
                              "Enter fullscreen", _enterFullScreen),
                          _buildMenuButton("Exit fullscreen", _exitFullScreen),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMenu,
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  /// Builds a menu button with a given label and action.
  Widget _buildMenuButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
