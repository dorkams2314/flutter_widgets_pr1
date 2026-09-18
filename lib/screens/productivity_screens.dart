import 'package:flutter/material.dart';

const _purple = Color(0xFF776BEE);

class WeeklyPlannerScreen extends StatefulWidget {
  const WeeklyPlannerScreen({super.key});

  @override
  State<WeeklyPlannerScreen> createState() => _WeeklyPlannerScreenState();
}

class _WeeklyPlannerScreenState extends State<WeeklyPlannerScreen> {
  final _completed = <int>{};
  static const _tasks = [
    ('Design 2 App Screens', 'Crypto Wallet App', 'Mon, 10 July 2022'),
    ('Design Homepage', 'Website Project', 'Wed, 12 July 2022'),
    ('Create User Flow', 'Mobile App', 'Fri, 14 July 2022'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back_rounded),
                            ),
                            const CircleAvatar(
                              radius: 21,
                              backgroundColor: Color(0xFFFFD7C2),
                              child: Text(
                                'DS',
                                style: TextStyle(
                                  color: Color(0xFF67463C),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good Evening!',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Dan Smith',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            _RoundIcon(icon: Icons.search_rounded),
                            const SizedBox(width: 9),
                            const _RoundIcon(
                              icon: Icons.notifications_none_rounded,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        _SectionTitle(
                          title: 'My Weekly Tasks',
                          subtitle: '18 Tasks Pending',
                          onAdd: () => _showNewTask(context),
                        ),
                        const SizedBox(height: 19),
                        SizedBox(
                          height: 218,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              _ProjectCard(
                                label: 'UI/UX Design',
                                priority: 'High',
                                title: 'Create a\nLanding Page',
                                date: 'Mon, 12 July 2022',
                                accent: _purple,
                                people: ['AM', 'KS', '3+'],
                              ),
                              SizedBox(width: 14),
                              _ProjectCard(
                                label: 'Development',
                                priority: 'Low',
                                title: 'Develop a\nWebsite',
                                date: 'Mon, 30 July 2022',
                                accent: Color(0xFFEBA62B),
                                people: ['JM', 'EL', '2+'],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        _SectionTitle(
                          title: "Today's Tasks",
                          subtitle: '18 Tasks Pending',
                          onAdd: () => _showNewTask(context),
                        ),
                        const SizedBox(height: 17),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
                  sliver: SliverList.separated(
                    itemCount: _tasks.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 13),
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      final completed = _completed.contains(index);
                      return _TaskCard(
                        title: task.$1,
                        subtitle: task.$2,
                        date: task.$3,
                        completed: completed,
                        onTap: () => setState(() {
                          completed
                              ? _completed.remove(index)
                              : _completed.add(index);
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNewTask(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          22,
          4,
          22,
          22 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Task',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            const TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Task name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Icon(icon, size: 21),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
    required this.onAdd,
  });
  final String title;
  final String subtitle;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded, size: 22),
        ),
        Container(width: 1, height: 30, color: Colors.grey.shade300),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.add_rounded, size: 27),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.label,
    required this.priority,
    required this.title,
    required this.date,
    required this.accent,
    required this.people,
  });

  final String label;
  final String priority;
  final String title;
  final String date;
  final Color accent;
  final List<String> people;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  label,
                  style: TextStyle(fontSize: 10, color: accent),
                ),
              ),
              const Spacer(),
              Text(
                priority,
                style: TextStyle(
                  color: priority == 'High'
                      ? const Color(0xFFEA7481)
                      : const Color(0xFF32B77D),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 33,
            child: Stack(
              children: [
                for (var i = 0; i < people.length; i++)
                  Positioned(
                    left: i * 24,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: i == people.length - 1
                          ? const Color(0xFFFFAE4C)
                          : [
                              const Color(0xFF6E93A0),
                              const Color(0xFFD29B87),
                            ][i],
                      child: Text(
                        people[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 17),
              const SizedBox(width: 7),
              Text(
                date,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.completed,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String date;
  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: completed ? 0.55 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(17, 16, 15, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            decoration: completed
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: completed
                        ? _purple
                        : const Color(0xFFE8EBFF),
                    child: Icon(
                      Icons.check_rounded,
                      size: 18,
                      color: completed ? Colors.white : _purple,
                    ),
                  ),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 15),
                  const SizedBox(width: 7),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                  ),
                  const Spacer(),
                  const _SmallAvatar(label: 'AM', color: Color(0xFF7D9F9D)),
                  const _SmallAvatar(label: 'KS', color: Color(0xFFC99582)),
                  const _SmallAvatar(label: '1+', color: Color(0xFFFFAD4B)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallAvatar extends StatelessWidget {
  const _SmallAvatar({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      margin: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 7,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
