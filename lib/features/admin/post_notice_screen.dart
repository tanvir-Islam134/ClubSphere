import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/buttons.dart';
import '../../data/models/models.dart';

class PostNoticeScreen extends ConsumerStatefulWidget {
  final String clubId;
  const PostNoticeScreen({super.key, required this.clubId});

  @override
  ConsumerState<PostNoticeScreen> createState() => _PostNoticeScreenState();
}

class _PostNoticeScreenState extends ConsumerState<PostNoticeScreen> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  String _sendTo = 'All Members';

  @override
  Widget build(BuildContext context) {
    final clubNotices = ref
        .watch(noticesProvider)
        .where((n) => n.clubId == widget.clubId)
        .toList();

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Post Notice'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                      controller: _titleController,
                      label: 'Title',
                      hint: 'Enter notice title'),
                  const SizedBox(height: 16),
                  AppTextField(
                      controller: _messageController,
                      label: 'Message',
                      hint: 'Enter message content',
                      maxLines: 5),
                  const SizedBox(height: 16),
                  Text('Send To',
                      style: Theme.of(context).textTheme.labelSmall),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _sendTo,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    items: [
                      'All Members',
                      'Executive Committee',
                      'Specific Department'
                    ].map((String val) {
                      return DropdownMenuItem<String>(
                          value: val, child: Text(val));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _sendTo = val);
                    },
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Publish',
                    onPressed: () {
                      final notice = Notice(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        clubId: widget.clubId,
                        title: _titleController.text,
                        message: _messageController.text,
                        sendTo: _sendTo,
                        postedDate: DateTime.now(),
                      );
                      ref.read(noticesProvider.notifier).updateNotices([
                        ...ref.read(noticesProvider),
                        notice
                      ]);
                      context.pop();
                    },
                  ),
                  const SizedBox(height: 32),
                  Text('Recent Notices',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 16),
                  ...clubNotices.map((n) => Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(n.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${n.sendTo} • ${n.postedDate.toString().split(' ')[0]}'),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
