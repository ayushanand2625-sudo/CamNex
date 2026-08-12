import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool notificationsEnabled = true;
  bool emailUpdatesEnabled = true;
  bool soundEnabled = true;

  @override
  Widget build(BuildContext context) {

    final themeProvider =
        Provider.of<ThemeProvider>(context);

    final theme =
        Theme.of(context);

    final colors =
        theme.colorScheme;

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ==================================================
              // PROFILE
              // ==================================================

              _buildProfileCard(
                context,
              ),

              const SizedBox(
                height: 25,
              ),

              _sectionTitle(
                context,
                "Preferences",
              ),

              const SizedBox(
                height: 10,
              ),

              // ==================================================
              // NOTIFICATIONS
              // ==================================================

              _buildSwitchTile(
                context: context,
                icon:
                    Icons.notifications_outlined,
                title:
                    "Push Notifications",
                subtitle:
                    "Get alerts for rewards, updates, and messages",
                value:
                    notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled =
                        value;
                  });
                },
              ),

              // ==================================================
              // EMAIL
              // ==================================================

              _buildSwitchTile(
                context: context,
                icon:
                    Icons.email_outlined,
                title:
                    "Email Updates",
                subtitle:
                    "Receive reward and account emails",
                value:
                    emailUpdatesEnabled,
                onChanged: (value) {
                  setState(() {
                    emailUpdatesEnabled =
                        value;
                  });
                },
              ),

              // ==================================================
              // DARK MODE
              // ==================================================

              _buildSwitchTile(
                context: context,
                icon:
                    Icons.dark_mode_outlined,
                title:
                    "Dark Mode",
                subtitle:
                    themeProvider.isDarkMode
                        ? "Dark appearance is enabled"
                        : "Use dark appearance across CamNex",
                value:
                    themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider
                      .toggleTheme(value);
                },
              ),

              // ==================================================
              // SOUND
              // ==================================================

              _buildSwitchTile(
                context: context,
                icon:
                    Icons.volume_up_outlined,
                title:
                    "Sound",
                subtitle:
                    "Play app sounds and feedback",
                value:
                    soundEnabled,
                onChanged: (value) {
                  setState(() {
                    soundEnabled =
                        value;
                  });
                },
              ),

              const SizedBox(
                height: 25,
              ),

              // ==================================================
              // ACCOUNT
              // ==================================================

              _sectionTitle(
                context,
                "Account",
              ),

              const SizedBox(
                height: 10,
              ),

              _buildActionTile(
                context: context,
                icon:
                    Icons.person_outline,
                title:
                    "Edit Profile",
                subtitle:
                    "Update student and parent details",
                onTap: () {},
              ),

              _buildActionTile(
                context: context,
                icon:
                    Icons.lock_outline,
                title:
                    "Change Password",
                subtitle:
                    "Update your login password",
                onTap: () {},
              ),

              _buildActionTile(
                context: context,
                icon:
                    Icons.privacy_tip_outlined,
                title:
                    "Privacy",
                subtitle:
                    "Manage privacy and data settings",
                onTap: () {},
              ),

              const SizedBox(
                height: 25,
              ),

              // ==================================================
              // SUPPORT
              // ==================================================

              _sectionTitle(
                context,
                "Support",
              ),

              const SizedBox(
                height: 10,
              ),

              _buildActionTile(
                context: context,
                icon:
                    Icons.help_outline,
                title:
                    "Help Center",
                subtitle:
                    "FAQs, guides, and support",
                onTap: () {},
              ),

              _buildActionTile(
                context: context,
                icon:
                    Icons.feedback_outlined,
                title:
                    "Send Feedback",
                subtitle:
                    "Tell us what needs improvement",
                onTap: () {},
              ),

              _buildActionTile(
                context: context,
                icon:
                    Icons.info_outline,
                title:
                    "About CamNex",
                subtitle:
                    "App version and information",
                onTap: () {},
              ),

              const SizedBox(
                height: 25,
              ),

              // ==================================================
              // LOGOUT
              // ==================================================

              _buildLogoutButton(
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE CARD
  // ============================================================

  Widget _buildProfileCard(
      BuildContext context) {

    final theme =
        Theme.of(context);

    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(20),

      decoration:
          BoxDecoration(
        color:
            theme.cardColor,

        borderRadius:
            BorderRadius.circular(18),

        border:
            Border.all(
          color:
              theme.dividerColor,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha:
                  theme.brightness ==
                          Brightness.dark
                      ? 0.25
                      : 0.05,
            ),
            blurRadius: 10,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 28,

            backgroundColor:
                theme.colorScheme
                    .primary
                    .withValues(
                      alpha: 0.12,
                    ),

            child: Text(
              "A",

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,

                color:
                    theme.colorScheme
                        .primary,
              ),
            ),
          ),

          const SizedBox(
            width: 15,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  "Ayush Sharma",

                  style:
                      theme.textTheme
                          .titleMedium,
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  "Parent / Student Account",

                  style:
                      theme.textTheme
                          .bodySmall,
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(
      BuildContext context,
      String title) {

    return Padding(
      padding:
          const EdgeInsets.only(
        left: 4,
      ),

      child: Text(
        title,

        style:
            Theme.of(context)
                .textTheme
                .titleMedium,
      ),
    );
  }

  // ============================================================
  // SWITCH TILE
  // ============================================================

  Widget _buildSwitchTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>
        onChanged,
  }) {

    final theme =
        Theme.of(context);

    return Card(
      elevation: 0,

      margin:
          const EdgeInsets.only(
        top: 10,
      ),

      child: SwitchListTile(
        secondary: Icon(
          icon,

          color:
              theme.colorScheme
                  .primary,
        ),

        title: Text(
          title,

          style: const TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        subtitle: Text(
          subtitle,
        ),

        value: value,

        onChanged: onChanged,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 5,
        ),
      ),
    );
  }

  // ============================================================
  // ACTION TILE
  // ============================================================

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {

    final theme =
        Theme.of(context);

    return Card(
      elevation: 0,

      margin:
          const EdgeInsets.only(
        top: 10,
      ),

      child: ListTile(
        leading: Icon(
          icon,

          color:
              theme.colorScheme
                  .primary,
        ),

        title: Text(
          title,

          style: const TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        subtitle: Text(
          subtitle,
        ),

        trailing:
            const Icon(
          Icons.chevron_right,
        ),

        onTap: onTap,
      ),
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Widget _buildLogoutButton(
      BuildContext context) {

    return SizedBox(
      width: double.infinity,

      child:
          OutlinedButton.icon(
        onPressed: () {},

        icon:
            const Icon(
          Icons.logout,
        ),

        label:
            const Text(
          "Log Out",
        ),

        style:
            OutlinedButton.styleFrom(
          foregroundColor:
              Theme.of(context)
                  .colorScheme
                  .error,

          side:
              BorderSide(
            color:
                Theme.of(context)
                    .colorScheme
                    .error,
          ),

          padding:
              const EdgeInsets
                  .symmetric(
            vertical: 14,
          ),

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),
        ),
      ),
    );
  }
}