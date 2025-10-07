import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/services/db_service.dart';

class RecentAttemptsPage extends StatefulWidget {
  const RecentAttemptsPage({super.key});

  @override
  State<RecentAttemptsPage> createState() => _RecentAttemptsPageState();
}

class _RecentAttemptsPageState extends State<RecentAttemptsPage> {
  List<Map<String, dynamic>> _attempts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAttempts();
  }

  Future<void> _loadAttempts() async {
    final attempts = await DBService.getRecentAttempts(limit: 10);
    setState(() {
      _attempts = attempts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Attempts (Debug)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Clear Log',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Log?'),
                  content: const Text(
                    'Are you sure you want to delete all log entries?',
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Clear'),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await DBService.clearActivityLog();
                setState(() {
                  _attempts = [];
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Activity log cleared')),
                );
              }
            },
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _attempts.isEmpty
          ? const Center(child: Text('No recent attempts found.'))
          : ListView.separated(
              itemCount: _attempts.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = _attempts[index];
                final isCorrect = item['wasCorrect'] == 1;
                final icon = isCorrect
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.cancel, color: Colors.red);

                return ListTile(
                  leading: icon,
                  title: Text(item['questionText'] ?? ''),
                  subtitle: Text('Your answer: ${item['answerText'] ?? ''}'),
                  trailing: Text(
                    item['timestamp'].toString().split('T').first,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
    );
  }
}
