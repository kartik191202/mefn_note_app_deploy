import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../router/page_const.dart';
import '../ui/add_note_page.dart';
import '../ui/profile_page.dart';
import '../ui/sign_up_page.dart';
import '../ui/update_note_page.dart';

import '../models/note_model.dart';
import '../ui/add_note.dart';
import '../ui/sign_in_page.dart';

class OnGenerateRout {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signUpPage:
        {
          return materialPageRoute(widget: SignUpPage());
        }

      case PageConst.signInPage:
        {
          return materialPageRoute(widget: SignInPage());
        }
      case PageConst.profilePage:
        {
          if (args is String) {
            return materialPageRoute(
                widget: ProfilePage(
              uid: args,
            ));
          } else {
            return materialPageRoute(widget: ErrorPage());
          }
        }
      case PageConst.addNotePage:
        {
          if (args is String) {
            return materialPageRoute(
                widget: AddNote(
              uid: args,
            ));
          } else {
            return materialPageRoute(widget: ErrorPage());
          }
        }

      case PageConst.updateNotePage:
        {
          if (args is NoteModel) {
            return materialPageRoute(
                widget: UpdateNotePage(
              note: args,
            ));
          } else {
            return materialPageRoute(widget: ErrorPage());
          }
        }

      default:
        return materialPageRoute(widget: ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Page"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialPageRoute({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
