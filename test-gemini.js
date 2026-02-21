// Test which Gemini models are available
import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI("AIzaSyAApsz_B_tqq99vWV-5kMl40I3TeYUnP9I");

async function testModels() {
  const models = ["gemini-pro", "gemini-1.5-pro", "gemini-1.5-flash", "gemini-1.0-pro"];
  
  for (const modelName of models) {
    try {
      console.log(`\n🧪 Testing ${modelName}...`);
      const model = genAI.getGenerativeModel({ model: modelName });
      const result = await model.generateContent("Say hello");
      const response = await result.response;
      const text = response.text();
      console.log(`✅ ${modelName} works! Response: ${text.substring(0, 50)}...`);
      break; // Found working model!
    } catch (error) {
      console.log(`❌ ${modelName} failed: ${error.message.substring(0, 100)}`);
    }
  }
}

testModels();
