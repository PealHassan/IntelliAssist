import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
class MessagesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> messages;
  final ScrollController? scrollController; // Add scrollController parameter

  const MessagesScreen({
    Key? key,
    required this.messages,
    this.scrollController, // Update constructor
  }) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}
class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      widget.scrollController?.animateTo(
        widget.scrollController?.position.maxScrollExtent ?? 0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      controller: widget.scrollController,
      itemBuilder: (context,index){
        return Container(
          margin: EdgeInsets.all(10),
          child: Row(
                mainAxisAlignment: widget.messages[index]['isUserMessage']
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              20,
                            ),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(
                                widget.messages[index]['isUserMessage'] ? 0 : 20),
                            topLeft: Radius.circular(
                                widget.messages[index]['isUserMessage'] ? 20 : 0),
                          ),
                          color: widget.messages[index]['isUserMessage']
                              ? Colors.grey.shade800
                              : Colors.grey.shade900.withOpacity(0.8)),
                      constraints: BoxConstraints(maxWidth: w * 2 / 3),
                      child:
                          GestureDetector(
                            onLongPress: () {
                              Clipboard.setData(ClipboardData(text: widget.messages[index]['message'].text.text[0]));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Copied to clipboard")),
                              );
                            },
                            child : SelectableText(
                              widget.messages[index]['message'].text.text[0],
                              style: TextStyle(color: Colors.white), // Add your desired text style
                            )
                          ),
                  ),
                ],
              ),
        );
      }, 
      separatorBuilder: (_,i) => Padding(padding: EdgeInsets.only(top: 10)), 
      itemCount: widget.messages.length);  
  }
}