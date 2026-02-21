// Test Supabase connection
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

dotenv.config({ path: join(__dirname, 'server', '.env') });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_API_KEY;

console.log('🔍 Testing Supabase Connection...\n');
console.log('URL:', supabaseUrl);
console.log('Key length:', supabaseKey?.length, 'characters');
console.log('Key preview:', supabaseKey?.substring(0, 20) + '...');

try {
  const supabase = createClient(supabaseUrl, supabaseKey);
  
  console.log('\n✅ Client created successfully');
  console.log('\n📊 Testing table access...');
  
  // Test chat_sessions table
  const { data: sessions, error: sessionsError } = await supabase
    .from('chat_sessions')
    .select('*')
    .limit(5);
  
  if (sessionsError) {
    console.log('❌ Error accessing chat_sessions:', sessionsError.message);
  } else {
    console.log('✅ chat_sessions table accessible');
    console.log('   Found', sessions?.length || 0, 'sessions');
  }
  
  // Test chat_messages table
  const { data: messages, error: messagesError } = await supabase
    .from('chat_messages')
    .select('*')
    .limit(5);
  
  if (messagesError) {
    console.log('❌ Error accessing chat_messages:', messagesError.message);
  } else {
    console.log('✅ chat_messages table accessible');
    console.log('   Found', messages?.length || 0, 'messages');
  }
  
} catch (error) {
  console.error('❌ Fatal error:', error.message);
}
