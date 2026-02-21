// Quick test script to verify backend is responding
console.log("🧪 Testing backend connectivity...\n");

async function testBackend() {
  try {
    console.log("1️⃣ Testing health endpoint...");
    const healthResponse = await fetch("http://localhost:5000/api/health");
    const healthData = await healthResponse.json();
    console.log("✅ Health check passed:", healthData);
    console.log("Response status:", healthResponse.status);

    console.log("\n2️⃣ Testing chat endpoint (will fail without proper data, but shows if endpoint exists)...");
    const chatResponse = await fetch("http://localhost:5000/api/chat", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        message: "test",
        sessionId: "test-id",
        assessmentResponses: {},
        conversationHistory: [],
      }),
    });
    console.log("Response status:", chatResponse.status);
    const chatData = await chatResponse.json();
    console.log("Response:", chatData);

    console.log("\n✅ Backend is responding!");
  } catch (error) {
    console.error("❌ Error:", error.message);
    console.log("\n⚠️ Backend is NOT responding.");
    console.log("Make sure to run: cd server && npm run dev");
  }
}

testBackend();
