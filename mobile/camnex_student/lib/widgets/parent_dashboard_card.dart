import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ParentDashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String buttonText;
  final VoidCallback onTap;

  const ParentDashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final bool isSmall =
            width < 280;

        return Container(
          width: double.infinity,

          padding: EdgeInsets.all(
            isSmall ? 14 : 18,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(16),

            border: Border.all(
              color: AppTheme.border,
            ),

            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(
                  0.035,
                ),
                blurRadius: 12,
                offset:
                    const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ==================================================
              // ICON + TITLE
              // ==================================================

              Row(
                children: [

                  Container(
                    width: isSmall ? 42 : 48,
                    height: isSmall ? 42 : 48,

                    decoration:
                        BoxDecoration(
                      color:
                          AppTheme.lightBlue,
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child: Icon(
                      icon,
                      color:
                          AppTheme.primaryBlue,
                      size:
                          isSmall ? 21 : 24,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize:
                            isSmall ? 13 : 14,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // ==================================================
              // VALUE
              // ==================================================

              Text(
                value,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize:
                      isSmall ? 20 : 23,
                  fontWeight:
                      FontWeight.w800,
                  color:
                      AppTheme.darkBlue,
                ),
              ),

              const SizedBox(height: 10),

              // ==================================================
              // BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 38,

                child: OutlinedButton(
                  onPressed: onTap,

                  style:
                      OutlinedButton.styleFrom(
                    foregroundColor:
                        AppTheme.primaryBlue,

                    side: const BorderSide(
                      color:
                          AppTheme.primaryBlue,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        9,
                      ),
                    ),
                  ),

                  child: Text(
                    buttonText,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}