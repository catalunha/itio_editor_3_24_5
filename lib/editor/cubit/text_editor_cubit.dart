import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:itio_editor/editor/utils/state_utilities.dart';

import 'text_editor_state.dart';

const Map<String, String> lessonGuideCatalog = {
  '0':
      r'''[{"insert":"Title","attributes":{"code":true}},{"insert":"\n\ntesting set "},{"insert":"color1","attributes":{"color":"#ff00bcd4"}},{"insert":", color2\n\ntesting image in assets...\n"},{"insert":{"image":"assets/images/a.png"},"attributes":{"style":"width: 160.0; height: 200; "}},{"insert":"\ntesting gif in assets...\n"},{"insert":{"image":"assets/images/b.gif"},"attributes":{"style":"width: 160.0; height: 200; "}},{"insert":"\ntesting image in network...\n"},{"insert":{"image":"https://biblingoprod.s3.amazonaws.com/assets/app/badges/Items/Sandals/_After.png"},"attributes":{"style":"width: 199.076; height: 230.005; "}},{"insert":"\ntesting gif in network...\n"},{"insert":{"image":"http://biblingoprod.s3.amazonaws.com/assets/app/badges/Items/Sandals/BadgeSandals.gif"}},{"insert":"\n\nMatthew 1:1\n"},{"insert":"Βίβλος γενέσεως Ἰησοῦ Χριστοῦ υἱοῦ Δαυὶδ υἱοῦ Ἀβραάμ.","attributes":{"font":"GentiumPlus"}},{"insert":"\n\n"},{"insert":"Genesis 1:1","attributes":{"font":"GentiumPlus"}},{"insert":"\n"},{"insert":"א  בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ.","attributes":{"size":20,"font":"SBL_Hebrew"}},{"insert":"\n\nend.\n"}]''',
  '1':
      r'''[{"insert":"Title","attributes":{"code":true}},{"insert":"\ntesting image book...\ntesting gif..."},{"insert":{"image":"https://biblingoprod.s3.amazonaws.com/assets/app/badges/Items/Sandals/_After.png"},"attributes":{"style":"width: 157.1657142857143; height: 206.39542857142857; "}},{"insert":"\n"},{"insert":{"image":"http://biblingoprod.s3.amazonaws.com/assets/app/badges/Items/Sandals/BadgeSandals.gif"},"attributes":{"style":"width: 157.1657142857143; height: 206.39542857142857; "}},{"insert":"\n\nend.\n"}]''',
  'Greek.1':
      r'''[{"insert":"Title 1","attributes":{"code":true}},{"insert":"\nBody 1\n\n"},{"insert":"Ἄνθρωπ-","attributes":{"font":"GentiumPlus"}},{"insert":"ος","attributes":{"font":"GentiumPlus","color":"#FFB71C1C"}},{"insert":" κράζει","attributes":{"font":"GentiumPlus"}},{"insert":"\n"},{"insert":"vs.","attributes":{"size":"small"}},{"insert":"\n"},{"insert":"ἀδελφὴ τύπτει ἄνθρωπ-ον","attributes":{"font":"GentiumPlus"}},{"insert":"\n\n"},{"insert":"Title 2","attributes":{"code":true}},{"insert":"\nBody 2.1\n\n"},{"insert":"Body 2.2","attributes":{"bold":true}},{"insert":"\n\n"},{"insert":"Body 2.3","attributes":{"color":"#FFF44336"}},{"insert":"\n"}]''',
  'Greek.2':
      r'''[{"insert":"Forms","attributes":{"code":true}},{"insert":"\n"},{"insert":"Ending changes","attributes":{"italic":true,"bold":true}},{"insert":"\n\n"},{"insert":"Ἄνθρωπ-","attributes":{"font":"GentiumPlus"}},{"insert":"ος","attributes":{"font":"GentiumPlus","color":"#FFB71C1C"}},{"insert":" κράζει","attributes":{"font":"GentiumPlus"}},{"insert":"\nvs.\n"},{"insert":"ἀδελφὴ τύπτει ἄνθρωπ-","attributes":{"font":"GentiumPlus"}},{"insert":"ον","attributes":{"font":"GentiumPlus","color":"#FFF57F17"}},{"insert":"\n\n"},{"insert":"Ἀδελφ-ὴ ","attributes":{"font":"GentiumPlus"}},{"insert":"κράζει","attributes":{"font":"GentiumPlus","color":"#FF880E4F"}},{"insert":"\nvs.\n"},{"insert":"τέκνον τύπτει ἀδελφ-ήν","attributes":{"font":"GentiumPlus"}},{"insert":"\n\n"},{"insert":"But be careful!","attributes":{"bold":true}},{"insert":"\n\nΤέκν-ον κράζει\n=\n"},{"insert":"ἀδελφὴ τύπτει τέκν-ον","attributes":{"font":"GentiumPlus"}},{"insert":"\n\nThe ´ changes\n"},{"insert":"ὁ ἄνθρωπ-ος κράζει","attributes":{"font":"GentiumPlus"}},{"insert":"\nvs.\n"},{"insert":"ἀδελφὴ τύπτει τὸν ἄνθρωπ-ον","attributes":{"font":"GentiumPlus"}},{"insert":"\n\n"},{"insert":"ἡ ἀδελφ-ὴ κράζει","attributes":{"font":"GentiumPlus"}},{"insert":"\nvs.\n"},{"insert":"τέκνον τύπτει τὴν ἀδελφ-ήν","attributes":{"font":"GentiumPlus"}},{"insert":"\n\n"},{"insert":"But be careful!","attributes":{"bold":true}},{"insert":"\n"},{"insert":"τὸ τέκν-ον κράζει","attributes":{"font":"GentiumPlus"}},{"insert":"\n"},{"insert":"=","attributes":{"font":"GentiumPlus"}},{"insert":"\n"},{"insert":"ἀδελφὴ τύπτει τὸ τέκν-ον","attributes":{"font":"GentiumPlus"}},{"insert":"\n\n"},{"insert":"Meaning","attributes":{"font":"GentiumPlus","code":true}},{"insert":"\n"},{"insert":"ὁ ἄνθρωπος ἐσθίει ἄρτον may mean either:","attributes":{"font":"GentiumPlus"}},{"insert":"\n\nSomeone is doing something: ‘the person is eating bread'\nor\nSomeone has a habit: ‘the person eats bread’\n"}]''',
  'Greek.3':
      r'''[{"attributes":{"background":"transparent","color":"#000000"},"insert":"Titulo"},{"attributes":{"header":1},"insert":"\n"},{"insert":"\n"},{"attributes":{"background":"#ff0000","color":"#000000"},"insert":"Testando"},{"attributes":{"background":"transparent","color":"#000000"},"insert":" 1 2 "},{"attributes":{"background":"transparent","color":"#ff0000"},"insert":"3"},{"insert":"\n\n"},{"attributes":{"background":"transparent","color":"#ff0000"},"insert":"Titulo 1"},{"insert":"\n"},{"attributes":{"background":"transparent","color":"#ff0000"},"insert":"SubTitulo 1"},{"insert":"\n\n\n"}]'''
};

class TextEditorCubit extends Cubit<TextEditorState> {
  TextEditorCubit() : super(const TextEditorState()) {
    start();
  }

  void start() async {
    String? text;
    try {
      text = lessonGuideCatalog['0'];
    } catch (_) {}
    emitSafe(state.copyWith(
      status: StateStatus.success,
      text: text,
    ));
  }

  void saveText(String text) {
    emitSafe(state.copyWith(
      text: text,
    ));
  }

  void updateSettings({bool useCustomQuillToolbar = false}) {
    emitSafe(state.copyWith(
      useCustomQuillToolbar: useCustomQuillToolbar,
    ));
  }
}
