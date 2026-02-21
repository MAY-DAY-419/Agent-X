# 🔐 Credentials Setup Guide

## ✅ Your Credentials Saved

Your Supabase credentials have been added to `server/.env`. Now you need to add your Claude Anthropic API key.

---

## 📍 Where to Paste Your Claude API Key

### Location: `server/.env`

Open the file: `server/.env`

Find this line:
```env
ANTHROPIC_API_KEY=paste_your_claude_anthropic_sonnet_4_5_key_here
```

Replace `paste_your_claude_anthropic_sonnet_4_5_key_here` with your actual Claude Sonnet 4.5 key.

**Example:**
```env
ANTHROPIC_API_KEY=sk_ant_v1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

## 🛡️ Security Notes

### ⚠️ NEVER Share These Files
- `server/.env` - Contains Supabase & Claude keys
- `client/.env.local` - Contains API URL
- These are in `.gitignore` and won't be committed to Git

### ✅ What's Currently in Your Files

**`server/.env`:**
```env
SUPABASE_URL=https://tpqhpiuchvccgwywvelr.supabase.co
SUPABASE_API_KEY=sb_publishable_P5vNM6rjtkdjovobEfAmdw_XrBYVkxE
SUPABASE_DB_PASSWORD=!kPAt*+@x/Ype7u
ANTHROPIC_API_KEY=<PASTE YOUR KEY HERE>
```

**`client/.env.local`:**
```env
VITE_API_URL=http://localhost:5000/api
```

---

## 🔑 Getting Your Claude API Key

1. Go to: https://console.anthropic.com/account/keys
2. Sign in with your Anthropic/Claude account
3. Create new API key (if you don't have one)
4. Copy the key starting with `sk_ant_...`
5. Paste it in `server/.env` (replace the placeholder)

---

## 🚀 How These Credentials Are Used

### Supabase (Backend Database)
```typescript
// In server/src/utils/supabase.ts
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_API_KEY;
const client = createClient(supabaseUrl, supabaseKey);
```

Uses:
- Store user profiles
- Store interview responses
- Store learning roadmaps

### Claude API (Future AI Features)
```typescript
// Will be used in Phase 3-4 for:
// - Adaptive learning recommendations
// - Personalized feedback
// - Dynamic roadmap generation

const client = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY,
});

const message = await client.messages.create({
  model: "claude-3-5-sonnet-20241022",
  max_tokens: 1024,
  messages: [{ role: "user", content: "..." }],
});
```

---

## ✅ Environment File Locations

```
Agent-X/
├── server/
│   └── .env                    ← Paste Claude key here!
├── client/
│   └── .env.local              ← Already configured
└── .gitignore                  ← Protects .env files
```

---

## 📋 Setup Checklist

- [x] Supabase URL configured
- [x] Supabase API Key configured
- [x] Database password saved
- [ ] Claude API Key pasted in `server/.env`
- [ ] `server/.env` file is in `.gitignore` ✓
- [ ] `client/.env.local` file is in `.gitignore` ✓

---

## 🔍 Next Steps

1. **Open `server/.env` in your editor**
2. **Find the line:** `ANTHROPIC_API_KEY=paste_your_claude_anthropic_sonnet_4_5_key_here`
3. **Replace the placeholder** with your actual Claude key
4. **Save the file**
5. **Run:** `npm install && npm run dev`

---

## ⚡ Quick Reference

| Variable | File | Current Status | Notes |
|----------|------|-----------------|-------|
| `SUPABASE_URL` | server/.env | ✅ Set | Database location |
| `SUPABASE_API_KEY` | server/.env | ✅ Set | Public key (safe) |
| `SUPABASE_DB_PASSWORD` | server/.env | ✅ Set | Database password |
| `ANTHROPIC_API_KEY` | server/.env | ⏳ Waiting | Paste your Claude key |
| `VITE_API_URL` | client/.env.local | ✅ Set | Backend API location |

---

## 🚨 Troubleshoot

### Error: "ANTHROPIC_API_KEY is not set"
**Solution:** Make sure you:
1. Opened `server/.env` (not `.example`)
2. Added your actual Claude key
3. Saved the file
4. Restarted the development server

### Error: "Cannot read .env file"
**Solution:** Make sure file is at:
```
Agent-X/server/.env
```
(Not in root or client directory)

### Error: "Supabase connection failed"
**Solution:** Verify:
1. SUPABASE_URL is correct
2. SUPABASE_API_KEY is correct
3. Your Supabase project is active
4. You have internet connection

---

## 💡 Best Practices

1. **Never commit `.env` files** ← Already in `.gitignore`
2. **Never share API keys** in messages, screenshots, or code
3. **Rotate keys regularly** in production
4. **Use different keys** for dev/prod environments
5. **Keep backup of keys** in secure location (password manager)

---

**Status: Ready for Claude API key! 🚀**
