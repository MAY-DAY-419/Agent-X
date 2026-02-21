# 🗄️ Supabase Setup for Chat History

## ✅ What You Need to Do

### Step 1: Go to Supabase Console
1. Visit **https://app.supabase.com**
2. Open your Agent X project
3. Click on **SQL Editor** in the left sidebar

### Step 2: Create Tables
Copy the entire SQL from below and paste it into Supabase SQL Editor:

```sql
-- Chat Sessions Table
CREATE TABLE chat_sessions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Chat Messages Table
CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_id UUID NOT NULL REFERENCES chat_sessions(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for faster queries
CREATE INDEX idx_chat_messages_session_id ON chat_messages(session_id);
CREATE INDEX idx_chat_sessions_created_at ON chat_sessions(created_at DESC);

-- Enable RLS (Row Level Security) if needed
ALTER TABLE chat_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

-- Create policies to allow all access (for now - adjust for production)
CREATE POLICY "Allow all access on chat_sessions" ON chat_sessions
  FOR ALL USING (true);

CREATE POLICY "Allow all access on chat_messages" ON chat_messages
  FOR ALL USING (true);
```

### Step 3: Execute
Click the **"Run"** button (or press Ctrl+Enter) to create the tables.

### Step 4: Verify
You should see ✅ success message. Check the left sidebar - you'll see:
- `chat_sessions` table
- `chat_messages` table

---

## 📊 Table Structure

### `chat_sessions`
```
id (UUID) - Primary key
title (TEXT) - Chat title/name
created_at (TIMESTAMP) - When created
updated_at (TIMESTAMP) - When updated
```

### `chat_messages`
```
id (UUID) - Primary key
session_id (UUID) - Links to chat_sessions
role (TEXT) - "user" or "assistant"
content (TEXT) - Message content
created_at (TIMESTAMP) - When sent
```

---

## 🔧 What's Now Fixed

✅ **Chat Endpoint Fixed** - Better error handling and logging  
✅ **Session ID Required** - Chat now tracks which session messages belong to  
✅ **Database Integration** - Messages saved to Supabase  
✅ **Error Messages** - Detailed error reporting  
✅ **Message History** - Persistent across sessions  

---

## 🚀 Test It Now

1. **Ensure backend is running:** `npm run dev`
2. **Visit landing page:** http://localhost:3000
3. **Go through flow:**
   - Landing → Assessment (5 Q's) → Chat Dashboard
4. **Chat now works with:**
   - Persistent chat history
   - Session management
   - Database storage
   - Better error messages

---

## 🐛 If You Still Get Errors

**Check the console logs:**
1. Open Chrome DevTools (F12)
2. Go to **Console** tab
3. Check for error messages
4. Also check your **terminal** where `npm run dev` is running

**Common issues:**
- ❌ "Session ID is required" → Make sure chatbot has session ID
- ❌ "Claude API failed" → Check ANTHROPIC_API_KEY in server/.env
- ❌ Database errors → Run SQL script again in Supabase

---

## 📝 Files Updated

- ✅ `SUPABASE_SETUP.sql` - SQL table creation script
- ✅ `server/src/utils/chatDb.ts` - NEW database functions
- ✅ `server/src/routes/chat.ts` - Enhanced error handling
- ✅ `client/src/components/ChatDashboard.tsx` - Better error messages
- ✅ `server/src/index.ts` - Chat routes imported

Ready to create tables? Head to Supabase! 🚀
