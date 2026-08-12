import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ConversationsScreen extends StatefulWidget {
  final String studentName;

  const ConversationsScreen({
    super.key,
    required this.studentName,
  });

  @override
  State<ConversationsScreen> createState() =>
      _ConversationsScreenState();
}

class _ConversationsScreenState
    extends State<ConversationsScreen> {

  // ============================================
  // TEACHERS OF CURRENT STUDENT
  // ============================================

  final List<Map<String, dynamic>> teachers = [
    {
      'name': 'Mr. Rajesh Kumar',
      'subject': 'Mathematics',
      'messages': [
        {
          'sender': 'teacher',
          'message':
              'Ayush is doing well in Mathematics. He should practice more algebra problems.',
          'time': '10:30 AM',
        },
        {
          'sender': 'parent',
          'message':
              'Thank you, sir. We will make sure he practices regularly.',
          'time': '11:15 AM',
        },
        {
          'sender': 'teacher',
          'message':
              'That would be great. I will also share some additional practice questions.',
          'time': '11:30 AM',
        },
      ],
    },
    {
      'name': 'Mrs. Priya Sharma',
      'subject': 'Science',
      'messages': [
        {
          'sender': 'teacher',
          'message':
              'Ayush performed very well in the recent Science examination.',
          'time': 'Yesterday',
        },
        {
          'sender': 'parent',
          'message':
              'Thank you for your feedback, ma’am.',
          'time': 'Yesterday',
        },
      ],
    },
    {
      'name': 'Mr. Amit Verma',
      'subject': 'English',
      'messages': [
        {
          'sender': 'teacher',
          'message':
              'Ayush should focus a little more on his writing skills.',
          'time': '12 Jun 2026',
        },
      ],
    },
  ];

  int selectedTeacherIndex = 0;

  final TextEditingController
      _messageController =
      TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // ============================================
  // SEND MESSAGE
  // ============================================

  void _sendMessage() {
    final message =
        _messageController.text.trim();

    if (message.isEmpty) {
      return;
    }

    setState(() {
      teachers[selectedTeacherIndex]
          ['messages']
          .add({
        'sender': 'parent',
        'message': message,
        'time': 'Now',
      });
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.background,

      body: SafeArea(
        child: Column(
          children: [

            // ========================================
            // PAGE HEADER
            // ========================================

            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 20,
              ),

              color: Colors.white,

              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,

                    decoration:
                        BoxDecoration(
                      color:
                          AppTheme.lightBlue,

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child: const Icon(
                      Icons.forum_outlined,

                      color:
                          AppTheme.primaryBlue,

                      size: 25,
                    ),
                  ),

                  const SizedBox(
                    width: 14,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Conversations',

                          style:
                              TextStyle(
                            fontSize: 23,

                            fontWeight:
                                FontWeight.w700,

                            color:
                                AppTheme.textPrimary,
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          'Communicate with ${widget.studentName}\'s teachers',

                          style:
                              const TextStyle(
                            fontSize: 13,

                            color:
                                AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ========================================
            // MAIN CONTENT
            // ========================================

            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.all(24),

                child: LayoutBuilder(
                  builder:
                      (context, constraints) {

                    if (constraints.maxWidth <
                        800) {
                      return _mobileLayout();
                    }

                    return _desktopLayout();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // DESKTOP LAYOUT
  // ============================================

  Widget _desktopLayout() {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,

      children: [

        // Teacher List
        SizedBox(
          width: 300,
          child: _teacherList(),
        ),

        const SizedBox(
          width: 20,
        ),

        // Chat
        Expanded(
          child: _chatArea(),
        ),
      ],
    );
  }

  // ============================================
  // MOBILE LAYOUT
  // ============================================

  Widget _mobileLayout() {
    return Column(
      children: [

        SizedBox(
          height: 180,
          child: _teacherList(),
        ),

        const SizedBox(
          height: 16,
        ),

        Expanded(
          child: _chatArea(),
        ),
      ],
    );
  }

  // ============================================
  // TEACHER LIST
  // ============================================

  Widget _teacherList() {
    return Container(
      decoration:
          BoxDecoration(
        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border:
            Border.all(
          color:
              AppTheme.border,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Padding(
            padding:
                EdgeInsets.all(18),

            child: Text(
              'Teachers',

              style:
                  TextStyle(
                fontSize: 17,

                fontWeight:
                    FontWeight.w700,

                color:
                    AppTheme.textPrimary,
              ),
            ),
          ),

          const Divider(
            height: 1,
            color:
                AppTheme.border,
          ),

          Expanded(
            child: ListView.builder(
              itemCount:
                  teachers.length,

              itemBuilder:
                  (context, index) {

                final teacher =
                    teachers[index];

                final isSelected =
                    selectedTeacherIndex ==
                        index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedTeacherIndex =
                          index;
                    });
                  },

                  child: Container(
                    padding:
                        const EdgeInsets.all(
                      14,
                    ),

                    color: isSelected
                        ? AppTheme.lightBlue
                        : Colors.transparent,

                    child: Row(
                      children: [

                        CircleAvatar(
                          radius: 22,

                          backgroundColor:
                              isSelected
                                  ? AppTheme.primaryBlue
                                  : AppTheme.lightBlue,

                          child: Icon(
                            Icons.person_outline,

                            color: isSelected
                                ? Colors.white
                                : AppTheme.primaryBlue,

                            size: 21,
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(
                                teacher['name'],

                                style:
                                    const TextStyle(
                                  fontSize: 14,

                                  fontWeight:
                                      FontWeight.w600,

                                  color:
                                      AppTheme.textPrimary,
                                ),
                              ),

                              const SizedBox(
                                height: 3,
                              ),

                              Text(
                                teacher['subject'],

                                style:
                                    const TextStyle(
                                  fontSize: 12,

                                  color:
                                      AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (isSelected)
                          const Icon(
                            Icons
                                .chevron_right,

                            color:
                                AppTheme.primaryBlue,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // CHAT AREA
  // ============================================

  Widget _chatArea() {
    final teacher =
        teachers[selectedTeacherIndex];

    final messages =
        teacher['messages']
            as List<dynamic>;

    return Container(
      decoration:
          BoxDecoration(
        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border:
            Border.all(
          color:
              AppTheme.border,
        ),
      ),

      child: Column(
        children: [

          // ========================================
          // CHAT HEADER
          // ========================================

          Padding(
            padding:
                const EdgeInsets.all(18),

            child: Row(
              children: [

                CircleAvatar(
                  radius: 22,

                  backgroundColor:
                      AppTheme.lightBlue,

                  child: const Icon(
                    Icons.person_outline,

                    color:
                        AppTheme.primaryBlue,
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        teacher['name'],

                        style:
                            const TextStyle(
                          fontSize: 15,

                          fontWeight:
                              FontWeight.w700,

                          color:
                              AppTheme.textPrimary,
                        ),
                      ),

                      const SizedBox(
                        height: 3,
                      ),

                      Text(
                        teacher['subject'],

                        style:
                            const TextStyle(
                          fontSize: 12,

                          color:
                              AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
            color:
                AppTheme.border,
          ),

          // ========================================
          // MESSAGES
          // ========================================

          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.all(20),

              itemCount:
                  messages.length,

              itemBuilder:
                  (context, index) {

                final message =
                    messages[index];

                final isParent =
                    message['sender'] ==
                        'parent';

                return Align(
                  alignment: isParent
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    constraints:
                        const BoxConstraints(
                      maxWidth: 500,
                    ),

                    margin:
                        const EdgeInsets.only(
                      bottom: 12,
                    ),

                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),

                    decoration:
                        BoxDecoration(
                      color: isParent
                          ? AppTheme.primaryBlue
                          : AppTheme.lightBlue,

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          message['message'],

                          style:
                              TextStyle(
                            fontSize: 13,

                            height: 1.4,

                            color: isParent
                                ? Colors.white
                                : AppTheme.textPrimary,
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          message['time'],

                          style:
                              TextStyle(
                            fontSize: 10,

                            color: isParent
                                ? Colors.white70
                                : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ========================================
          // MESSAGE INPUT
          // ========================================

          Container(
            padding:
                const EdgeInsets.all(14),

            decoration:
                const BoxDecoration(
              color:
                  Colors.white,
            ),

            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller:
                        _messageController,

                    maxLines: 1,

                    decoration:
                        const InputDecoration(
                      hintText:
                          'Type a message...',

                      contentPadding:
                          EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                // Orange Send Action
                SizedBox(
                  height: 48,
                  width: 48,

                  child:
                      ElevatedButton(
                    onPressed:
                        _sendMessage,

                    style:
                        ElevatedButton
                            .styleFrom(
                      padding:
                          EdgeInsets.zero,

                      backgroundColor:
                          AppTheme.primaryOrange,

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          10,
                        ),
                      ),
                    ),

                    child:
                        const Icon(
                      Icons.send,
                      size: 19,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}