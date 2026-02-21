-- Agent X Database Schema
-- Run this in your Supabase SQL Editor if tables don't exist

-- Chat Sessions Table
CREATE TABLE IF NOT EXISTS chat_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL DEFAULT 'New Chat',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Chat Messages Table
CREATE TABLE IF NOT EXISTS chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID NOT NULL REFERENCES chat_sessions(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_chat_messages_session_id ON chat_messages(session_id);
CREATE INDEX IF NOT EXISTS idx_chat_sessions_created_at ON chat_sessions(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_chat_messages_created_at ON chat_messages(created_at);

-- Enable Row Level Security (RLS)
ALTER TABLE chat_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

-- Create policies to allow all operations (for development)
-- WARNING: In production, you should restrict these policies!
DROP POLICY IF EXISTS "Allow all operations on chat_sessions" ON chat_sessions;
CREATE POLICY "Allow all operations on chat_sessions" 
  ON chat_sessions FOR ALL 
  USING (true) 
  WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all operations on chat_messages" ON chat_messages;
CREATE POLICY "Allow all operations on chat_messages" 
  ON chat_messages FOR ALL 
  USING (true) 
  WITH CHECK (true);

-- Verify tables exist
SELECT 'chat_sessions table exists' as status, count(*) as row_count FROM chat_sessions;
SELECT 'chat_messages table exists' as status, count(*) as row_count FROM chat_messages;
