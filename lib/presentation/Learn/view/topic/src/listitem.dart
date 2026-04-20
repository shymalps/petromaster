import 'package:flutter/material.dart';

class ModernTopicCard extends StatelessWidget {
  final String topicName;
  final int videoCount;
  final int notesCount;
  final int audioCount;
  final int totalviewedcontent;
  final bool isLocked;
  final VoidCallback? onTap;

  const ModernTopicCard({
    super.key,
    required this.topicName,
    required this.videoCount,
    required this.notesCount,
    required this.audioCount,
    this.isLocked = false,
    this.onTap, required this.totalviewedcontent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric( vertical: 8),
        decoration: BoxDecoration(
          color: isLocked ? Colors.grey.shade200 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isLocked ? Colors.grey.shade300 : Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Topic Name
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          topicName,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: isLocked ? Colors.grey : Colors.black87,
                          ),
                        ),
                      ),
                      if (isLocked)
                        const Icon(Icons.lock_outline,
                            size: 18, color: Colors.grey),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Media Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMediaChip(
                        icon: Icons.play_circle_outline,
                        count: videoCount,
                        color: Colors.blueAccent,
                      ),
                      _buildMediaChip(
                        icon: Icons.article_outlined,
                        count: notesCount,
                        color: Colors.greenAccent,
                      ),
                      _buildMediaChip(
                        icon: Icons.headset_outlined,
                        count: audioCount,
                        color: Colors.orangeAccent,
                      ),
                      const Spacer(),
                      _buildCompletionBadge(),
                    ],
                  ),
                ],
              ),
            ),

            // Hover/Focus overlay
            if (!isLocked)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: onTap,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaChip({
    required IconData icon,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionBadge() {
    final completionPercent = _calculateCompletion();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getCompletionColor(completionPercent).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getCompletionColor(completionPercent),
          width: 1,
        ),
      ),
      child: Text(
        '${completionPercent}%',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _getCompletionColor(completionPercent),
        ),
      ),
    );
  }

  int _calculateCompletion() {
    final totalContent = videoCount + notesCount + audioCount;
    if (totalContent == 0) return 0;
    // Example: Assume 30% of videos, 50% of notes, 20% of audio completed
    return (totalviewedcontent /
            totalContent *
            100)
        .round();
  }

  Color _getCompletionColor(int percent) {
    if (percent < 30) return Colors.red;
    if (percent < 70) return Colors.orange;
    return Colors.green;
  }
}