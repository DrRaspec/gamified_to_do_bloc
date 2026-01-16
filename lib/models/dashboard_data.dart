import 'dart:convert';

class DashboardData {
  final double? level;
  final double? currentXp;
  final double? xpRequired;
  final int? tasksToday;
  final int? currentStreak;
  final double? totalXp;
  final int? completedTask;

  DashboardData({
    this.level,
    this.currentXp,
    this.xpRequired,
    this.tasksToday,
    this.currentStreak,
    this.totalXp,
    this.completedTask,
  });

  DashboardData copyWith({
    double? level,
    double? currentXp,
    double? xpRequired,
    int? tasksToday,
    int? currentStreak,
    double? totalXp,
    int? completedTask,
  }) {
    return DashboardData(
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      xpRequired: xpRequired ?? this.xpRequired,
      tasksToday: tasksToday ?? this.tasksToday,
      currentStreak: currentStreak ?? this.currentStreak,
      totalXp: totalXp ?? this.totalXp,
      completedTask: completedTask ?? this.completedTask,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'level': level,
      'currentXp': currentXp,
      'xpRequired': xpRequired,
      'tasksToday': tasksToday,
      'currentStreak': currentStreak,
      'totalXp': totalXp,
      'completedTask': completedTask,
    };
  }

  factory DashboardData.fromMap(Map<String, dynamic> map) {
    return DashboardData(
      level: (map['level'] as num?)?.toDouble(),
      currentXp: (map['currentXp'] as num?)?.toDouble(),
      xpRequired: (map['xpRequired'] as num?)?.toDouble(),
      tasksToday: map['tasksToday'] != null ? map['tasksToday'] as int : null,
      currentStreak: map['currentStreak'] != null
          ? map['currentStreak'] as int
          : null,
      totalXp: (map['totalXp'] as num?)?.toDouble(),
      completedTask: map['completedTask'] != null
          ? map['completedTask'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardData.fromJson(String source) =>
      DashboardData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashboardData(level: $level, currentXp: $currentXp, xpRequired: $xpRequired, tasksToday: $tasksToday, currentStreak: $currentStreak, totalXp: $totalXp, completedTask: $completedTask)';
  }

  @override
  bool operator ==(covariant DashboardData other) {
    if (identical(this, other)) return true;

    return other.level == level &&
        other.currentXp == currentXp &&
        other.xpRequired == xpRequired &&
        other.tasksToday == tasksToday &&
        other.currentStreak == currentStreak &&
        other.totalXp == totalXp &&
        other.completedTask == completedTask;
  }

  @override
  int get hashCode {
    return level.hashCode ^
        currentXp.hashCode ^
        xpRequired.hashCode ^
        tasksToday.hashCode ^
        currentStreak.hashCode ^
        totalXp.hashCode ^
        completedTask.hashCode;
  }
}
