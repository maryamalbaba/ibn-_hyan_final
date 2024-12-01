// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';

class SendAnswerUI extends StatelessWidget {
  const SendAnswerUI({
    Key? key,
    required this.onTap, required this.itemcount, required this.list,
  }) : super(key: key);
 final VoidCallback onTap;
 final int ?itemcount;
 final List<SentAnswerModel>list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          ElevatedButton(onPressed: onTap
          , child: const Text("تسليم الاختبار")),
          Expanded(
            child: ListView.builder(
              itemCount: itemcount,
              itemBuilder: (context,index){
               
                return ListTile(
                  title: Text(list[index].answer_text ??"mm" ),
                  leading:Text(list[index].answer_tarqem ?? "----"),
                  trailing: Text(index.toString()),
                );
              }),
          )
        ],
      ),
    );
  }
}
