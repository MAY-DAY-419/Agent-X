# Chat Debug Guide

## Quick Checklist

- [ ] Backend running on port 5000?
- [ ] Supabase tables created?
- [ ] ANTHROPIC_API_KEY in server/.env?
- [ ] Frontend running on port 3000?

## Step 1: Verify Backend is Running

```bash
cd server
npm run dev
```

**Expected Output:**
```
🚀 Agent X Server running on port 5000
📍 CORS enabled for: http://localhost:3000
🏥 Health check: http://localhost:5000/api/health
```

**If it fails:** Check if port 5000 is already in use
```bash
# Windows PowerShell - Find process on port 5000
Get-NetTCPConnection -LocalPort 5000 | Select-Object -Property OwningProcess
```

## Step 2: Test Backend Connectivity

Open browser and visit:
```
http://localhost:5000/api/health
```

**Expected Response:**
```json
{"status":"OK","timestamp":"2024-01-01T12:00:00.000Z"}
```

If this fails, backend is not running correctly.

## Step 3: Check Browser Console

1. Open chat page in browser
2. Press `F12` (or `Ctrl+Shift+I`)
3. Go to **Console** tab
4. Try sending a message
5. Look for error messages

**Expected Good Error (if DB not set up):**
```
❌ Cannot connect to server. Is backend running on port 5000?
```

OR

```
Claude response saved but DB error: [specific error]
```

**Expected Bad Error (if backend down):**
```
❌ Cannot connect to server. Is backend running on port 5000?
Error: Failed to fetch
```

## Step 4: Check Network Tab

1. Open `F12` → **Network** tab
2. Send a chat message
3. Look for `POST` request to `localhost:5000/api/chat`
4. Click it and check:
   - **Status:** Should be `200` (success) or `201` (created)
   - **Response:** Should have `message` and `response` fields

**If request doesn't appear:** Backend not running
**If request shows error status:** Backend has a bug

## Step 5: Verify Environment Variables

### Backend (.env)
```bash
# server/.env should have:
SUPABASE_URL=your_url
SUPABASE_KEY=your_key
ANTHROPIC_API_KEY=sk-ant-...
```

To test:
```bash
cd server
node -e "require('dotenv').config(); console.log('ANTHROPIC_API_KEY:', process.env.ANTHROPIC_API_KEY ? '✅ SET' : '❌ NOT SET')"
```

## Step 6: Create Supabase Tables (if not done)

Go to: https://app.supabase.com → Your Project → SQL Editor

Run this SQL:
```sql
-- Check if tables exist
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('chat_sessions', 'chat_messages');

-- If no result, run the creation SQL from SUPABASE_SETUP.sql
```

## Common Errors & Fixes

### ❌ "Cannot connect to server"
- **Cause:** Backend not running or wrong port
- **Fix:** Run `npm run dev` in server folder, check port 5000 is available

### ❌ "Claude API failed: Authentication failed"
- **Cause:** ANTHROPIC_API_KEY not set or invalid
- **Fix:** Add valid key to `server/.env` and restart backend

### ❌ "Cannot insert into chat_messages - table doesn't exist"
- **Cause:** Supabase tables not created
- **Fix:** Run SQL from SUPABASE_SETUP.sql in Supabase dashboard

### ❌ CORS error in console
- **Cause:** CORS not configured correctly
- **Fix:** Backend server configuration already fixed - just restart with `npm run dev`

## Testing Steps

1. **Test 1:** Health check
   ```bash
   curl http://localhost:5000/api/health
   ```

2. **Test 2:** Send fake chat message
   ```bash
   curl -X POST http://localhost:5000/api/chat \
     -H "Content-Type: application/json" \
     -d '{
       "message": "Hello",
       "sessionId": "test-id",
       "assessmentResponses": [],
       "conversationHistory": []
     }'
   ```

3. **Test 3:** Via UI
   - Go to http://localhost:3000
   - Click "Let's Get Started"
   - Answer 5 questions
   - Type message and send

## Logs to Check

### Frontend (Browser Console - F12)
- Look for fetch errors
- Check response status codes
- See what data is being sent

### Backend (Terminal)
- Watch for server startup message
- Look for error logs from routes
- Check database queries

## Still Not Working?

1. **Restart everything:**
   ```bash
   # Kill both servers with Ctrl+C
   # Terminal 1: npm run dev (frontend, port 3000)
   # Terminal 2: cd server && npm run dev (backend, port 5000)
   ```

2. **Check ports:**
   - Frontend: http://localhost:3000
   - Backend: http://localhost:5000/api/health
   - Both should respond

3. **Clear cache:**
   - Browser: Ctrl+Shift+Delete → Clear browsing data
   - npm: `npm cache clean --force`

4. **Check logs:**
   - Frontend: Browser console (F12)
   - Backend: Terminal output

5. **Verify files:**
   - Does `server/src/routes/chat.ts` exist?
   - Does `server/src/utils/chatDb.ts` exist?
   - Does `server/.env` have API keys?
