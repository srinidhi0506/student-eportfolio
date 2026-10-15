import 'package:flutter/material.dart';
import '../models/activity.dart';

// DATA: edit this list to change the Extra-Curricular tab.
const List<Activity> activities = [
  Activity(
    title: 'NSS Activities',
    description: 'Community service and social awareness drives.',
    year: '2025',
    icon: Icons.volunteer_activism,
  ),
  Activity(
    title: 'Hackathons',
    description: 'Smart India Hackathon – Internal Finalist.',
    year: '2025',
    icon: Icons.emoji_events,
  ),
  Activity(
    title: 'Technical Workshops',
    description: 'Hands-on workshops on Generative AI and web development.',
    year: '2025',
    icon: Icons.school,
  ),
  Activity(
    title: 'Coding Competitions',
    description: 'Solved 500+ DSA problems on LeetCode and Codeforces.',
    year: '2025',
    icon: Icons.code,
  ),
  Activity(
    title: 'Mentorship Programs',
    description: 'Mentee at Codess.Cafe – sessions, coding challenges, peer learning.',
    year: '2025',
    icon: Icons.groups,
  ),
  Activity(
    title: 'College Events',
    description: 'Participation and volunteering in college fests and events.',
    year: '2025',
    icon: Icons.celebration,
  ),
];
