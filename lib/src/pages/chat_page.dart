import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/message.dart';

class ChatPage extends StatefulWidget {
    final Map<String,dynamic> infoChat;
  const ChatPage({Key? key, required this.infoChat}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();

  // final _focusNode = new FocusNode();




  List<MessageChat> _messaje = [
    MessageChat(
      messaje:
          'hola dasd  a sd  asd  a sdasdadasd asdasd asdasda asdasd asdasd ',
      uid: '123',
      type: 'text',
      // animationController: AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
    ),
    MessageChat(
      messaje: 'hola',
      uid: '122',
      type: 'img',
      //  animationController:AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
    ),
    MessageChat(
      messaje: 'hola',
      uid: '1232',
      type: 'video',
      //  animationController:AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
    ),
    MessageChat(
      messaje: 'hola',
      uid: '123',
      type: 'audio',
      //  animationController:AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
    ),
    MessageChat(
      messaje: 'hola',
      uid: '123',
      type: 'audio',
      //  animationController:AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
    ),
  ];

  // final _focusNode = FocusNode();

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {



print('LA INFORMACION : ${widget.infoChat}');



    final Responsive size = Responsive.of(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                // Puedes ajustar el contenido del CircleAvatar según tus necesidades
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/imgs/Avatar.png'),
              ),
              Spacer(),
              Container(
                // color: Colors.red,
                width: size.wScreen(65),
                child: Text(
                  'Pedro Cevallos  ',
                  style: GoogleFonts.poppins(
                    fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: -0.40,
                  ),
                  overflow: TextOverflow.ellipsis, // Color del título en negro
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: size.hScreen(100),
          width: size.wScreen(100),
          child: Column(
            children: [
              Flexible(child: Consumer<ChatController>(
                builder: (_, values, __) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: _messaje.length,
                    itemBuilder: (BuildContext context, int index) {
                      final messaje = _messaje[index];
                      return messaje;
                    },
                  );
                },
              )),
              _buildInputField(context, size)
            ],
          ),
        )
        // Column(
        //   children: <Widget>[
        //     Expanded(
        //       child: _buildMessageList(size),
        //     ),
        //     _buildInputField(context,size),
        //   ],
        // ),
        );

//   }

// Widget _buildMessageList(Responsive size) {
//   return Consumer<ChatController>(
//     builder: (context, chatModel, _) {
//       return ListView.builder(
//         reverse: true,
//         itemCount: chatModel.messages.length, // <- Aquí está la referencia a 'length'
//         itemBuilder: (context, index) {
//           var message = chatModel.messages[index];
//           return _buildMessageWidget(message,size);
//         },
//       );
//     },
//   );
// }

//     Widget _buildMessageWidget(Message message, Responsive size) {
//     IconData icon;
//     switch (message.type) {
//       case MessageType.image:
//         icon = Icons.image;
//         break;
//       case MessageType.audio:
//         icon = Icons.audiotrack;
//         break;
//       case MessageType.video:
//         icon = Icons.videocam;
//         break;
//       default:
//         icon = Icons.message;
//     }

//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       children: [
//         CircleAvatar(
//           radius: 20.0, // Ajusta el radio para que el tamaño total sea de 40
//           child: Icon(icon),
//         ),
//         SizedBox(width: 16.0),
//         Expanded(
//           child: Text(
//             message.text,
//             style: TextStyle(fontSize: 16.0),
//           ),
//         ),
//       ],
//     ),
//   );
  }

  Widget _buildInputField(BuildContext context, Responsive size) {
    return Consumer<ChatController>(
      builder: (_, valueChat, __) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(
                horizontal: size.wScreen(2.0), vertical: size.iScreen(0.0)),
            padding: EdgeInsets.symmetric(
                horizontal: size.hScreen(1.0), vertical: size.iScreen(0.0)),
            child: Row(
              children: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.image),
                //   onPressed: () {
                //     // _sendMessage(MessageType.image,context);
                //   },
                // ),
                // IconButton(
                //   icon: Icon(Icons.audiotrack),
                //   onPressed: () {
                //     // _sendMessage(MessageType.audio,context);
                //   },
                // ),
                Container(
                  // color: Colors.red,
                  child: Icon(
                    Icons.add,
                    color:  Colors.black,
                    size: size.iScreen(4),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Color(0xFFF2F2F2),
                      // color:Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    // color:Colors.red,
                    margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                    child: TextField(
                      onSubmitted: _hansdleSubmit,
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        valueChat.setCajaText(value);
                      },
                    ),
                  ),
                ),

                Container(
                    child: Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              'Enviar',
                              style: GoogleFonts.poppins(
                                fontSize: size.iScreen(1.5),
                                fontWeight: FontWeight.w600,
                                color: valueChat.getCajaTextoChat != ""
                                    ? Colors.black
                                    : Colors.grey.shade400,
                                // letterSpacing: -0.40,
                              ),
                            ),
                            onPressed:
                                valueChat.getCajaTextoChat != "" ? () {} : null,
                          )
                        :

                        // IconButton(

                        //     icon: Icon(
                        //       Icons.send,
                        //       color: valueChat.getCajaTextoChat != ""
                        //           ? tercearyColor
                        //           : Colors.grey.shade400,
                        //     ),

                        //     onPressed:
                        //         valueChat.getCajaTextoChat != "" ? () {} : null,

                        GestureDetector(
                            onTap:
                                valueChat.getCajaTextoChat != "" ? () {} : null,
                            child: Container(
                              width: size.wScreen(
                                  13), // Puedes ajustar el tamaño del contenedor según tus necesidades
                              height: size.hScreen(12),
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // Hace que el contenedor sea circular
                                color: valueChat.getCajaTextoChat != ""
                                    ? tercearyColor
                                    : Colors.grey
                                        .shade400, // Puedes ajustar el color del contenedor
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_upward_outlined,
                                  color: valueChat.getCajaTextoChat != ""
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          )),
              ],
            ),
          ),
        );
      },
    );
  }

//   void _sendMessage(MessageType type,BuildContext context) {
  _hansdleSubmit(value) {
    final valueChat = context.read<ChatController>();
    // print(value);
    valueChat.setCajaText(value);
    _textController.clear();
    final _newMessaje =
        //  MessageChat(uid: '123',messaje: valueChat.getCajaTextoChat,animationController: AnimationController(vsync: this ,duration: Duration( milliseconds: 200 )),);
        MessageChat(
      uid: '123',
      messaje: valueChat.getCajaTextoChat,
      type: 'text',
    );
    //     MessageChat(
    //   uid: '123',
    //   messaje: valueChat.getCajaTextoChat,
    // );
    //  _newMessaje.add(
    //     {'uid': '123',
    //     "messaje": valueChat.getCajaTextoChat,
    //     "animationController": AnimationController(vsync: this ,duration: Duration( milliseconds: 200 )),
    //  } );
    // valueChat.addMessage( _newMessaje);
    // valueChat.addMessage( _newMessaje);

    // valueChat.getCajaTextoChat['animationController'].forward();

    // valueChat.setCajaText('');

    _messaje.insert(0, _newMessaje);

    // _focusNode.requestFocus();
  }
}
