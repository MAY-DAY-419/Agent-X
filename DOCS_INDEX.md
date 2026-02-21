# 📖 Agent X Documentation Index

Welcome! This is your guide to the **Agent X - Adaptive Learning & Personality Platform**.

---

## 🎯 Start Here

### For First-Time Setup
👉 **[SETUP.md](SETUP.md)** - Complete installation guide (read this first!)
- Prerequisites & dependencies
- Supabase configuration (step-by-step)
- Environment variables
- Run development servers
- Troubleshooting

### For Quick Reference
👉 **[QUICKSTART.md](QUICKSTART.md)** - 5-minute overview
- File structure
- Common commands
- Customization locations
- Pro tips

### For System Understanding
👉 **[ARCHITECTURE.md](ARCHITECTURE.md)** - Technical deep dive
- System flow diagrams
- Technology stack
- Interview scoring algorithm
- API request/response flow
- Data persistence
- State management

### For API Testing
👉 **[API_TESTING.md](API_TESTING.md)** - Complete API reference
- All 6 endpoints with examples
- cURL commands
- Postman setup
- REST Client examples
- Testing scenarios

---

## 📚 Documentation Organization

| File | Purpose | Read If |
|------|---------|---------|
| **BUILD_SUMMARY.md** | Overview of completed build | You just built it |
| **SETUP.md** | Installation & configuration | Starting fresh |
| **QUICKSTART.md** | Quick reference guide | Need quick lookup |
| **ARCHITECTURE.md** | System design & algorithms | Learning how it works |
| **API_TESTING.md** | API endpoints & testing | Want to test endpoints |
| **README.md** | Project overview | Want project info |

---

## 🚀 The Learning Path

### 1. **New to the Project?**
```
SETUP.md → Get everything installed
    ↓
QUICKSTART.md → Understand the structure
    ↓
npm run dev → Launch the app
    ↓
Try the interview flow at http://localhost:3000
```

### 2. **Want to Customize?**
```
QUICKSTART.md (Customization section) → Find which file to edit
    ↓
ARCHITECTURE.md (File locations) → Understand the file
    ↓
Edit the file and save
    ↓
npm run dev will auto-reload
```

### 3. **Want to Test APIs?**
```
API_TESTING.md → Pick an endpoint
    ↓
Use cURL, Postman, or REST Client
    ↓
Send requests to http://localhost:5000/api/*
    ↓
Check response in browser/tool
```

### 4. **Want to Deploy?**
```
README.md (Deployment section)
    ↓
SETUP.md (Build for production section)
    ↓
Follow platform-specific instructions (Vercel, Heroku, etc.)
```

---

## 🔍 What to Read Based on Your Role

### I'm a Developer (Backend)
1. SETUP.md - Get it running
2. ARCHITECTURE.md - Understand the system
3. server/src/logic/interview.ts - See the scoring algorithm
4. API_TESTING.md - Test your endpoints
5. Customize in server/src/logic/profile.ts

### I'm a Developer (Frontend)
1. SETUP.md - Get it running
2. QUICKSTART.md - Understand the structure
3. client/src/App.tsx - See state management
4. client/src/components/ - Understand UI components
5. client/src/styles/ - Customize styling

### I'm a Product Manager
1. README.md - Project overview
2. ARCHITECTURE.md - System flow diagrams
3. QUICKSTART.md - Feature list

### I'm a DevOps Engineer
1. SETUP.md (Deployment section) - Deployment guides
2. ARCHITECTURE.md (Deployment architecture) - How systems connect
3. server/.env.example - Environment configuration

### I'm Managing This Project
1. BUILD_SUMMARY.md - What was delivered
2. QUICKSTART.md - How to run it
3. README.md - Project overview

---

## 📁 File Reference

### Documentation Files
```
/
├── README.md              ← Project overview
├── SETUP.md              ← Installation guide (START HERE)
├── QUICKSTART.md         ← Quick reference
├── ARCHITECTURE.md       ← System design
├── API_TESTING.md        ← API reference
├── BUILD_SUMMARY.md      ← Build completion summary
└── SETUP_DOCS.md         ← This file
```

### Backend (Node.js)
```
server/src/
├── index.ts              ← Express app entry
├── logic/
│   ├── interview.ts      ← Interview Q&A logic
│   └── profile.ts        ← Profile generation
├── routes/
│   ├── interview.ts      ← /api/interview/* endpoints
│   └── profile.ts        ← /api/profile/* endpoints
└── utils/
    └── supabase.ts       ← Database client
```

### Frontend (React)
```
client/src/
├── App.tsx               ← Main component
├── components/
│   ├── Login.tsx         ← Login screen
│   ├── Interview.tsx     ← Interview UI
│   ├── ProfileGenerator.tsx ← Profile generation
│   └── Dashboard.tsx     ← 3-panel dashboard
├── utils/
│   └── api.ts            ← API client
└── styles/
    ├── index.css         ← Global styles
    ├── Login.css
    ├── Interview.css
    ├── Profile.css
    └── Dashboard.css
```

---

## 🎓 Learning the System

### How the App Works (High Level)
1. User enters unique ID → Login screen
2. Answer 4 interview questions → Interview component
3. AI scores the interview → Backend `/api/interview/submit`
4. AI generates profile → Backend `/api/profile/generate`
5. Profile saved to Supabase → Backend `/api/profile/save`
6. Dashboard displays personalized content → React renders profile

### How Scoring Works
- Interview has 4 dimensions: Resilience, Execution, Academic, Self-Awareness
- Each answer maps to a category (stoic, brutalist, analytical, etc.)
- Backend scores answers based on `scoreInterviewResponse()` logic
- Profile determined by combination of scores
- Roadmap tailored to archetype

### How Data Flows
```
Frontend Input → Backend API → Supabase Database → Frontend Display
```

---

## 🔧 Common Customizations

### Change Interview Questions
**File**: `server/src/logic/interview.ts`  
**What**: Edit `INTERVIEW_QUESTIONS` array  
**How**: Add/modify question objects with id, question text, categories

### Add/Modify Archetypes
**File**: `server/src/logic/profile.ts`  
**What**: Edit `ARCHETYPES` object  
**How**: Add new archetype with name, description, tone preference

### Update Dashboard Layout
**File**: `client/src/components/Dashboard.tsx` or `client/src/styles/Dashboard.css`  
**What**: Modify grid layout, colors, spacing  
**How**: Edit CSS grid or React JSX

### Change Colors
**File**: `client/src/styles/index.css`  
**What**: Edit CSS variables (--primary, --secondary, etc.)  
**How**: Change hex color values

---

## 🧪 Testing Workflow

### Unit Testing (Backend)
1. Edit `server/src/logic/interview.ts`
2. Test with API Testing tools (see API_TESTING.md)
3. Use cURL or REST Client to verify

### Integration Testing
1. Start both servers with `npm run dev`
2. Go through complete user flow
3. Check Supabase to verify data saved

### UI Testing
1. Use browser DevTools (F12)
2. Check Console for errors
3. Check Network tab for API calls
4. Test responsive design (mobile, tablet, desktop)

---

## 🚀 Deployment Checklist

- [ ] Read SETUP.md Deployment section
- [ ] Build: `npm run build`
- [ ] Test build locally: `npm run preview`
- [ ] Deploy backend to Heroku/Vercel
- [ ] Deploy frontend to Netlify/Vercel
- [ ] Update `VITE_API_URL` to production backend URL
- [ ] Test all endpoints post-deployment
- [ ] Set up monitoring/logging

---

## 🆘 Getting Help

### If Installation Fails
→ Go to **SETUP.md** Troubleshooting section

### If API Doesn't Work
→ Go to **API_TESTING.md** and test each endpoint

### If You Don't Understand the Architecture
→ Go to **ARCHITECTURE.md** and read System Flow Diagram

### If You Want to Customize
→ Go to **QUICKSTART.md** File Locations section

### If Something is Broken
1. Check browser console (F12)
2. Check terminal logs (backend)
3. Verify `.env` files
4. Run `npm install` again
5. Check Supabase tables exist

---

## 📊 Project Statistics

- **Total Files Created**: 35+
- **Backend Code Files**: 8
- **Frontend Code Files**: 9
- **Style Files**: 5
- **Config Files**: 6
- **Documentation Files**: 6+
- **Total Lines of Code**: 2000+

---

## 🎯 Key Concepts

### Archetypes
4 personality types discovered through interview:
- The Stoic Architect
- The Brutalist Executor
- The Analytical Strategist
- The Pragmatic Builder

### Dimensions
4 aspects tested in interview:
- Resilience (1-5 scale)
- Execution Style (brutalist vs analytical)
- Academic Baseline (beginner to advanced)
- Self-Awareness (discipline vs strategy vs external)

### Roadmap
Weekly learning tasks with:
- Core Task (required)
- Stretcher (optional challenge)
- Reflection (check-in)

### Dashboard
3-panel interface:
- Chat (conversation history)
- Roadmap (weekly tasks)
- Mirror (personality metrics)

---

## 📚 External Resources

- **React**: https://react.dev/
- **TypeScript**: https://www.typescriptlang.org/
- **Express.js**: https://expressjs.com/
- **Supabase**: https://supabase.com/docs
- **Vite**: https://vitejs.dev/

---

## ✅ Success Criteria

### Installation Success
- [ ] `npm install` completes without errors
- [ ] Backend starts on port 5000
- [ ] Frontend starts on port 3000
- [ ] Health check returns OK

### Functionality Success
- [ ] Can log in with any user ID
- [ ] Can answer all 4 interview questions
- [ ] Profile generates with archetype
- [ ] Dashboard displays correctly
- [ ] Data appears in Supabase

### Deployment Success
- [ ] App runs on production URL
- [ ] API endpoints accessible
- [ ] Database connected
- [ ] No errors in browser/server logs

---

## 🎉 Next Steps

1. **Right now**: Read SETUP.md and follow the 5 steps
2. **Then**: Try the app at http://localhost:3000
3. **After**: Customize to your needs using QUICKSTART.md
4. **Finally**: Follow deployment guide in README.md

---

## 📞 Quick Links

| Need Help? | Go To |
|-----------|-------|
| Installation | SETUP.md |
| API Testing | API_TESTING.md |
| System Design | ARCHITECTURE.md |
| Project Overview | README.md |
| Quick Lookup | QUICKSTART.md |
| Build Info | BUILD_SUMMARY.md |

---

**Welcome to Agent X! 🚀**

Start with **[SETUP.md](SETUP.md)** and you'll be up and running in 50 minutes.

*Last Updated: February 21, 2026*
