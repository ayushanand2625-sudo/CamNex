import 'package:flutter/material.dart';

class TeacherHubGroupInfoScreen extends StatefulWidget {
  final String groupName;
  final String groupType;

  const TeacherHubGroupInfoScreen({
    super.key,
    required this.groupName,
    required this.groupType,
  });

  @override
  State<TeacherHubGroupInfoScreen> createState() =>
      _TeacherHubGroupInfoScreenState();
}

class _TeacherHubGroupInfoScreenState
    extends State<TeacherHubGroupInfoScreen> {
  // ==========================================================
  // CAMNEX ORANGE THEME
  // ==========================================================

  static const Color camnexOrange = Color(0xFFF59E0B);
  static const Color lightOrange = Color(0xFFFFF7ED);

  // ==========================================================
  // SEARCH
  // ==========================================================

  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = "";

  // ==========================================================
  // SAMPLE GROUP MEMBERS
  //
  // Later this will come from backend/database.
  // ==========================================================

  final List<Map<String, dynamic>> members = [
    {
      "id": "T001",
      "name": "Rahul Sharma",
      "role": "Class Teacher",
      "department": "Mathematics",
      "email": "rahul.sharma@school.com",
      "phone": "+91 9876543210",
      "isOnline": true,
    },
    {
      "id": "T002",
      "name": "Priya Singh",
      "role": "Subject Teacher",
      "department": "Science",
      "email": "priya.singh@school.com",
      "phone": "+91 9876543211",
      "isOnline": false,
    },
    {
      "id": "T003",
      "name": "Amit Kumar",
      "role": "Subject Teacher",
      "department": "English",
      "email": "amit.kumar@school.com",
      "phone": "+91 9876543212",
      "isOnline": true,
    },
    {
      "id": "T004",
      "name": "Neha Verma",
      "role": "Subject Teacher",
      "department": "Mathematics",
      "email": "neha.verma@school.com",
      "phone": "+91 9876543213",
      "isOnline": false,
    },
    {
      "id": "T005",
      "name": "Vivek Singh",
      "role": "Subject Teacher",
      "department": "Social Science",
      "email": "vivek.singh@school.com",
      "phone": "+91 9876543214",
      "isOnline": true,
    },
    {
      "id": "T006",
      "name": "Ananya Gupta",
      "role": "Subject Teacher",
      "department": "Hindi",
      "email": "ananya.gupta@school.com",
      "phone": "+91 9876543215",
      "isOnline": false,
    },
  ];

  // ==========================================================
  // FILTERED MEMBERS
  // ==========================================================

  List<Map<String, dynamic>> get filteredMembers {
    if (searchQuery.trim().isEmpty) {
      return members;
    }

    final query = searchQuery.toLowerCase().trim();

    return members.where((member) {
      final name =
          member["name"].toString().toLowerCase();

      final role =
          member["role"].toString().toLowerCase();

      final department =
          member["department"].toString().toLowerCase();

      final email =
          member["email"].toString().toLowerCase();

      return name.contains(query) ||
          role.contains(query) ||
          department.contains(query) ||
          email.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isTablet = width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,

        title: const Text(
          "Group Info",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: _showGroupOptions,
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 40 : 16,
            vertical: 18,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ==================================================
              // GROUP HEADER
              // ==================================================

              _buildGroupHeader(),

              const SizedBox(height: 20),

              // ==================================================
              // GROUP DESCRIPTION
              // ==================================================

              _buildGroupDescription(),

              const SizedBox(height: 22),

              // ==================================================
              // SEARCH MEMBERS
              // ==================================================

              _buildSearchBar(),

              const SizedBox(height: 22),

              // ==================================================
              // MEMBERS TITLE
              // ==================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Members",
                    style: TextStyle(
                      fontSize: isTablet ? 21 : 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: lightOrange,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: Text(
                      "${members.length} Members",
                      style: const TextStyle(
                        color: camnexOrange,
                        fontWeight:
                            FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ==================================================
              // MEMBER LIST
              // ==================================================

              if (filteredMembers.isEmpty)
                _buildEmptyState()
              else
                ...filteredMembers.map(
                  (member) =>
                      _buildMemberCard(member),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // GROUP HEADER
  // ==========================================================

  Widget _buildGroupHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF7ED),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: Colors.orange.shade100,
        ),
      ),

      child: Column(
        children: [
          // ==================================================
          // GROUP ICON
          // ==================================================

          Container(
            width: 76,
            height: 76,

            decoration: BoxDecoration(
              color: camnexOrange,
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color:
                      camnexOrange.withValues(
                    alpha: 0.22,
                  ),
                  blurRadius: 15,
                  offset:
                      const Offset(0, 6),
                ),
              ],
            ),

            child: const Icon(
              Icons.groups_rounded,
              color: Colors.white,
              size: 38,
            ),
          ),

          const SizedBox(height: 14),

          // ==================================================
          // GROUP NAME
          // ==================================================

          Text(
            widget.groupName,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),

          const SizedBox(height: 6),

          // ==================================================
          // GROUP TYPE
          // ==================================================

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(20),

              border: Border.all(
                color: Colors.orange.shade100,
              ),
            ),

            child: Text(
              widget.groupType,
              style: const TextStyle(
                fontSize: 12,
                fontWeight:
                    FontWeight.w600,
                color: camnexOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // GROUP DESCRIPTION
  // ==========================================================

  Widget _buildGroupDescription() {
    String description;

    if (widget.groupType
        .toLowerCase()
        .contains("class")) {
      description =
          "All teachers assigned to this class can "
          "communicate with each other through this group.";
    } else if (widget.groupType
        .toLowerCase()
        .contains("department")) {
      description =
          "All teachers belonging to this subject "
          "department can communicate through this group.";
    } else {
      description =
          "Teachers in this group can communicate "
          "and share information with each other.";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Container(
            width: 40,
            height: 40,

            decoration: BoxDecoration(
              color: lightOrange,
              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: const Icon(
              Icons.info_outline,
              color: camnexOrange,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SEARCH BAR
  // ==========================================================

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,

      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },

      decoration: InputDecoration(
        hintText:
            "Search members...",

        prefixIcon: const Icon(
          Icons.search,
        ),

        suffixIcon:
            searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      searchController.clear();

                      setState(() {
                        searchQuery = "";
                      });
                    },

                    icon: const Icon(
                      Icons.close,
                    ),
                  )
                : null,

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),

          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),

          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),

          borderSide:
              const BorderSide(
            color: camnexOrange,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // MEMBER CARD
  // ==========================================================

  Widget _buildMemberCard(
    Map<String, dynamic> member,
  ) {
    final name =
        member["name"].toString();

    final role =
        member["role"].toString();

    final department =
        member["department"].toString();

    final isOnline =
        member["isOnline"] == true;

    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.025,
            ),
            blurRadius: 8,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(16),

        onTap: () {
          _openMemberProfile(member);
        },

        child: Padding(
          padding:
              const EdgeInsets.all(14),

          child: Row(
            children: [
              // ==================================================
              // AVATAR
              // ==================================================

              Stack(
                children: [
                  CircleAvatar(
                    radius: 26,

                    backgroundColor:
                        lightOrange,

                    child: Text(
                      name
                          .substring(0, 1)
                          .toUpperCase(),

                      style:
                          const TextStyle(
                        fontSize: 19,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            camnexOrange,
                      ),
                    ),
                  ),

                  if (isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,

                      child: Container(
                        width: 13,
                        height: 13,

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.green,
                          shape:
                              BoxShape.circle,

                          border:
                              Border.all(
                            color:
                                Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 13),

              // ==================================================
              // MEMBER INFORMATION
              // ==================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(
                        fontSize: 15,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      role,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 12,
                        color:
                            Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      department,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 11,
                        color:
                            Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // ARROW
              // ==================================================

              const Icon(
                Icons
                    .arrow_forward_ios_rounded,
                size: 15,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),

      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,

            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons
                  .person_search_outlined,
              size: 32,
              color: Colors.grey.shade500,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "No members found",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Try searching with another name, "
            "role or department.",
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MEMBER PROFILE
  // ==========================================================

  void _openMemberProfile(
    Map<String, dynamic> member,
  ) {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {
        return _memberProfileSheet(member);
      },
    );
  }

  // ==========================================================
  // MEMBER PROFILE SHEET
  // ==========================================================

  Widget _memberProfileSheet(
    Map<String, dynamic> member,
  ) {
    final name =
        member["name"].toString();

    final role =
        member["role"].toString();

    final department =
        member["department"].toString();

    final email =
        member["email"].toString();

    final phone =
        member["phone"].toString();

    final isOnline =
        member["isOnline"] == true;

    return SafeArea(
      child: Container(
        width: double.infinity,

        padding:
            const EdgeInsets.fromLTRB(
          20,
          10,
          20,
          25,
        ),

        decoration: const BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            // ==================================================
            // HANDLE
            // ==================================================

            Container(
              width: 45,
              height: 5,

              margin:
                  const EdgeInsets.only(
                bottom: 20,
              ),

              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius:
                    BorderRadius.circular(10),
              ),
            ),

            // ==================================================
            // PROFILE
            // ==================================================

            Stack(
              children: [
                CircleAvatar(
                  radius: 42,

                  backgroundColor:
                      lightOrange,

                  child: Text(
                    name
                        .substring(0, 1)
                        .toUpperCase(),

                    style:
                        const TextStyle(
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                      color: camnexOrange,
                    ),
                  ),
                ),

                if (isOnline)
                  Positioned(
                    right: 2,
                    bottom: 3,

                    child: Container(
                      width: 17,
                      height: 17,

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.green,
                        shape:
                            BoxShape.circle,

                        border:
                            Border.all(
                          color:
                              Colors.white,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              name,
              style: const TextStyle(
                fontSize: 21,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              role,
              style: const TextStyle(
                fontSize: 13,
                color: camnexOrange,
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // INFORMATION
            // ==================================================

            _profileInfoRow(
              Icons.business_outlined,
              "Department",
              department,
            ),

            _profileInfoRow(
              Icons.email_outlined,
              "Email",
              email,
            ),

            _profileInfoRow(
              Icons.phone_outlined,
              "Phone",
              phone,
            ),

            const SizedBox(height: 10),

            // ==================================================
            // CLOSE
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      camnexOrange,

                  foregroundColor:
                      Colors.white,

                  elevation: 0,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      13,
                    ),
                  ),
                ),

                child: const Text(
                  "Close",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PROFILE INFO ROW
  // ==========================================================

  Widget _profileInfoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      padding:
          const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,

            decoration: BoxDecoration(
              color: lightOrange,
              borderRadius:
                  BorderRadius.circular(9),
            ),

            child: Icon(
              icon,
              size: 19,
              color: camnexOrange,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color:
                        Colors.grey.shade500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // GROUP OPTIONS
  // ==========================================================

  void _showGroupOptions() {
    showModalBottomSheet(
      context: context,

      backgroundColor:
          Colors.transparent,

      builder: (context) {
        return SafeArea(
          child: Container(
            padding:
                const EdgeInsets.all(20),

            decoration:
                const BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [
                Container(
                  width: 45,
                  height: 5,

                  margin:
                      const EdgeInsets.only(
                    bottom: 20,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),
                ),

                ListTile(
                  leading: Container(
                    width: 42,
                    height: 42,

                    decoration:
                        BoxDecoration(
                      color: lightOrange,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),

                    child: const Icon(
                      Icons.search,
                      color:
                          camnexOrange,
                    ),
                  ),

                  title: const Text(
                    "Search Members",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);

                    FocusScope.of(context)
                        .requestFocus(
                      FocusNode(),
                    );
                  },
                ),

                ListTile(
                  leading: Container(
                    width: 42,
                    height: 42,

                    decoration:
                        BoxDecoration(
                      color: lightOrange,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),

                    child: const Icon(
                      Icons.info_outline,
                      color:
                          camnexOrange,
                    ),
                  ),

                  title: const Text(
                    "Group Details",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);

                    _showGroupDetails();
                  },
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // GROUP DETAILS
  // ==========================================================

  void _showGroupDetails() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),

          title: const Text(
            "Group Details",
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              _detailItem(
                "Group",
                widget.groupName,
              ),

              _detailItem(
                "Type",
                widget.groupType,
              ),

              _detailItem(
                "Members",
                "${members.length}",
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                "Close",
                style: TextStyle(
                  color: camnexOrange,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // DETAIL ITEM
  // ==========================================================

  Widget _detailItem(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 80,

            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color:
                    Colors.grey.shade600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}