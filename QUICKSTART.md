# Agent X - Quick Reference

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| **README.md** | Project overview & quick start |
| **SETUP.md** | Detailed installation & configuration guide |
| **ARCHITECTURE.md** | System design, data flow, algorithms |
| **API_TESTING.md** | API endpoints & testing examples |
| **This File** | Quick reference & checklist |

---

## 🚀 Quick Start (5 Minutes)

### 1. Install Node Dependencies
```bash
npm install
cd server && npm install && cd ../client && npm install && cd ..
```

### 2. Create `.env` Files

**`server/.env`:**
```env
PORT=5000
NODE_ENV=development
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_API_KEY=your-anon-key-here
```

**`client/.env.local`:**
```env
VITE_API_URL=http://localhost:5000/api
```

### 3. Set Up Supabase Tables

Copy & run this SQL in Supabase SQL Editor:

```sql
CREATE TABLE profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id TEXT UNIQUE NOT NULL,
  archetype TEXT NOT NULL,
  archetype_description TEXT,
  primary_skill_gap TEXT,
  tone_preference TEXT,
  resilience_score INT,
  execution_style TEXT,
  academic_baseline TEXT,
  self_awareness_pattern TEXT,
  generated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE roadmaps (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id TEXT NOT NULL,
  week INT,
  theme TEXT,
  core_task TEXT,
  stretcher TEXT,
  reflection TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES profiles(user_id)
);

CREATE TABLE interview_responses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id TEXT NOT NULL,
  responses JSONB,
  scores JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### 4. Run Development Servers
```bash
npm run dev
```

Opens:
- **Frontend**: http://localhost:3000
- **Backend**: http://localhost:5000

---

## 📂 Project Structure at a Glance

```
Agent-X/
├── server/
│   ├── src/
│   │   ├── index.ts              ← Express app
│   │   ├── logic/interview.ts     ← Scoring algorithm
│   │   ├── logic/profile.ts       ← Profile generation
│   │   ├── routes/interview.ts    ← Interview API
│   │   ├── routes/profile.ts      ← Profile API
│   │   └── utils/supabase.ts      ← Database client
│   ├── package.json
│   └── tsconfig.json
│
├── client/
│   ├── src/
│   │   ├── App.tsx                ← Main component + state
│   │   ├── components/
│   │   │   ├── Login.tsx          ← Login screen
│   │   │   ├── Interview.tsx      ← Interview Q&A
│   │   │   ├── ProfileGenerator.tsx ← Profile reveal
│   │   │   └── Dashboard.tsx      ← 3-panel interface
│   │   ├── utils/api.ts           ← API client
│   │   └── styles/                ← CSS files
│   ├── vite.config.ts
│   ├── package.json
│   └── index.html
│
├── README.md
├── SETUP.md
├── ARCHITECTURE.md
├── API_TESTING.md
└── .gitignore
```

---

## 🔑 Key Features Implemented

### Phase 1: Diagnostic Interview ✅
- 4 interactive questions
- Assesses: Resilience, Execution Style, Academic Baseline, Self-Awareness
- No multiple choice—open-ended exploration

### Phase 2: Profile Generation ✅
- 4 personality archetypes
- Skill gap analysis
- Tone preference (encouraging vs challenge)
- Resilience scoring (1-5)

### Phase 3: Adaptive Roadmap ✅
- Core Task (must do)
- Stretcher (optional challenge)
- Reflection (check-in)
- Personalized based on archetype

### Phase 4: Dashboard ✅
- **Left Panel**: Chat history with AI mentor
- **Center Panel**: Weekly roadmap with interactive tasks
- **Right Panel**: "The Mirror" (personality metrics visual)

---

## 🎯 User Archetypes

### The Stoic Architect
- High resilience + strategic execution
- Tone: Encouraging, thoughtful
- Focus: Long-term planning, people-first

### The Brutalist Executor
- Action-first learning + high self-awareness
- Tone: Challenge mode, "roasting" style
- Focus: Fast iteration, breaking things to learn

### The Analytical Strategist
- Methodical planning + systems thinking
- Tone: Encouraging, structured
- Focus: Deep research, detailed planning

### The Pragmatic Builder
- Balanced reflection + action
- Tone: Supportive, flexible
- Focus: Adaptability, real-world application

---

## 🔌 API Quick Reference

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/health` | GET | Health check |
| `/api/interview/questions` | GET | Get 4 interview questions |
| `/api/interview/submit` | POST | Score interview answers |
| `/api/profile/generate` | POST | Create profile from scores |
| `/api/profile/save` | POST | Save profile to Supabase |
| `/api/profile/:userId` | GET | Retrieve saved profile |

---

## 🛠️ Common Commands

```bash
# Development
npm run dev              # Run both servers
npm run dev:frontend    # Frontend only (port 3000)
npm run dev:backend     # Backend only (port 5000)

# Production
npm run build           # Build both
npm run build:frontend  # Build React
npm run build:backend   # Build Node.js

# Testing
curl http://localhost:5000/api/health
```

---

## 📊 Data Flow Summary

```
User Login → Interview (4 Qs) → API /interview/submit → Scores
    ↓
Scores → API /profile/generate → Profile + Roadmap
    ↓
Profile → API /profile/save → Supabase (INSERT)
    ↓
Dashboard Renders Data from Profile Object
```

---

## ⚙️ Configuration Files

### server/.env
```env
PORT=5000
NODE_ENV=development
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_API_KEY=your-anon-key
```

### client/.env.local
```env
VITE_API_URL=http://localhost:5000/api
```

### client/vite.config.ts
```ts
proxy: {
  "/api": {
    target: "http://localhost:5000",
    changeOrigin: true,
  },
}
```

---

## 🎨 Styling Guide

All CSS is modular:

| Component | File |
|-----------|------|
| Login form | `Login.css` |
| Interview questions | `Interview.css` |
| Profile reveal | `Profile.css` |
| 3-panel dashboard | `Dashboard.css` |
| Global styles | `index.css` |

Colors:
```css
--primary: #2563eb      /* Blue */
--secondary: #1e40af    /* Dark blue */
--success: #16a34a      /* Green */
--danger: #dc2626       /* Red */
--dark: #1f2937         /* Dark gray */
--light: #f3f4f6        /* Light gray */
```

---

## 🆘 Troubleshooting Checklist

- ❌ **Port 5000 in use?**  
  → Change `PORT=5001` in `server/.env`

- ❌ **CORS error?**  
  → Check `VITE_API_URL` matches backend URL

- ❌ **Supabase won't connect?**  
  → Verify `.env` has correct URL & API key

- ❌ **"Cannot find module"?**  
  → Run `npm install` in both server & client

- ❌ **TypeScript errors?**  
  → Run `npm run build` to see full errors

---

## 🚀 Next Steps

1. **Complete Setup Using SETUP.md** (detailed 5-step guide)
2. **Test API Using API_TESTING.md** (try all endpoints)
3. **Understand Architecture** (read ARCHITECTURE.md)
4. **Customize**:
   - Edit interview questions in `server/src/logic/interview.ts`
   - Add/modify archetypes in `server/src/logic/profile.ts`
   - Style dashboard in `client/src/styles/Dashboard.css`
5. **Deploy**:
   - Frontend to Vercel/Netlify
   - Backend to Vercel/Heroku
   - Keep Supabase database (no deployment needed)

---

## 📞 File Locations for Customization

### To change interview questions:
`server/src/logic/interview.ts` → `INTERVIEW_QUESTIONS` array

### To modify archetypes:
`server/src/logic/profile.ts` → `ARCHETYPES` object

### To update roadmap tasks:
`server/src/logic/profile.ts` → `generateCoreTask()`, `generateStretcher()`, `generateReflection()`

### To adjust UI text:
Individual component files in `client/src/components/`

### To change colors:
`client/src/styles/index.css` → CSS variables (--primary, --secondary, etc.)

---

## 📈 Feature Roadmap

### ✅ Completed (MVP)
- Diagnostic interview (4 questions)
- Profile generation (4 archetypes)
- Adaptive roadmap (core/stretcher/reflection)
- 3-panel dashboard
- Supabase integration

### 🔄 In Progress
- Friend-Sync (360° feedback via unique link)
- Task tracking (mark tasks complete)
- Chat history enhancement

### 📋 Future
- Multi-week progression tracking
- AI-powered adaptive difficulty adjustment
- Mobile app (React Native)
- Social features (leaderboards, groups)
- Advanced analytics dashboard

---

## 🎓 Learning Resources

- **TypeScript**: https://www.typescriptlang.org/docs/
- **React**: https://react.dev/
- **Express.js**: https://expressjs.com/
- **Supabase**: https://supabase.com/docs
- **Vite**: https://vitejs.dev/guide/

---

## 📝 Version Info

- **Node.js**: 16+
- **React**: 18+
- **Express**: 4.18+
- **TypeScript**: 5+
- **Supabase**: Latest

---

## 💡 Pro Tips

1. **Use VS Code** with REST Client extension for API testing
2. **Check Supabase UI** in real-time to verify data saves
3. **Use browser DevTools** (F12 → Network tab) to debug requests
4. **Enable TypeScript strict mode** to catch errors early
5. **Commit often** with clear messages

---

**You have everything you need to build Agent X! Start with SETUP.md and enjoy the journey.** 🚀

Questions? Refer to:
- SETUP.md (installation)
- API_TESTING.md (endpoints)
- ARCHITECTURE.md (design)
