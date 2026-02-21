# Agent X - Adaptive Learning & Personality Platform

## Overview

**Agent X** is an intelligent, personality-aware learning platform that moves users from "Unaware" to "Mastery" through:

- **Diagnostic Interview**: 4-question recursive assessment (no multiple choice)
- **Profile Generation**: Personality archetype detection + skill gap analysis
- **Adaptive Roadmap**: Weekly tasks tailored to your learning style
- **Multi-panel Dashboard**: Chat history, roadmap, and personality metrics

---

## 🚀 Quick Start

### Prerequisites
- Node.js v16+
- npm or yarn
- Supabase account

### Installation
```bash
npm install
npm run dev
```

This starts both frontend (3000) and backend (5000).

### Environment Setup
Create `server/.env`:
```env
PORT=5000
SUPABASE_URL=your-url
SUPABASE_API_KEY=your-key
```

Create `client/.env.local`:
```env
VITE_API_URL=http://localhost:5000/api
```

---

## 🎯 Architecture

### Backend (Node.js/Express)
- Interview logic with 4-question assessment
- Profile generation with archetype detection
- Supabase integration for persistence
- RESTful API endpoints

### Frontend (React/Vite)
- Login screen
- Interactive interview component
- Profile reveal with animations
- 3-panel dashboard (chat, roadmap, metrics)

### Data Flow
User → Login → Interview (4 Qs) → Scoring → Profile Generation → Dashboard

---

## 📊 Core Features

### Phase 1: Diagnostic Interview
Tests 4 dimensions:
1. **Resilience** (Stoic vs Emotional)
2. **Execution Style** (Brutalist vs Analytical)
3. **Academic Baseline** (Beginner to Advanced)
4. **Self-Awareness** (What causes failures?)

### Phase 2: Personality Archetypes
- The Stoic Architect
- The Brutalist Executor
- The Analytical Strategist
- The Pragmatic Builder

### Phase 3: Adaptive Roadmap
- Core Task (must do)
- Stretcher (if feeling challenged)
- Reflection (Stoic check-in)

### Phase 4: Dashboard
- Left: Chat history with mentor
- Center: Weekly roadmap
- Right: "The Mirror" (metrics & profile)

---

## 📈 Upcoming Features

- Friend-Sync (360° feedback integration)
- Adaptive task simplification on missed goals
- Multi-week progression tracking
- Advanced analytics

---

## 🆘 Setup Guide

See README-SETUP.md for detailed installation instructions and Supabase table definitions.

**Built with ❤️ by the Agent X Team**
