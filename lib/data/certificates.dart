import 'package:flutter/material.dart';
import '../models/certificate.dart';

// DATA: edit this list to add / remove / change certificates.
// The UI is built from this list automatically (no UI change needed).
const List<Certificate> certificates = [
  Certificate(
    title: 'Gen AI Exchange Program',
    organization: 'Google Cloud / Hack2Skill',
    year: '2025',
    description:
        'Gen AI Academy: Vertex AI, Gemini APIs, Imagen, Streamlit and Multimodal RAG.',
    icon: Icons.psychology,
    imagePath: 'assets/images/certificate1.jpg',
  ),
  Certificate(
    title: 'Vertex AI Skill Badge – Prompt Design',
    organization: 'Google Cloud',
    year: '2026',
    description: 'Prompt design skills on Vertex AI',
    icon: Icons.military_tech,
    imagePath: 'assets/images/badge1.jpeg',
  ),
  Certificate(
    title: 'Codess.Cafe Mentorship Program',
    organization: 'Codess.Cafe',
    year: '2025',
    description:
        'Selected as a mentee (2K+ applicants) in a national mentorship program for women in tech.',
    icon: Icons.diversity_3,
    imagePath: 'assets/images/certificate2.jpg',
  ),
  Certificate(
    title: 'LPF Scholarship',
    organization: 'Lila Poonawalla Foundation',
    year: '—',
    description: 'Merit scholarship awarded by the Lila Poonawalla Foundation.',
    icon: Icons.volunteer_activism,
  ),
  Certificate(
    title: 'CS302PC: Data Structures',
    organization: 'CodeChef',
    year: '2025',
    description: 'Completed all lessons and projects. Certificate ID: 9e34a3c.',
    icon: Icons.account_tree,
    imagePath:'assets/images/certificate3.jpeg',
  ),
  Certificate(
    title: 'Object Oriented Programming Through Java',
    organization: 'CodeChef',
    year: '2025',
    description: 'Completed all lessons and projects. Certificate ID: beaf5a9.',
    icon: Icons.code,
    imagePath:'assets/images/certificate4.jpeg',
  ),
];
