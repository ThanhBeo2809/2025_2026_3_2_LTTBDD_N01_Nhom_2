import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  static const _members = [
    _TeamMember(
      name: 'Phạm Trung Thành',
      studentId: '24100326',
      roleVi: 'Trưởng nhóm',
      roleEn: 'Team leader',
      initials: 'TT',
      color: Color(0xFFE85D3F),
    ),
    _TeamMember(
      name: 'Nguyễn Việt Cường',
      studentId: '24100397',
      roleVi: 'Thành viên',
      roleEn: 'Member',
      initials: 'VC',
      color: Color(0xFF2F8F6B),
    ),
    _TeamMember(
      name: 'Đỗ Duyên Cường',
      studentId: '24100332',
      roleVi: 'Thành viên',
      roleEn: 'Member',
      initials: 'DC',
      color: Color(0xFFF2A93B),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(strings.teamInformation)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: Column(
              children: [
                _ProjectHeader(strings: strings),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    strings.text('Thành viên nhóm', 'Team members'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _members.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 320,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => _MemberCard(
                    member: _members[index],
                    isVietnamese: strings.isVietnamese,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.school_outlined),
                          ),
                          title: Text(
                            strings.text(
                              'Giảng viên hướng dẫn',
                              'Course instructor',
                            ),
                          ),
                          subtitle: const Text('Nguyễn Xuân Quế'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.code_outlined),
                          ),
                          title: Text(strings.text('Công nghệ', 'Technology')),
                          subtitle: const Text(
                            'Flutter • Dart • Material Design 3 • GitHub',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectHeader extends StatelessWidget {
  const _ProjectHeader({required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Text('🍳', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 12),
          Text(
            strings.appName,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            strings.text(
              'Ứng dụng di động chia sẻ công thức nấu ăn',
              'A recipe sharing application',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              const Chip(label: Text('LTTBDD • N01')),
              Chip(label: Text(strings.text('Nhóm 2', 'Group 2'))),
              const Chip(label: Text('2025–2026')),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member, required this.isVietnamese});

  final _TeamMember member;
  final bool isVietnamese;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: member.color,
              foregroundColor: Colors.white,
              child: Text(
                member.initials,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              member.name,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 5),
            Text(member.studentId),
            const Spacer(),
            Chip(label: Text(isVietnamese ? member.roleVi : member.roleEn)),
          ],
        ),
      ),
    );
  }
}

class _TeamMember {
  const _TeamMember({
    required this.name,
    required this.studentId,
    required this.roleVi,
    required this.roleEn,
    required this.initials,
    required this.color,
  });

  final String name;
  final String studentId;
  final String roleVi;
  final String roleEn;
  final String initials;
  final Color color;
}
