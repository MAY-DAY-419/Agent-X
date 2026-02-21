# Agent X API Testing & Examples

This guide shows how to test each API endpoint using cURL, Postman, or your browser.

---

## 📡 Testing Setup

### Using cURL (Command Line)

```bash
# Health check
curl http://localhost:5000/api/health

# GET request
curl http://localhost:5000/api/interview/questions

# POST request with data
curl -X POST http://localhost:5000/api/interview/submit \
  -H "Content-Type: application/json" \
  -d '{"responses": [...]}'
```

### Using Postman

1. Download Postman: https://www.postman.com/downloads/
2. Create new request
3. Set method to GET or POST
4. Enter URL: `http://localhost:5000/api/...`
5. Add Headers: `Content-Type: application/json`
6. Add Body (for POST): Raw JSON

### Using VS Code REST Client Extension

1. Install "REST Client" by Huachao Mao
2. Create file: `test.http`
3. Write requests (see examples below)
4. Click "Send Request" above each request

---

## 🔌 API Endpoints

### 1. Health Check

**GET /api/health**

Test if backend is running.

**cURL:**
```bash
curl http://localhost:5000/api/health
```

**Response:**
```json
{
  "status": "OK",
  "timestamp": "2026-02-21T10:30:45.123Z"
}
```

---

### 2. Get Interview Questions

**GET /api/interview/questions**

Returns all 4 interview questions.

**cURL:**
```bash
curl http://localhost:5000/api/interview/questions
```

**Response:**
```json
[
  {
    "id": 1,
    "question": "You have a deadline tomorrow, but a close friend is in crisis...",
    "dimension": "resilience",
    "categories": {
      "stoic": "I'd help my friend—deadlines can be extended...",
      "brutalist": "I'd finish the deadline first, then check on my friend...",
      "emotional": "I'm stressed about both..."
    }
  },
  // ... 3 more questions
]
```

---

### 3. Submit Interview Responses

**POST /api/interview/submit**

Calculate scores from interview answers.

**Request Body:**
```json
{
  "responses": [
    {
      "questionId": 1,
      "answer": "stoic",
      "category": "stoic"
    },
    {
      "questionId": 2,
      "answer": "brutalist",
      "category": "brutalist"
    },
    {
      "questionId": 3,
      "answer": "Intermediate",
      "category": "intermediate"
    },
    {
      "questionId": 4,
      "answer": "I procrastinate",
      "category": "execution"
    }
  ]
}
```

**cURL:**
```bash
curl -X POST http://localhost:5000/api/interview/submit \
  -H "Content-Type: application/json" \
  -d '{
    "responses": [
      {"questionId": 1, "category": "stoic"},
      {"questionId": 2, "category": "brutalist"},
      {"questionId": 3, "category": "intermediate"},
      {"questionId": 4, "category": "execution"}
    ]
  }'
```

**Response:**
```json
{
  "scores": {
    "resilience": {
      "type": "stoic",
      "score": 5
    },
    "execution_style": {
      "type": "brutalist",
      "score": 5
    },
    "academic_baseline": {
      "level": "intermediate",
      "score": 3
    },
    "self_awareness": {
      "pattern": "discipline",
      "score": 4
    }
  },
  "message": "Interview completed successfully"
}
```

---

### 4. Generate Profile

**POST /api/profile/generate**

Create personalized profile from interview scores.

**Request Body:**
```json
{
  "userId": "learner_123",
  "scores": {
    "resilience": {"type": "stoic", "score": 5},
    "execution_style": {"type": "brutalist", "score": 5},
    "academic_baseline": {"level": "intermediate", "score": 3},
    "self_awareness": {"pattern": "discipline", "score": 4}
  }
}
```

**cURL:**
```bash
curl -X POST http://localhost:5000/api/profile/generate \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "learner_123",
    "scores": {
      "resilience": {"type": "stoic", "score": 5},
      "execution_style": {"type": "brutalist", "score": 5},
      "academic_baseline": {"level": "intermediate", "score": 3},
      "self_awareness": {"pattern": "discipline", "score": 4}
    }
  }'
```

**Response:**
```json
{
  "profile": {
    "userId": "learner_123",
    "archetype": "The Brutalist Executor",
    "archetype_description": "You dive in, learn fast, and iterate...",
    "primary_skill_gap": "Discipline & Consistency",
    "tone_preference": "challenge",
    "resilience_score": 5,
    "execution_style": "brutalist",
    "academic_baseline": "intermediate",
    "self_awareness_pattern": "discipline",
    "generated_at": "2026-02-21T10:30:45.123Z"
  },
  "roadmap": {
    "week": 1,
    "profile_id": "learner_123",
    "theme": "Your First Week as The Brutalist Executor",
    "core_task": "✅ **Core Task**: Identify your top blocker...",
    "stretcher": "🔥 **Stretcher (If Brutalist)**: Build a mini-project...",
    "reflection": "💭 **Reflection**: What was hardest this week?..."
  }
}
```

---

### 5. Save Profile to Supabase

**POST /api/profile/save**

Store profile and roadmap in database.

**Request Body:**
```json
{
  "userId": "learner_123",
  "profile": {
    "userId": "learner_123",
    "archetype": "The Brutalist Executor",
    // ... full profile object
  },
  "roadmap": {
    "week": 1,
    // ... full roadmap object
  }
}
```

**cURL:**
```bash
curl -X POST http://localhost:5000/api/profile/save \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "learner_123",
    "profile": { ... },
    "roadmap": { ... }
  }'
```

**Response:**
```json
{
  "success": true,
  "message": "Profile saved successfully"
}
```

---

### 6. Get User Profile

**GET /api/profile/:userId**

Retrieve saved profile from Supabase.

**cURL:**
```bash
curl http://localhost:5000/api/profile/learner_123
```

**Response:**
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "user_id": "learner_123",
  "archetype": "The Brutalist Executor",
  "archetype_description": "You dive in, learn fast, and iterate...",
  "primary_skill_gap": "Discipline & Consistency",
  "tone_preference": "challenge",
  "resilience_score": 5,
  "execution_style": "brutalist",
  "academic_baseline": "intermediate",
  "self_awareness_pattern": "discipline",
  "generated_at": "2026-02-21T10:30:45.123Z"
}
```

---

## 🧪 Complete Flow Test

Test the entire user journey:

### Step 1: Get Questions
```bash
curl http://localhost:5000/api/interview/questions
```

### Step 2: Submit Answers
```bash
curl -X POST http://localhost:5000/api/interview/submit \
  -H "Content-Type: application/json" \
  -d '{
    "responses": [
      {"questionId": 1, "answer": "stoic", "category": "stoic"},
      {"questionId": 2, "answer": "brutalist", "category": "brutalist"},
      {"questionId": 3, "answer": "3", "category": "intermediate"},
      {"questionId": 4, "answer": "discipline", "category": "execution"}
    ]
  }'
```

**Save the scores from response** (you'll need them for step 3).

### Step 3: Generate Profile
```bash
curl -X POST http://localhost:5000/api/profile/generate \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "test_user_123",
    "scores": {
      "resilience": {"type": "stoic", "score": 5},
      "execution_style": {"type": "brutalist", "score": 5},
      "academic_baseline": {"level": "intermediate", "score": 3},
      "self_awareness": {"pattern": "discipline", "score": 4}
    }
  }'
```

**Save the profile and roadmap from response**.

### Step 4: Save to Database
```bash
curl -X POST http://localhost:5000/api/profile/save \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "test_user_123",
    "profile": { ... },
    "roadmap": { ... }
  }'
```

### Step 5: Retrieve Profile
```bash
curl http://localhost:5000/api/profile/test_user_123
```

---

## 📋 REST Client Test File

Create `test.http` in workspace root and use VS Code REST Client:

```http
### Health Check
GET http://localhost:5000/api/health

### Get Questions
GET http://localhost:5000/api/interview/questions

### Submit Interview
POST http://localhost:5000/api/interview/submit
Content-Type: application/json

{
  "responses": [
    {"questionId": 1, "answer": "stoic", "category": "stoic"},
    {"questionId": 2, "answer": "brutalist", "category": "brutalist"},
    {"questionId": 3, "answer": "3", "category": "intermediate"},
    {"questionId": 4, "answer": "discipline", "category": "execution"}
  ]
}

### Generate Profile
POST http://localhost:5000/api/profile/generate
Content-Type: application/json

{
  "userId": "test_user_001",
  "scores": {
    "resilience": {"type": "stoic", "score": 5},
    "execution_style": {"type": "brutalist", "score": 5},
    "academic_baseline": {"level": "intermediate", "score": 3},
    "self_awareness": {"pattern": "discipline", "score": 4}
  }
}

### Save Profile
POST http://localhost:5000/api/profile/save
Content-Type: application/json

{
  "userId": "test_user_001",
  "profile": {
    "userId": "test_user_001",
    "archetype": "The Brutalist Executor",
    "archetype_description": "You dive in, learn fast, and iterate...",
    "primary_skill_gap": "Discipline & Consistency",
    "tone_preference": "challenge",
    "resilience_score": 5,
    "execution_style": "brutalist",
    "academic_baseline": "intermediate",
    "self_awareness_pattern": "discipline",
    "generated_at": "2026-02-21T10:30:45.123Z"
  },
  "roadmap": {
    "week": 1,
    "profile_id": "test_user_001",
    "theme": "Your First Week as The Brutalist Executor",
    "core_task": "✅ **Core Task**: Identify your top blocker...",
    "stretcher": "🔥 **Stretcher (If Brutalist)**: Build a mini-project...",
    "reflection": "💭 **Reflection**: What was hardest this week?..."
  }
}

### Get Profile
GET http://localhost:5000/api/profile/test_user_001
```

Right-click on any request and select "Send Request".

---

## 🔍 Debugging Tips

### Check Backend Logs

Running `npm run dev` in `/server` will show:
- Incoming requests
- Errors (in red)
- Supabase operations

### Check Frontend Console

- Open browser → F12 → Console tab
- Look for axios request/response logs
- Check for JavaScript errors

### Monitor Supabase

1. Go to https://supabase.com/
2. Select your project
3. Go to **SQL Editor** or **Table Editor**
4. See data being inserted in real-time

### Use Browser DevTools Network Tab

- Open F12 → Network tab
- Perform actions in app
- See all API requests/responses
- Check status codes and response bodies

---

## ✅ Common Test Scenarios

### Scenario 1: New User (Stoic Architect)
```json
{
  "userId": "alice_123",
  "responses": [
    {"questionId": 1, "category": "stoic"},
    {"questionId": 2, "category": "analytical"},
    {"questionId": 3, "category": "advanced"},
    {"questionId": 4, "category": "strategy"}
  ]
}
```

Expected: `archetype: "The Analytical Strategist"`

### Scenario 2: Brutalist Learner
```json
{
  "userId": "bob_456",
  "responses": [
    {"questionId": 1, "category": "brutalist"},
    {"questionId": 2, "category": "brutalist"},
    {"questionId": 3, "category": "intermediate"},
    {"questionId": 4, "category": "execution"}
  ]
}
```

Expected: `archetype: "The Brutalist Executor"`, `tone: "challenge"`

### Scenario 3: Beginner Starting Out
```json
{
  "userId": "charlie_789",
  "responses": [
    {"questionId": 1, "category": "emotional"},
    {"questionId": 2, "category": "analytical"},
    {"questionId": 3, "category": "beginner"},
    {"questionId": 4, "category": "external"}
  ]
}
```

Expected: `primary_skill_gap: "Foundations in..."`

---

## 📊 Expected Status Codes

| Code | Meaning |
|------|---------|
| 200 | Success |
| 400 | Bad Request (invalid data) |
| 404 | Not Found (user doesn't exist) |
| 500 | Server Error |

---

**Ready to test! Start your servers with `npm run dev` and try the endpoints above.** 🚀
