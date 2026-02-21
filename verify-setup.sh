#!/bin/bash
# This file helps verify the Agent X project is properly set up

echo "🔍 Checking Agent X Project Structure..."
echo ""

# Check directories
echo "✓ Checking directories..."
test -d server && echo "  ✓ server/" || echo "  ✗ server/ MISSING"
test -d client && echo "  ✓ client/" || echo "  ✗ client/ MISSING"
test -d server/src && echo "  ✓ server/src/" || echo "  ✗ server/src/ MISSING"
test -d client/src && echo "  ✓ client/src/" || echo "  ✗ client/src/ MISSING"
echo ""

# Check server files
echo "✓ Checking server files..."
test -f server/package.json && echo "  ✓ server/package.json" || echo "  ✗ server/package.json MISSING"
test -f server/tsconfig.json && echo "  ✓ server/tsconfig.json" || echo "  ✗ server/tsconfig.json MISSING"
test -f server/src/index.ts && echo "  ✓ server/src/index.ts" || echo "  ✗ server/src/index.ts MISSING"
test -f server/src/logic/interview.ts && echo "  ✓ server/src/logic/interview.ts" || echo "  ✗ server/src/logic/interview.ts MISSING"
test -f server/src/logic/profile.ts && echo "  ✓ server/src/logic/profile.ts" || echo "  ✗ server/src/logic/profile.ts MISSING"
test -f server/src/routes/interview.ts && echo "  ✓ server/src/routes/interview.ts" || echo "  ✗ server/src/routes/interview.ts MISSING"
test -f server/src/routes/profile.ts && echo "  ✓ server/src/routes/profile.ts" || echo "  ✗ server/src/routes/profile.ts MISSING"
test -f server/src/utils/supabase.ts && echo "  ✓ server/src/utils/supabase.ts" || echo "  ✗ server/src/utils/supabase.ts MISSING"
echo ""

# Check client files
echo "✓ Checking client files..."
test -f client/package.json && echo "  ✓ client/package.json" || echo "  ✗ client/package.json MISSING"
test -f client/tsconfig.json && echo "  ✓ client/tsconfig.json" || echo "  ✗ client/tsconfig.json MISSING"
test -f client/vite.config.ts && echo "  ✓ client/vite.config.ts" || echo "  ✗ client/vite.config.ts MISSING"
test -f client/index.html && echo "  ✓ client/index.html" || echo "  ✗ client/index.html MISSING"
test -f client/src/App.tsx && echo "  ✓ client/src/App.tsx" || echo "  ✗ client/src/App.tsx MISSING"
test -f client/src/App.css && echo "  ✓ client/src/App.css" || echo "  ✗ client/src/App.css MISSING"
test -f client/src/main.tsx && echo "  ✓ client/src/main.tsx" || echo "  ✗ client/src/main.tsx MISSING"
test -f client/src/index.css && echo "  ✓ client/src/index.css" || echo "  ✗ client/src/index.css MISSING"
echo ""

# Check components
echo "✓ Checking components..."
test -f client/src/components/Login.tsx && echo "  ✓ client/src/components/Login.tsx" || echo "  ✗ client/src/components/Login.tsx MISSING"
test -f client/src/components/Interview.tsx && echo "  ✓ client/src/components/Interview.tsx" || echo "  ✗ client/src/components/Interview.tsx MISSING"
test -f client/src/components/ProfileGenerator.tsx && echo "  ✓ client/src/components/ProfileGenerator.tsx" || echo "  ✗ client/src/components/ProfileGenerator.tsx MISSING"
test -f client/src/components/Dashboard.tsx && echo "  ✓ client/src/components/Dashboard.tsx" || echo "  ✗ client/src/components/Dashboard.tsx MISSING"
echo ""

# Check styles
echo "✓ Checking styles..."
test -f client/src/styles/index.css && echo "  ✓ client/src/styles/index.css" || echo "  ✗ client/src/styles/index.css MISSING"
test -f client/src/styles/Login.css && echo "  ✓ client/src/styles/Login.css" || echo "  ✗ client/src/styles/Login.css MISSING"
test -f client/src/styles/Interview.css && echo "  ✓ client/src/styles/Interview.css" || echo "  ✗ client/src/styles/Interview.css MISSING"
test -f client/src/styles/Profile.css && echo "  ✓ client/src/styles/Profile.css" || echo "  ✗ client/src/styles/Profile.css MISSING"
test -f client/src/styles/Dashboard.css && echo "  ✓ client/src/styles/Dashboard.css" || echo "  ✗ client/src/styles/Dashboard.css MISSING"
echo ""

# Check documentation
echo "✓ Checking documentation..."
test -f README.md && echo "  ✓ README.md" || echo "  ✗ README.md MISSING"
test -f SETUP.md && echo "  ✓ SETUP.md" || echo "  ✗ SETUP.md MISSING"
test -f ARCHITECTURE.md && echo "  ✓ ARCHITECTURE.md" || echo "  ✗ ARCHITECTURE.md MISSING"
echo ""

echo "✅ Project structure verification complete!"
