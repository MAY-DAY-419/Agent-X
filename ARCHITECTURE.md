# Agent X Architecture & System Design

## System Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER JOURNEY                              │
└─────────────────────────────────────────────────────────────────┘

1. LOGIN SCREEN
   ┌──────────────────┐
   │  Enter User ID   │
   │  "learner_123"   │
   └────────┬─────────┘
            │ Click "Start"
            ▼
2. INTERVIEW QUESTIONS (4 questions, 1 at a time)
   ┌──────────────────────────────┐
   │ Q1: How do you handle        │
   │     competing priorities?    │
   │ [Option A] [Option B] [C]    │
   └────────┬─────────────────────┘
            │ Select answer
            ▼
   (Repeat for Q2, Q3, Q4)
   
            ▼
3. PROFILE GENERATION (AI Analysis)
   ┌─────────────────────────────────┐
   │ "The Stoic Architect"           │
   │ Primary Gap: Discipline         │
   │ Tone: Encouraging               │
   └────────┬────────────────────────┘
            │ Save to Supabase
            ▼
4. DASHBOARD (3-Panel Interface)
   ┌─────────────┬────────────────────┬──────────────┐
   │   CHAT      │    ROADMAP          │    MIRROR    │
   │             │                     │              │
   │ AI Chat     │ ✅ Core Task        │ Archetype    │
   │ History     │ 🔥 Stretcher        │ Scores       │
   │             │ 💭 Reflection       │ Gaps         │
   └─────────────┴────────────────────┴──────────────┘
```

---

## Technology Stack

### Backend (Node.js)

```
Express.js (Server Framework)
  ├─ /api/interview/* (Interview endpoints)
  │   ├─ GET /questions → Return 4 questions
  │   └─ POST /submit → Score answers
  │
  ├─ /api/profile/* (Profile endpoints)
  │   ├─ POST /generate → Create profile from scores
  │   ├─ POST /save → Save to Supabase
  │   └─ GET /:userId → Retrieve profile
  │
  └─ Interview Logic Engine
      ├─ scoreInterviewResponse() → Calculate scores
      └─ generateProfile() → Determine archetype
```

### Frontend (React + Vite)

```
React App
  ├─ <Login /> → User ID entry
  ├─ <Interview /> → Interactive questions
  ├─ <ProfileGenerator /> → Reveal animation
  ├─ <Dashboard /> → 3-panel main interface
  │   ├─ Left Panel (Chat)
  │   ├─ Center Panel (Roadmap)
  │   └─ Right Panel (The Mirror)
  │
  └─ Styling (Vite CSS)
      ├─ Global styles
      ├─ Component-specific CSS
      └─ Responsive design
```

### Database (Supabase/PostgreSQL)

```
Profiles Table
├─ user_id (PK)
├─ archetype
├─ primary_skill_gap
├─ tone_preference
├─ resilience_score
└─ generated_at

Roadmaps Table
├─ user_id (FK)
├─ week
├─ theme
├─ core_task
├─ stretcher
└─ reflection

Interview_Responses Table
├─ user_id
├─ responses (JSON)
├─ scores (JSON)
└─ created_at
```

---

## Interview Scoring Algorithm

```typescript
Input: [Q1 Answer, Q2 Answer, Q3 Answer, Q4 Answer]

Scoring Process:
  ├─ Q1 (Resilience) → Score 2-5
  │   ├─ Stoic → 5 (prioritizes people)
  │   ├─ Pragmatic → 4 (splits priorities)
  │   └─ Emotional → 2 (paralyzed)
  │
  ├─ Q2 (Execution Style) → Score 3-5
  │   ├─ Brutalist → 5 (jump in, iterate)
  │   ├─ Analytical → 4 (plan, then execute)
  │   └─ Hybrid → 3 (mix of both)
  │
  ├─ Q3 (Academic Baseline) → Score 1-5
  │   ├─ Beginner (1-2)
  │   ├─ Intermediate (3)
  │   └─ Advanced (4-5)
  │
  └─ Q4 (Self-Awareness) → Pattern
      ├─ Discipline ("I procrastinate") → Pattern
      ├─ Strategy ("I plan wrong")
      └─ External ("Life got in the way")

Output: UserProfile {
  archetype: "The Stoic Architect",
  primary_skill_gap: "Discipline & Consistency",
  tone_preference: "encouraging",
  resilience_score: 5,
  execution_style: "pragmatic"
}
```

---

## Archetype Determination Matrix

```
        High Resilience + High Execution
                    ↓
           "The Stoic Architect"
    ✓ Strategic, calm under pressure
    ✓ Prioritizes people & long-term
    ✗ Can overthink decisions
    
High Execution + High Self-Awareness
                    ↓
        "The Brutalist Executor"
    ✓ Action-first, learns fast
    ✓ Iterates and experiments
    ✗ Risk of burnout
    
High Planning + Methodical Approach
                    ↓
      "The Analytical Strategist"
    ✓ Precise planning, systems-first
    ✓ Structured approach
    ✗ Analysis paralysis
    
Balanced Reflection + Action
                    ↓
        "The Pragmatic Builder"
    ✓ Adaptable, balanced
    ✓ Flexible approach
    ✗ Sometimes lacks conviction
```

---

## API Request/Response Flow

```
CLIENT                          SERVER                    SUPABASE
                                
1. GET /questions
   ──────────────────────────> [Load INTERVIEW_QUESTIONS]
   <────────────────────────── [Return 4 questions]

2. POST /interview/submit
   [{Q1, Answer, Category}]
   ──────────────────────────> [scoreInterviewResponse()]
   <────────────────────────── [Return scores object]

3. POST /profile/generate
   {userId, scores}
   ──────────────────────────> [generateProfile()]
   <────────────────────────── [Return profile + roadmap]

4. POST /profile/save
   {userId, profile, roadmap}
   ──────────────────────────> [getSupabaseClient()]
   ┌─────────────────────────────────────────────────┐
   │ INSERT profiles WHERE user_id = userId          │
   │ INSERT roadmaps WHERE user_id = userId          │
   └─────────────────────────────────────────────────┘
                              ──────────────────────> [Save to Supabase]
   <────────────────────────── [Success response]

5. GET /profile/:userId
   ──────────────────────────> [Query Supabase]
                              ──────────────────────> [SELECT * FROM profiles]
   <────────────────────────── [Return profile JSON]
```

---

## State Management (React)

```
App Component (Main State)
├─ state: "login" | "interview" | "profile" | "dashboard"
├─ userId: string
├─ scores: InterviewScores | null
├─ profile: UserProfile | null
└─ roadmap: Roadmap | null

Transitions:
  login ──(onLogin)──> interview
         ──(onInterviewComplete)──> profile
         ──(onProfileGenerated)──> dashboard
         ──(onLogout)──> login
```

---

## Component Hierarchy

```
<App>
  ├─ {state === "login" && <Login onLogin={} />}
  │
  ├─ {state === "interview" && <Interview 
  │      userId={} 
  │      onComplete={} 
  │  />}
  │   └─ Questions rendered dynamically
  │   └─ onClick handler for options
  │
  ├─ {state === "profile" && <ProfileGenerator 
  │      userId={} 
  │      scores={} 
  │      onProfileGenerated={} 
  │  />}
  │   └─ Fetches from /api/profile/generate
  │   └─ Saves with /api/profile/save
  │
  └─ {state === "dashboard" && <Dashboard 
       profile={} 
       roadmap={} 
       onLogout={} 
     />}
      ├─ <LeftPanel> (Chat history)
      ├─ <CenterPanel> (Roadmap tasks)
      └─ <RightPanel> (The Mirror - metrics)
```

---

## Data Persistence Flow

```
┌─────────────────────────────────────────┐
│  User Completes Interview               │
└────────────┬────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────┐
│  Frontend: Scores Calculated            │
│  POST /profile/generate                 │
└────────────┬────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────┐
│  Backend: Profile Generated             │
│  POST /profile/save                     │
└────────────┬────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────┐
│  Supabase: INSERT INTO profiles         │
│           INSERT INTO roadmaps          │
└────────────┬────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────┐
│  Frontend: Dashboard Rendered           │
│  Data displayed from profile object     │
└─────────────────────────────────────────┘
```

---

## Error Handling Strategy

```
Frontend
├─ Try/Catch on API calls
├─ Display user-friendly error messages
├─ Retry logic for failed requests
└─ Local state fallback

Backend
├─ Validate request payload
├─ Handle Supabase errors
├─ Return meaningful error codes
└─ Log errors for debugging

Database
├─ Unique constraints (user_id)
├─ Foreign key relationships
├─ Timestamps for audit trails
└─ Read/Write permissions
```

---

## Performance Optimization

```
Frontend
├─ Code splitting (Lazy load components)
├─ Image optimization (No images currently)
├─ CSS minification (Vite handles this)
├─ Component memoization (React.memo)
└─ Debouncing for API calls

Backend
├─ Request validation (Prevent bad data)
├─ Connection pooling (Supabase handles)
├─ Caching potential (Redis for interviews)
└─ Query optimization (Indexed user_id)

Database
├─ Indexed primary keys
├─ Indexed foreign keys
└─ Efficient JSON storage
```

---

## Security Considerations

```
Frontend
├─ No sensitive data in localStorage
├─ CORS properly configured
└─ Input validation on forms

Backend
├─ Environment variables for secrets
├─ HTTPS in production
├─ Request size limits
└─ SQL injection prevention (Supabase SDK)

Database
├─ Row-level security (RLS) policies
├─ Anon key with limited permissions
├─ API key rotation in production
└─ Encrypted connections (Supabase default)
```

---

## Deployment Architecture

```
Development
├─ Local: Frontend (3000) + Backend (5000)
├─ Supabase: Cloud database
└─ Hot reload on file changes

Production
├─ Frontend: Vercel / Netlify
│   └─ Serves static React app
├─ Backend: Vercel / Heroku / Railway
│   └─ Node.js server with environment vars
└─ Database: Supabase (same instance)
    └─ Both environments use same DB
```

**Ready to build! Follow SETUP.md to get started.** 🚀
