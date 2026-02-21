# Agent X - Complete Setup Guide

## 🛠️ Prerequisites

- **Node.js** v16+ (Download from https://nodejs.org/)
- **npm** v7+ (comes with Node.js)
- **Supabase** account (Sign up at https://supabase.com/)
- **Git** (optional, for version control)

---

## 📦 Project Structure

```
Agent-X/
├── server/                    # Backend (Node.js + Express)
├── client/                    # Frontend (React + Vite)
├── package.json              # Root package
└── README.md                 # This file
```

---

## ⚙️ Step 1: Supabase Setup

### 1.1 Create Supabase Project

1. Go to https://supabase.com/ and sign in
2. Click **"New Project"**
3. Fill in:
   - **Name**: agent-x-db
   - **Database Password**: (save this!)
   - **Region**: Choose your region
4. Click **"Create new project"** and wait ~2 minutes

### 1.2 Get API Credentials

Once your project is ready:

1. Go to **Settings** → **API**
2. Copy these values:
   - **Project URL** (starts with `https://...supabase.co`)
   - **Anon/Public Key** (under "Project API keys")

Keep these safe—you'll need them in Step 3.

### 1.3 Create Database Tables

Go to **SQL Editor** and run this script:

```sql
-- Profiles Table
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

-- Roadmaps Table
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

-- Interview Responses (Analytics)
CREATE TABLE interview_responses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id TEXT NOT NULL,
  responses JSONB,
  scores JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);
```

Click **"Run"** and verify all 3 tables are created.

---

## 📦 Step 2: Install Dependencies

### 2.1 Install Root Dependencies

```bash
cd "Agent-X"
npm install
```

This installs `concurrently` (runs both servers at once).

### 2.2 Install Server Dependencies

```bash
cd server
npm install
```

Expected packages:
- express
- cors
- dotenv
- @supabase/supabase-js
- typescript
- nodemon (dev)

### 2.3 Install Client Dependencies

```bash
cd ../client
npm install
```

Expected packages:
- react
- react-dom
- vite
- typescript
- axios
- @supabase/supabase-js

Return to root:
```bash
cd ..
```

---

## 🔐 Step 3: Environment Variables

### 3.1 Server Configuration

Create file: `server/.env`

```env
PORT=5000
NODE_ENV=development
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_API_KEY=your_anon_api_key_here
```

**Where to find these values:**
- Go to Supabase → **Settings** → **API**
- Copy "Project URL" and "Anon Public" key

### 3.2 Client Configuration

Create file: `client/.env.local`

```env
VITE_API_URL=http://localhost:5000/api
```

This tells React where to find the backend API.

---

## 🚀 Step 4: Run Development Servers

### Option A: Run Both at Once (Recommended)

From root directory:
```bash
npm run dev
```

This will:
- Start **Backend** on http://localhost:5000
- Start **Frontend** on http://localhost:3000
- Watch for file changes and hot-reload

### Option B: Run Separately

**Terminal 1** (Backend):
```bash
cd server
npm run dev
```

**Terminal 2** (Frontend):
```bash
cd client
npm run dev
```

---

## ✅ Step 5: Verify Setup

### 5.1 Check Backend

Open browser: http://localhost:5000/api/health

Expected response:
```json
{
  "status": "OK",
  "timestamp": "2026-02-21T..."
}
```

### 5.2 Check Frontend

Open browser: http://localhost:3000

Expected to see:
- "Agent X" title
- Login form with input
- "Start The Vibe Check" button

### 5.3 Test Complete Flow

1. **Login**: Enter any user ID (e.g., "learner_123") and click "Start The Vibe Check"
2. **Interview**: Answer 4 questions, click options
3. **Profile**: Wait for "Generating Your Profile..." animation
4. **Dashboard**: See 3-panel layout with your archetype

---

## 📁 File Structure Explained

### Backend Key Files

| File | Purpose |
|------|---------|
| `server/src/index.ts` | Express app setup & routes |
| `server/src/logic/interview.ts` | Scoring algorithm & questions |
| `server/src/logic/profile.ts` | Profile generation & roadmap |
| `server/src/routes/interview.ts` | Interview API endpoints |
| `server/src/routes/profile.ts` | Profile API & Supabase |
| `server/src/utils/supabase.ts` | Supabase client init |

### Frontend Key Files

| File | Purpose |
|------|---------|
| `client/src/App.tsx` | Main state management |
| `client/src/components/Login.tsx` | Login screen UI |
| `client/src/components/Interview.tsx` | Interview UI |
| `client/src/components/ProfileGenerator.tsx` | Profile reveal animation |
| `client/src/components/Dashboard.tsx` | 3-panel dashboard |
| `client/src/utils/api.ts` | Axios API client |
| `client/src/styles/` | CSS for all components |

---

## 🔧 Build for Production

### Build Frontend

```bash
cd client
npm run build
```

Creates optimized build in `client/dist/`

### Build Backend

```bash
cd server
npm run build
```

Creates compiled JS in `server/dist/`

---

## 🚀 Deploy to Production

### Option 1: Vercel (Recommended for Node.js + React)

**Install Vercel CLI:**
```bash
npm install -g vercel
```

**Deploy Backend:**
```bash
vercel --cwd server
```

**Deploy Frontend:**
```bash
vercel --cwd client
```

**Connect to Supabase:**
- Update `VITE_API_URL` in frontend to your deployed backend URL
- Keep Supabase database as-is (already in cloud)

### Option 2: Heroku

**Deploy Backend:**
```bash
heroku login
heroku create agent-x-api
git push heroku main
```

**Set environment variables:**
```bash
heroku config:set SUPABASE_URL=...
heroku config:set SUPABASE_API_KEY=...
```

### Option 3: Docker

Create `Dockerfile` in root:
```dockerfile
FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

WORKDIR /app/server
RUN npm run build

EXPOSE 5000

CMD ["node", "dist/index.js"]
```

---

## 🆘 Troubleshooting

### Problem: "Cannot find module"

```bash
rm -rf node_modules package-lock.json
npm install
```

### Problem: Port 5000 already in use

```bash
# Find what's using port 5000
lsof -i :5000

# Kill the process (macOS/Linux)
kill -9 <PID>

# Or change PORT in server/.env to 5001
```

### Problem: Supabase connection refused

1. Check `SUPABASE_URL` and `SUPABASE_API_KEY` in `server/.env`
2. Verify values match your Supabase project settings
3. Check internet connection
4. Try clearing `node_modules` and reinstalling

### Problem: "CORS error" or "Cannot access from frontend"

1. Verify backend is running on port 5000
2. Check `VITE_API_URL` in `client/.env.local`
3. Verify proxy in `client/vite.config.ts`:

```ts
proxy: {
  "/api": {
    target: "http://localhost:5000",
    changeOrigin: true,
  },
}
```

### Problem: TypeScript compilation errors

```bash
# Clear TypeScript cache
rm -rf server/dist client/.next

# Rebuild
npm run build
```

---

## 📚 Next Steps

1. **Customize Interview Questions**: Edit `server/src/logic/interview.ts`
2. **Add Archetypes**: Edit `server/src/logic/profile.ts` → `ARCHETYPES`
3. **Style Dashboard**: Edit `client/src/styles/Dashboard.css`
4. **Implement Friend-Sync**: Add feedback table + logic
5. **Add Authentication**: Integrate with Supabase Auth

---

## 📖 API Reference

### GET /api/health
Health check endpoint.

### GET /api/interview/questions
Returns all 4 interview questions.

### POST /api/interview/submit
```json
{
  "responses": [
    { "questionId": 1, "answer": "stoic", "category": "stoic" }
  ]
}
```

### POST /api/profile/generate
```json
{
  "userId": "user123",
  "scores": { ... }
}
```

### POST /api/profile/save
Saves profile + roadmap to Supabase.

### GET /api/profile/:userId
Retrieves user profile from database.

---

## 💡 Tips

- **Save often**: Code changes auto-reload with `npm run dev`
- **Check browser console**: DevTools → Console tab for frontend errors
- **Check terminal**: Backend logs appear in terminal
- **Use Supabase UI**: View data directly in Supabase dashboard
- **Test API**: Use Postman or VS Code REST Client to test endpoints

---

**You're all set! Enjoy building Agent X! 🚀**
