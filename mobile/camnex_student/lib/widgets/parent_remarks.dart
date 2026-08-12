import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ParentRemarks extends StatefulWidget {
  final String studentName;

  const ParentRemarks({
    super.key,
    required this.studentName,
  });

  @override
  State<ParentRemarks> createState() =>
      _ParentRemarksState();
}

class _ParentRemarksState
    extends State<ParentRemarks> {
  final TextEditingController
      _messageController =
      TextEditingController();

  String? selectedTeacher;

  // Later this list will come from backend
  // based on the selected student.
  final List<Map<String, String>> teachers = [
    {
      'name': 'Mr. Rajesh Kumar',
      'subject': 'Mathematics',
    },
    {
      'name': 'Mrs. Priya Sharma',
      'subject': 'Science',
    },
    {
      'name': 'Mr. Amit Verma',
      'subject': 'English',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // ============================================
  // SEND BUTTON
  // ============================================

  void _sendMessage() {
    if (_messageController.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a message first.',
          ),
        ),
      );

      return;
    }

    _showTeacherSelection();
  }

  // ============================================
  // TEACHER SELECTION DIALOG
  // ============================================

  void _showTeacherSelection() {
    showDialog(
      context: context,

      builder: (context) {
        String? dialogSelectedTeacher =
            selectedTeacher;

        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(
                    Icons.person_search_outlined,
                    color:
                        AppTheme.primaryBlue,
                  ),

                  SizedBox(width: 10),

                  Text(
                    'Select Teacher',
                  ),
                ],
              ),

              content: SizedBox(
                width: 400,

                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Send message regarding ${widget.studentName}',

                      style:
                          const TextStyle(
                        color:
                            AppTheme.textSecondary,

                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'Choose Teacher',

                      style:
                          TextStyle(
                        fontWeight:
                            FontWeight.w600,

                        color:
                            AppTheme.textPrimary,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // ==================================
                    // TEACHER DROPDOWN
                    // ==================================

                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            AppTheme.lightBlue,

                        border:
                            Border.all(
                          color:
                              AppTheme.lightBlueBorder,
                        ),

                        borderRadius:
                            BorderRadius
                                .circular(
                          10,
                        ),
                      ),

                      child:
                          DropdownButtonHideUnderline(
                        child:
                            DropdownButton<
                                String>(
                          value:
                              dialogSelectedTeacher,

                          isExpanded:
                              true,

                          hint:
                              const Text(
                            'Select a teacher',
                          ),

                          items:
                              teachers
                                  .map(
                            (
                              teacher,
                            ) {
                              return DropdownMenuItem<
                                  String>(
                                value:
                                    teacher[
                                        'name'],

                                child:
                                    Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,

                                  children: [
                                    Text(
                                      teacher[
                                          'name']!,

                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .w600,

                                        color:
                                            AppTheme
                                                .textPrimary,
                                      ),
                                    ),

                                    Text(
                                      teacher[
                                          'subject']!,

                                      style:
                                          const TextStyle(
                                        fontSize:
                                            11,

                                        color:
                                            AppTheme
                                                .textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                                  .toList(),

                          onChanged:
                              (value) {
                            setDialogState(
                              () {
                                dialogSelectedTeacher =
                                    value;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ========================================
              // DIALOG ACTIONS
              // ========================================

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },

                  child:
                      const Text(
                    'Cancel',

                    style:
                        TextStyle(
                      color:
                          AppTheme.textSecondary,
                    ),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed:
                      dialogSelectedTeacher ==
                              null
                          ? null
                          : () {
                              selectedTeacher =
                                  dialogSelectedTeacher;

                              Navigator.pop(
                                context,
                              );

                              _messageSent();
                            },

                  icon:
                      const Icon(
                    Icons.send,
                    size: 16,
                  ),

                  label:
                      const Text(
                    'Send Message',
                  ),

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        AppTheme.primaryOrange,

                    foregroundColor:
                        Colors.white,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============================================
  // MESSAGE SENT
  // ============================================

  void _messageSent() {
    final teacher =
        selectedTeacher ?? '';

    final message =
        _messageController.text.trim();

    // Temporary demonstration.
    // Later this will call the backend API.
    debugPrint(
      'Student: ${widget.studentName}',
    );

    debugPrint(
      'Teacher: $teacher',
    );

    debugPrint(
      'Message: $message',
    );

    _messageController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          'Message sent to $teacher',
        ),

        // Green = Success
        backgroundColor:
            AppTheme.success,
      ),
    );
  }

  // ============================================
  // BUILD
  // ============================================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(20),

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

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.02,
            ),

            blurRadius:
                8,

            offset:
                const Offset(
              0,
              3,
            ),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ==========================================
          // HEADER
          // ==========================================

          Row(
            children: [
              const Icon(
                Icons.mail_outline,

                color:
                    AppTheme.primaryBlue,

                size: 22,
              ),

              const SizedBox(
                width: 10,
              ),

              const Expanded(
                child: Text(
                  'Parent Remarks',

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
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(
            'Send a message to your child\'s teacher',

            style:
                TextStyle(
              fontSize: 13,

              color:
                  AppTheme.textSecondary,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // ==========================================
          // MESSAGE INPUT
          // ==========================================

          TextField(
            controller:
                _messageController,

            maxLines:
                4,

            decoration:
                const InputDecoration(
              hintText:
                  'Type your message...',

              alignLabelWithHint:
                  true,
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          // ==========================================
          // SEND BUTTON
          // ==========================================

          Align(
            alignment:
                Alignment.centerRight,

            child:
                ElevatedButton.icon(
              onPressed:
                  _sendMessage,

              icon:
                  const Icon(
                Icons.send,
                size: 17,
              ),

              label:
                  const Text(
                'Send',
              ),

              // Orange = Important Action
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    AppTheme.primaryOrange,

                foregroundColor:
                    Colors.white,

                elevation:
                    0,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    9,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}